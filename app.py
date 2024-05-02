
from flask import Flask, request, jsonify


from model import FoodDataModel;
db_uri = "mongodb+srv://mayselmi:maysaharselim@safepick.gqdzswq.mongodb.net"
db_name = "Safepick"
collection_name = "food"
food_data_model = FoodDataModel(db_uri, db_name, collection_name)
app = Flask(__name__)

@app.route('/query', methods=['POST'])
def query():
    user_query = request.json['query']
    results = food_data_model.search_query(user_query)
    return jsonify(results)

if __name__ == '__main__':
    app.run(debug=True)

