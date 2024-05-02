import nltk
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from pymongo import MongoClient

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
            processed_text = self.preprocess_text(doc.get('product_name', 'Unknown'),)  # Assuming 'product_name' is always present
            documents.append(processed_text)
            details = {
        'pnns_groups_1': doc.get('pnns_groups_1', 'Unknown'),
        'pnns_groups_2': doc.get('pnns_groups_2', 'Unknown'),
        'food_groups': doc.get('food_groups', 'Unknown'),
        'food_groups_tags': doc.get('food_groups_tags', 'Unknown'),
        'food_groups_en': doc.get('food_groups_en', 'Unknown'),
        'energy_kcal_100g': doc.get('energy_kcal_100g', 'Unknown'),
        'fat_100g': doc.get('fat_100g', 'Unknown'),
        'saturated_fat_100g': doc.get('saturated-fat_100g', 'Unknown'),
        'trans_fat_100g': doc.get('trans-fat_100g', 'Unknown'),
        'cholesterol_100g': doc.get('cholesterol_100g', 'Unknown'),
        'carbohydrates_100g': doc.get('carbohydrates_100g', 'Unknown'),
        'sugars_100g': doc.get('sugars_100g', 'Unknown'),
        'fiber_100g': doc.get('fiber_100g', 'Unknown'),
        'proteins_100g': doc.get('proteins_100g', 'Unknown'),
        'salt_100g': doc.get('salt_100g', 'Unknown'),
        'sodium_100g': doc.get('sodium_100g', 'Unknown'),
        'vitamin_a_100g': doc.get('vitamin-a_100g', 'Unknown'),
        'vitamin_c_100g': doc.get('vitamin-c_100g', 'Unknown'),
        'potassium_100g': doc.get('potassium_100g', 'Unknown'),
        'calcium_100g': doc.get('calcium_100g', 'Unknown'),
        'iron_100g': doc.get('iron_100g', 'Unknown'),
        'nutrition_score_fr_100g': doc.get('nutrition-score-fr_100g', 'Unknown')
    }
            document_details.append(details)
        
        # Create the TF-IDF matrix after all documents are processed
        tfidf_matrix = self.vectorizer.fit_transform(documents)
        return documents, document_details, tfidf_matrix

    def search_query(self, query):
        query_text = self.preprocess_text(query)
        query_vector = self.vectorizer.transform([query_text])
        similarity_scores = cosine_similarity(query_vector, self.tfidf_matrix)

        # Extract top 5 similar items
        top_indices = similarity_scores.argsort()[0][-5:][::-1]
        results = [self.document_details[idx] for idx in top_indices]  # Now returning full details
        return results