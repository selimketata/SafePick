
from flask import Flask, request, jsonify
from model import FoodDataModel;
from flask_cors import CORS


db_uri = "mongodb+srv://mayselmi:maysaharselim@safepick.gqdzswq.mongodb.net"
db_name = "Safepick"
collection_name = "food"
food_data_model = FoodDataModel(db_uri, db_name, collection_name)
app = Flask(__name__)
CORS(app)

@app.route('/query', methods=['POST'])
def query():
    user_query = request.json['query']
    print("Received query:", user_query)  # Log the received query
    results = food_data_model.search_query(user_query)
    print("Sent response:", results)  # Log the response
    return jsonify(results)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)


