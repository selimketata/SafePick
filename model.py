import nltk
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from pymongo import MongoClient
from flask import Flask, request, jsonify

# Ensure that the required NLTK resources are downloaded
nltk.download('punkt', quiet=True)
nltk.download('wordnet', quiet=True)

class FoodDataModel:
    def __init__(self, db_uri, db_name, collection_name):
        self.client = MongoClient(db_uri)
        self.db = self.client[db_name]
        self.collection = self.db[collection_name]
        self.vectorizer = TfidfVectorizer()
        self.documents, self.document_details, self.tfidf_matrix = self.load_data()
        self.last_shown_index = -1  # Initialize the index

    def preprocess_text(self, text):
        """Clean and preprocess text for vectorization."""
        lemmer = WordNetLemmatizer()
        words = [lemmer.lemmatize(word) for word in word_tokenize(text.lower()) if word.isalnum()]
        return ' '.join(words)

    def load_data(self):
        """Load and preprocess text data from MongoDB, then vectorize it using TF-IDF."""
        documents = []
        document_details = []
        for doc in self.collection.find():
            processed_text = self.preprocess_text(doc.get('product_name', 'Unknown'))
            documents.append(processed_text)
            details = {key: doc.get(key, 'Unknown') for key in [
                'product_name', 'pnns_groups_1', 'pnns_groups_2', 'food_groups',
                'food_groups_tags', 'food_groups_en', 'energy_kcal_100g', 'fat_100g',
                'saturated_fat_100g', 'trans_fat_100g', 'cholesterol_100g',
                'carbohydrates_100g', 'sugars_100g', 'fiber_100g', 'proteins_100g',
                'salt_100g', 'sodium_100g', 'vitamin_a_100g', 'vitamin_c_100g',
                'potassium_100g', 'calcium_100g', 'iron_100g', 'nutrition_score_fr_100g'
            ]}
            document_details.append(details)
        self.tfidf_matrix = self.vectorizer.fit_transform(documents)
        return documents, document_details, self.tfidf_matrix

    def get_next_product(self):
        """Return the next product's details."""
        if self.last_shown_index < len(self.document_details) - 1:
            self.last_shown_index += 1
            return self.document_details[self.last_shown_index]
        return "No more products."

    def handle_query(self, query):
        query_lower = query.lower()
        if "give me the ingredients" in query_lower:
            self.last_shown_index = -1  # Reset index
            return self.get_next_product()
        elif "give me more" in query_lower:
            return self.get_next_product()
        else:
            return self.search_query(query)

    def search_query(self, query):
        """Process and respond to a search query."""
        query_text = self.preprocess_text(query)
        query_vector = self.vectorizer.transform([query_text])
        similarity_scores = cosine_similarity(query_vector, self.tfidf_matrix)
        top_index = similarity_scores.argsort()[0][-1]
        self.last_shown_index = top_index
        return self.document_details[top_index]