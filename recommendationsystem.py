from flask import Flask, jsonify
from pymongo import MongoClient, DESCENDING
import threading
import pandas as pd
from sklearn.decomposition import TruncatedSVD
import numpy as np


app = Flask(__name__)
def watch_user_changes_c():
    """Watch for changes in the food.users collection and update recommendations."""
    client = MongoClient('mongodb+srv://mayselmi:maysaharselim@safepick.gqdzswq.mongodb.net/')
    db = client['Safepick']
    user_collection = db['cosmetics.users']

    # Open a change stream to watch for changes to the user collection
    with user_collection.watch() as stream:
        for change in stream:
            print(f"Detected change: {change}")  # Logging the change for debugging
            update_recommendations_c()  # Trigger recommendation update process


def update_recommendations_c():
    client = MongoClient('mongodb+srv://mayselmi:maysaharselim@safepick.gqdzswq.mongodb.net/')
    db = client['Safepick']
    user_collection = db['cosmetics.users']
    food_collection = db['cosmetics']

    # Process each user profile to generate recommendations
    user_profiles = user_collection.find({})
    for user_profile in user_profiles:
        email = user_profile['email']
        # Fetch top clicked products
        clicked_products_sorted = sorted(user_profile['codes'], key=lambda x: x['count'], reverse=True)[:3]
        product_codes = [product['code'] for product in clicked_products_sorted]
        categories = set()

        for code in product_codes:
            food_category = food_collection.find_one({'code': code})
            if food_category:
                categories.add(food_category.get('category'))

        recommended_products = []
        for category in categories:
            if category:
                similar_products_cursor = food_collection.find(
                    {'$or': [{'category': category}],
                     'score': {'$gt': 80}},
                    # sort=[('nutriscore_score_out_of_100', pymongo.DESCENDING)],
                    projection={'code': 1}
                ).limit(2)

                recommended_products.extend([product['code'] for product in similar_products_cursor if 'code' in product])

        # Update the recommendations in MongoDB
        food_recommendations_db = db['cosmetics_recommendations']
        food_recommendations_db.recommendations.update_one(
            {'email': email},
            {'$set': {'recommended_products': list(set(recommended_products+ db['cosmetics_recommendations.recommendations'].find_one({'email': email})['recommended_products']))}},
            upsert=True
        )


def watch_user_changes():
    """Watch for changes in the food.users collection and update recommendations."""
    client = MongoClient('mongodb+srv://mayselmi:maysaharselim@safepick.gqdzswq.mongodb.net/')
    db = client['Safepick']
    user_collection = db['food.users']

    # Open a change stream to watch for changes to the user collection
    with user_collection.watch() as stream:
        for change in stream:
            print(f"Detected change: {change}")  # Logging the change for debugging
            update_recommendations()  # Trigger recommendation update process


def update_recommendations():
    client = MongoClient('mongodb+srv://mayselmi:maysaharselim@safepick.gqdzswq.mongodb.net/')
    db = client['Safepick']
    user_collection = db['food.users']
    food_collection = db['food']

    # Process each user profile to generate recommendations
    user_profiles = user_collection.find({})
    for user_profile in user_profiles:
        email = user_profile['email']
        # Fetch top clicked products
        clicked_products_sorted = sorted(user_profile['codes'], key=lambda x: x['count'], reverse=True)[:3]
        product_codes = [product['code'] for product in clicked_products_sorted]
        categories = set()

        for code in product_codes:
            food_category = food_collection.find_one({'code': code})
            if food_category:
                categories.add(food_category.get('pnns_groups_1'))
                categories.add(food_category.get('pnns_groups_2'))

        recommended_products = []
        for category in categories:
            if category:
                similar_products_cursor = food_collection.find(
                    {'$or': [{'pnns_groups_1': category}, {'pnns_groups_2': category}],
                     'nutriscore_score_out_of_100': {'$gt': 90}},
                    # sort=[('nutriscore_score_out_of_100', pymongo.DESCENDING)],
                    projection={'code': 1}
                ).limit(2)

                recommended_products.extend([product['code'] for product in similar_products_cursor if 'code' in product])

        # Update the recommendations in MongoDB
        food_recommendations_db = db['food_recommendations']
        food_recommendations_db.recommendations.update_one(
            {'email': email},
            {'$set': {'recommended_products': list(set(recommended_products))}},
            upsert=True
        )

    # Now let's process the data for the recommendation matrix
    data = user_collection.find({})
    table_data = {}
    for record in data:
        user_id = record['user_id']
        for product in record['codes']:
            product_code = product['code']
            random_number = product['count']
            if product_code not in table_data:
                table_data[product_code] = {}
            table_data[product_code][user_id] = 1 if random_number != 0 else 0

    df = pd.DataFrame.from_dict(table_data, orient='index').fillna(0)
    X = df.T

    # Perform SVD and calculate correlation matrix
    SVD = TruncatedSVD(n_components=6)
    decomposed_matrix = SVD.fit_transform(X)
    correlation_matrix = np.corrcoef(decomposed_matrix)

    # Generate recommendations based on the correlation matrix
    recommended = {}
    n, m = correlation_matrix.shape
    for i in range(n):
        user_id = X.index[i]
        recommended[user_id] = []
        for j in range(m):
            if correlation_matrix[i, j] > 0.7 and i != j:
                for k in range(X.shape[1]):
                    if X.iloc[j, k] == 1 and X.iloc[i, k] != 1:
                        product_id = X.columns[k]
                        recommended[user_id].append(product_id)

    # Update the user recommendations in MongoDB
    for user_id, product_ids in recommended.items():
        if product_ids:
            food_recommendations_db.recommendations.update_one(
                {'user_id': user_id},
                {'$set': {'recommended_products': list(set(product_ids + db['food_recommendations.recommendations'].find_one({'user_id': user_id})['recommended_products']))}},
                upsert=True
            )

    print("Recommendations updated")


@app.route('/')
def index():
    return jsonify({"message": "Welcome to the real-time recommendation system!"})


def run_app():
    """Run the Flask application."""
    app.run(debug=True, use_reloader=False)



if __name__ == '__main__':
    # Use threading to run the Flask app and the Change Stream watcher
    threading.Thread(target=run_app).start()
    watch_user_changes()
    watch_user_changes_c()
