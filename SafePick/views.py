from django.http import JsonResponse
import pymongo
from bson import ObjectId  # Import ObjectId from bson module
from django.conf import settings
from django.http import JsonResponse
from .models import ProductF,ProductC
from .serializers import ProductFSerializer
import base64


def get_productF(request, product_code):
    my_client = pymongo.MongoClient(settings.DB_NAME)
    dbname = my_client['Safepick']
    collection_name = dbname["food"]
    try:
        product = collection_name.find_one({'code': product_code})
        if product:
            if isinstance(product['background_removed_image'], bytes):
                product['background_removed_image'] = base64.b64encode(product['background_removed_image']).decode('utf-8')
            serializer = ProductFSerializer(product)  # Create an instance of the serializer
            return JsonResponse(serializer.data, status=200, safe=False)  # Serialize the data
        else:
            return JsonResponse({'error': 'Product not found'}, status=404)
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)


def get_productF_field(request, product_code, field_name):
    my_client = pymongo.MongoClient(settings.DB_NAME)
    dbname = my_client['Safepick']
    collection_name = dbname["food"]

    # Find the product with the specified code
    product = collection_name.find_one({'code': product_code})

    if product:
        # Check if the field exists in the product document
        if field_name in product:
            field_value = product[field_name]
            if isinstance(field_value, bytes):
                field_value = base64.b64encode(field_value).decode('utf-8')
            return JsonResponse({field_name: field_value})
        else:
            return JsonResponse({'error': 'Field does not exist'})
    else:
        return JsonResponse({'error': 'Product not found'})
    
    

def foodApi(request, id=0):
    if request.method == 'GET':
        my_client = pymongo.MongoClient(settings.DB_NAME)
        dbname = my_client['Safepick']
        collection_name = dbname["food"]
        med_details = list(collection_name.find({}))  # Convert Cursor to list of dictionaries
        
        # Convert ObjectId instances to strings
        for item in med_details:
            item['_id'] = str(item['_id'])
        
        return JsonResponse(med_details, safe=False)

def cosmeticApi(request, id=0):
    if request.method == 'GET':
        my_client = pymongo.MongoClient(settings.DB_NAME)
        dbname = my_client['Safepick']
        collection_name = dbname["cosmetics"]
        med_details = list(collection_name.find({}))  # Convert Cursor to list of dictionaries
        
        # Convert ObjectId instances to strings
        for item in med_details:
            item['_id'] = str(item['_id'])
        
        return JsonResponse(med_details, safe=False)
