from django.http import JsonResponse
import pymongo
from bson import ObjectId  # Import ObjectId from bson module
from django.conf import settings
from django.http import JsonResponse
from .models import ProductF,ProductC
from .serializers import ProductFSerializer,ProductCSerializer
import base64
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import UserRegistrationSerializer, UserProfileSerializer
from .models import UserProfile
from rest_framework.views import APIView
from django.shortcuts import get_object_or_404
import json



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

def get_productC(request, product_code):
    my_client = pymongo.MongoClient(settings.DB_NAME)
    dbname = my_client['Safepick']
    collection_name = dbname["cosmetics"]
    try:
        product = collection_name.find_one({'code': product_code})
        if product:
            if isinstance(product['background_removed_image'], bytes):
                product['background_removed_image'] = base64.b64encode(product['background_removed_image']).decode('utf-8')
            serializer = ProductCSerializer(product)  # Create an instance of the serializer
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
    
def get_productC_field(request, product_code, field_name):
    my_client = pymongo.MongoClient(settings.DB_NAME)
    dbname = my_client['Safepick']
    collection_name = dbname["cosmetics"]

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
    
class UserProfileView(APIView):
    def get(self, request):
    
        user_profiles = UserProfile.objects.all()
        
        
        serializer = UserProfileSerializer(user_profiles, many=True)
        

        return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['POST'])
def register_user(request):
    if request.method == 'POST':
        serializer = UserRegistrationSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
def check_email_existence(request):
    if request.method == 'POST':
        if 'email' in request.data:
            email = request.data['email']
            print("Email:", email)  
            
            try:
                user_profile = UserProfile.objects.get(email=email)
                print("User Profile:", user_profile)  
                return Response({'exists': True}, status=status.HTTP_200_OK)
            except UserProfile.DoesNotExist:
                print("User Profile does not exist") 
                return Response({'exists': False}, status=status.HTTP_200_OK)
        else:
            return Response({'error': 'Email parameter is missing'}, status=status.HTTP_400_BAD_REQUEST)

from django.contrib.auth import authenticate

@api_view(['POST'])
def login(request):
    if request.method == 'POST':
        if 'email' in request.data and 'password' in request.data:
            email = request.data['email']
            password = request.data['password']
            user = authenticate(request, email=email, password=password)
            if user is not None:
                # Authentication successful
                return Response({'exists': True}, status=status.HTTP_200_OK)
            else:
                # Authentication failed
                return Response({'exists': False}, status=status.HTTP_401_UNAUTHORIZED)
        else:
            return Response({'error': 'email and/or password parameters are missing'}, status=status.HTTP_400_BAD_REQUEST)
@api_view(['POST'])
def get_user_profile(request):
    if request.method == 'POST':
        if 'email' in request.data:
            email = request.data['email']
            try:
                user_profile = get_object_or_404(UserProfile, email=email)
                serializer = UserProfileSerializer(user_profile)
                return Response(serializer.data, status=status.HTTP_200_OK)
            except UserProfile.DoesNotExist:
                return Response({'error': 'User profile not found'}, status=status.HTTP_404_NOT_FOUND)
        else:
            return Response({'error': 'Email parameter is missing'}, status=status.HTTP_400_BAD_REQUEST)
    else:
        return Response({'error': 'Invalid request method'}, status=status.HTTP_405_METHOD_NOT_ALLOWED)
    

def food_Alternatives(request, product_code):
    if request.method == 'GET':
        try:
            # Connect to the MongoDB database
            my_client = pymongo.MongoClient(settings.DB_NAME)
            dbname = my_client['Safepick']
            collection = dbname['food']

            # Retrieve the specific product
            specific_product = collection.find_one({'code': product_code})

            if specific_product:
                # Retrieve the current product's score
                current_product_score = specific_product.get('nutriscore_score_out_of_100', 0)

                # Try retrieving the specific category first
                specific_category = specific_product.get('pnns_groups_1')

                # If specific category doesn't exist or is null, fallback to pnns_groups_2
                if not specific_category:
                    specific_category = specific_product.get('pnns_groups_2')

                # If both specific_category and pnns_groups_2 are null, return an error
                if not specific_category:
                    return JsonResponse({'error': 'No category found for the product'}, status=404)

                # Retrieve products with the same category but not from the same collection
                products_with_same_category = dbname.food.find({'pnns_groups_1': specific_category})

                # Filter products based on score
                products_with_same_category = [product for product in products_with_same_category if product.get('nutriscore_score_out_of_100', 0) >= current_product_score]
                # Sort the products by nutriscore_score_out_of_100
                sorted_products = sorted(products_with_same_category, key=lambda x: x.get('nutriscore_score_out_of_100', 0), reverse=True)
                
                # Serialize the products
                serialized_products = []
                if len(sorted_products) >= 5:
                    # If the list contains at least 5 elements, loop through the first 5 elements
                    for p in sorted_products[:5]:
                        # Convert ObjectId to string for serialization
                        p['_id'] = str(p['_id'])
                        p['background_removed_image'] = base64.b64encode(p['background_removed_image']).decode('utf-8')
                        # Convert p to JSON
                        serialized_product = json.dumps(p, default=str)
                        serialized_products.append(serialized_product)
                else:
                    # If the list contains fewer than 5 elements, loop through all the elements
                    for p in sorted_products:
                        # Convert ObjectId to string for serialization
                        p['_id'] = str(p['_id'])
                        p['background_removed_image'] = base64.b64encode(p['background_removed_image']).decode('utf-8')
                        # Convert p to JSON
                        serialized_product = json.dumps(p, default=str)
                        serialized_products.append(serialized_product)

                # Return the serialized products
                return JsonResponse({'Alternatives': serialized_products})

            else:
                return JsonResponse({'error': 'Product not found'}, status=404)
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)


def cosmetics_Alternatives(request, product_code):
    if request.method == 'GET':
        try:
            # Connect to the MongoDB database
            my_client = pymongo.MongoClient(settings.DB_NAME)
            dbname = my_client['Safepick']
            collection = dbname['cosmetics']

            # Retrieve the specific product
            specific_product = collection.find_one({'code': product_code})

            if specific_product:
                # Retrieve the current product's score
                current_product_score = specific_product.get('score', 0)

                # Try retrieving the specific category first
                specific_category = specific_product.get('pnns_groups_1')

                # If specific category doesn't exist or is null, fallback to pnns_groups_2
                if not specific_category:
                    specific_category = specific_product.get('pnns_groups_2')

                # If both specific_category and pnns_groups_2 are null, return an error
                if not specific_category:
                    return JsonResponse({'error': 'No category found for the product'}, status=404)

                # Retrieve products with the same category but not from the same collection
                products_with_same_category = dbname.cosmetics.find({'pnns_groups_1': specific_category})

                # Filter products based on score
                products_with_same_category = [product for product in products_with_same_category if product.get('score', 0) >= current_product_score]
                # Sort the products by nutriscore_score_out_of_100
                sorted_products = sorted(products_with_same_category, key=lambda x: x.get('score', 0), reverse=True)
                
                # Serialize the products
                serialized_products = []
                if len(sorted_products) >= 5:
                    # If the list contains at least 5 elements, loop through the first 5 elements
                    for p in sorted_products[:5]:
                        # Convert ObjectId to string for serialization
                        p['_id'] = str(p['_id'])
                        p['background_removed_image'] = base64.b64encode(p['background_removed_image']).decode('utf-8')
                        # Convert p to JSON
                        serialized_product = json.dumps(p, default=str)
                        serialized_products.append(serialized_product)
                else:
                    # If the list contains fewer than 5 elements, loop through all the elements
                    for p in sorted_products:
                        # Convert ObjectId to string for serialization
                        p['_id'] = str(p['_id'])
                        p['background_removed_image'] = base64.b64encode(p['background_removed_image']).decode('utf-8')
                        # Convert p to JSON
                        serialized_product = json.dumps(p, default=str)
                        serialized_products.append(serialized_product)

                # Return the serialized products
                return JsonResponse({'Alternatives': serialized_products})

            else:
                return JsonResponse({'error': 'Product not found'}, status=404)
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)