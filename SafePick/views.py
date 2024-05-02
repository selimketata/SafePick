from django.http import JsonResponse
import pymongo

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




from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from django.views import View

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
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import Community
from .serializers import CommunitySerializer

@api_view(['POST'])
def add_community(request):
    if request.method == 'POST':
        community_name = request.data.get('community_name')
        if community_name:
            # Check if the community name already exists
            if Community.objects.filter(community_name=community_name).exists():
                return Response({'error': 'Community with this name already exists'}, status=status.HTTP_400_BAD_REQUEST)
            
            # Create a new community if the name doesn't exist
            community = Community.objects.create(community_name=community_name)
            serializer = CommunitySerializer(community)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response({'error': 'Missing community name'}, status=status.HTTP_400_BAD_REQUEST)

# views.py

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import Community, CommunityMember
from .serializers import CommunitySerializer

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import Community, CommunityMember
from .serializers import CommunitySerializer

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import Community, CommunityMember
from .serializers import CommunitySerializer


from rest_framework import status
from .models import Community, CommunityMember
from .serializers import CommunityMemberSerializer

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import Community, CommunityMember
from .serializers import CommunityMemberSerializer

@api_view(['POST'])
def add_email_to_community(request):
    if request.method == 'POST':
        community_name = request.data.get('community_name')
        email = request.data.get('email')

        try:
            community = Community.objects.get(community_name=community_name)
        except Community.DoesNotExist:
            return Response({"error": "Community not found"}, status=status.HTTP_404_NOT_FOUND)

        if CommunityMember.objects.filter(community_name=community_name, email=email).exists():
            return Response({"error": "Email already exists in the community"}, status=status.HTTP_400_BAD_REQUEST)

        community_member = CommunityMember.objects.create(community_name=community_name, email=email)
        serializer = CommunityMemberSerializer(community_member)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import CommunityMember

@api_view(['POST'])
def get_community_members(request):
    if request.method == 'POST':
        community_name = request.data.get('community_name')

        if not community_name:
            return Response({"error": "Community name is required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            # Query all emails of community members belonging to the given community name
            community_emails = CommunityMember.objects.filter(community_name=community_name).values_list('email', flat=True)
            return Response({"emails": list(community_emails)}, status=status.HTTP_200_OK)
        except CommunityMember.DoesNotExist:
            return Response({"error": "Community not found or has no members"}, status=status.HTTP_404_NOT_FOUND)
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import CommunityMember
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import CommunityMember

@api_view(['POST'])
def get_user_communities(request):
    if request.method == 'POST':
        email = request.data.get('email')

        if not email:
            return Response({"error": "Email is required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            # Query all community names where the user with the provided email is a member
            user_communities = CommunityMember.objects.filter(email=email).values_list('community_name', flat=True).distinct()
            return Response({"communities": list(user_communities)}, status=status.HTTP_200_OK)
        except CommunityMember.DoesNotExist:
            return Response({"error": "User not found or is not a member of any community"}, status=status.HTTP_404_NOT_FOUND)
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import Community, CommunityMember

@api_view(['POST'])
def get_communities_not_user_exists(request):
    if request.method == 'POST':
        email = request.data.get('email')

        if not email:
            return Response({"error": "Email is required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            # Query all community names from the Community model
            all_community_names = set(Community.objects.values_list('community_name', flat=True))

            # Query community names where the user with the provided email exists
            user_communities = set(CommunityMember.objects.filter(email=email).values_list('community_name', flat=True))

            # Remove community names where the user exists from all community names
            communities_not_user_exists = list(all_community_names - user_communities)

            return Response({"communities_not_user_exists": communities_not_user_exists}, status=status.HTTP_200_OK)
        except Community.DoesNotExist:
            return Response({"error": "No communities found"}, status=status.HTTP_404_NOT_FOUND)
        except CommunityMember.DoesNotExist:
            return Response({"error": "No user found"}, status=status.HTTP_404_NOT_FOUND)



from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import CommunityMember

@api_view(['POST'])
def remove_community(request):
    if request.method == 'POST':
        community_name = request.data.get('community_name')

        if not community_name:
            return Response({"error": "Community name is required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            # Delete all community members associated with this community
            CommunityMember.objects.filter(community_name=community_name).delete()
            Community.objects.filter(community_name=community_name).delete()

            return Response({"message": f"All community members of '{community_name}' deleted successfully"}, status=status.HTTP_200_OK)
        except CommunityMember.DoesNotExist:
            return Response({"error": "No community members found for the specified community"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['POST'])
def remove_user_from_community(request):
    if request.method == 'POST':
        email = request.data.get('email')
        community_name = request.data.get('community_name')

        if not email:
            return Response({"error": "Email is required"}, status=status.HTTP_400_BAD_REQUEST)
        if not community_name:
            return Response({"error": "Community name is required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            # Delete the specific user from the CommunityMember model
            CommunityMember.objects.filter(email=email, community_name=community_name).delete()

            return Response({"message": f"User '{email}' removed from '{community_name}' successfully"}, status=status.HTTP_200_OK)
        except CommunityMember.DoesNotExist:
            return Response({"error": "User not found in the specified community"}, status=status.HTTP_404_NOT_FOUND)


@api_view(['GET'])
def get_all_communities(request):
    if request.method == 'GET':
        try:
            # Query all community names from the Community model
            communities = Community.objects.all().values_list('community_name', flat=True)

            return Response({"communities": list(communities)}, status=status.HTTP_200_OK)
        except Community.DoesNotExist:
            return Response({"error": "No communities found"}, status=status.HTTP_404_NOT_FOUND)
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import Message

@api_view(['POST'])
def create_message(request):
    if request.method == 'POST':
        email= request.data.get('email')
        community_name = request.data.get('community_name')
        content = request.data.get('content')

        if not community_name:
            return Response({"error": "Community name is required"}, status=status.HTTP_400_BAD_REQUEST)
        if not content:
            return Response({"error": "Message content is required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            # Create the message
            message = Message.objects.create(email=email, community_name=community_name, content=content)

            return Response({"message": "Message created successfully"}, status=status.HTTP_201_CREATED)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import Message
@api_view(['POST'])
def get_messages_in_community(request):
    if request.method == 'POST':
        community_name = request.data.get('community_name')

        if not community_name:
            return Response({"error": "Community name is required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            # Query all messages for the specified community
            messages = Message.objects.filter(community_name=community_name).order_by('timestamp')

            # Organize messages by timestamp
            messages_by_timestamp = []
            for message in messages:
                messages_by_timestamp.append({
                    "email": message.email,
                    "content": message.content,
                    "timestamp": message.timestamp
                })

            # Construct the response JSON object
            response_data = {
                "community_name": community_name,
                "messages": messages_by_timestamp
            }

            return Response(response_data, status=status.HTTP_200_OK)
        except Message.DoesNotExist:
            return Response({"error": "No messages found for the specified community"}, status=status.HTTP_404_NOT_FOUND)
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

                # Query for products with the same category and score >= current product score
                products_with_same_category = collection.find(
                    {'pnns_groups_1': specific_category,
                     'nutriscore_score_out_of_100': {'$gte': current_product_score}}
                ).sort('nutriscore_score_out_of_100', pymongo.DESCENDING).limit(5)

                # Serialize the products
                serialized_products = []
                for product in products_with_same_category:
                    # Convert ObjectId to string for serialization
                    product['_id'] = str(product['_id'])
                    product['background_removed_image'] = base64.b64encode(product['background_removed_image']).decode('utf-8')
                    # Convert product to JSON
                    serialized_product = json.dumps(product, default=str)
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

                # Query for products with the same category and score >= current product score
                products_with_same_category = collection.find(
                    {'pnns_groups_1': specific_category,
                     'score': {'$gte': current_product_score}}
                ).sort('score', pymongo.DESCENDING).limit(5)

                # Serialize the products
                serialized_products = []
                for product in products_with_same_category:
                    # Convert ObjectId to string for serialization
                    product['_id'] = str(product['_id'])
                    product['background_removed_image'] = base64.b64encode(product['background_removed_image']).decode('utf-8')
                    # Convert product to JSON
                    serialized_product = json.dumps(product, default=str)
                    serialized_products.append(serialized_product)

                # Return the serialized products
                return JsonResponse({'Alternatives': serialized_products})

            else:
                return JsonResponse({'error': 'Product not found'}, status=404)
        except Exception as e:
            return JsonResponse({'error': str(e)}, status=500)

from django.http import JsonResponse
from pymongo import MongoClient
from pymongo.collection import ReturnDocument


import pymongo
from django.http import JsonResponse
from pymongo.collection import ReturnDocument

def update_user_code(request, email, code):
    my_client = pymongo.MongoClient(settings.DB_NAME)
    dbname = my_client['Safepick']
    users = dbname["food.users"]

    try:
        # Ensure user exists or create a new one if not
        user = users.find_one_and_update(
            {'email': email},
            {
                '$setOnInsert': {
                    'email': email,
                    'codes': [],
                    'user_id': None  # Updated below if it's a new user
                }
            },
            upsert=True,
            return_document=ReturnDocument.AFTER
        )

        # Assign new user_id if this is a new user
        if user['user_id'] is None:
            max_user = users.find_one(sort=[("user_id", pymongo.DESCENDING)])
            max_user_id = max_user["user_id"] if max_user else 0
            new_user_id = max_user_id + 1
            users.update_one({'email': email}, {'$set': {'user_id': new_user_id}})

        # Manage codes, ensuring there are no more than 6
        if len(user['codes']) >= 6:
            # Remove the oldest code
            users.update_one({'email': email}, {'$pop': {'codes': -1}})  # $pop with -1 removes the first item

        # Attempt to increment the code's count if it exists
        result = users.update_one(
            {"email": email, "codes.code": code},
            {"$inc": {"codes.$.count": 1}},
            upsert=False
        )

        if result.matched_count == 0:
            # The code does not exist, add it with a count of 1
            users.update_one(
                {"email": email},
                {"$push": {"codes": {"code": code, "count": 1}}}
            )

        return JsonResponse({"status": "success"}, safe=False)
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)}, status=400)


from django.http import JsonResponse
import pymongo
from pymongo import MongoClient
import base64
from django.conf import settings

from bson import ObjectId
import base64

def serialize_doc(doc):
    """ Recursively convert MongoDB documents, which may contain ObjectIds, into serializable formats. """
    if isinstance(doc, dict):
        for k, v in doc.items():
            if isinstance(v, ObjectId):
                doc[k] = str(v)
            elif isinstance(v, bytes):
                doc[k] = base64.b64encode(v).decode('utf-8')
            else:
                doc[k] = serialize_doc(v)
    elif isinstance(doc, list):
        doc = [serialize_doc(v) for v in doc]
    return doc


from django.http import JsonResponse
import pymongo
from pymongo import MongoClient
from django.conf import settings

def get_category_products(request, category):
    # Connect to MongoDB
    client = MongoClient(settings.DB_NAME)
    db = client['Safepick']
    categorized_products = db['category_products_food']

    # Find the category document and retrieve 10 random codes
    category_doc = categorized_products.find_one({"category": category})
    if not category_doc or 'products' not in category_doc:
        return JsonResponse({"error": "Category not found or no products available"}, status=404)

    import random
    product_codes = random.sample(category_doc['products'], min(10, len(category_doc['products'])))

    # Fetch details for each product code from the 'food' collection
    products_collection = db['food']
    products = list(products_collection.find(
        {"code": {"$in": product_codes}},
        {"product_name": 1, "background_removed_image": 1, "code": 1, "nutriscore_score_out_of_100": 1}
    ))

    # Serialize each product document to be JSON-ready
    products = [serialize_doc(product) for product in products]

    # Convert to JSON and return response
    return JsonResponse({"products": products}, safe=False)

from django.http import JsonResponse
from pymongo import MongoClient
from bson.objectid import ObjectId

def content_based_recommendation(request, email):
    client = MongoClient(settings.DB_NAME)
    db = client['Safepick']

    # Find the document in the recommendations collection by email
    recommendations = db.food_recommendations.recommendations.find_one({"email": email})

    # If no recommendations are found for the email, return an empty list
    if not recommendations:
        return JsonResponse({'error': 'No recommendations found for this email'}, status=404)

    # Extract product codes
    product_codes = recommendations['recommended_products']

    # Fetch details from the food collection for each product code
    product_details = []
    for code in product_codes:
        product = db.food.find_one({"code": code}, {'product_name': 1, 'nutriscore_score_out_of_100': 1, 'background_removed_image': 1})
        if product:
            product_details.append({
                'product_name': product.get('product_name', ''),
                'nutriscore_score_out_of_100': product.get('nutriscore_score_out_of_100', -1),
                'background_removed_image': product.get('background_removed_image', '')
            })
    products = [serialize_doc(product) for product in product_details]


    # Return the product details as JSON
    return JsonResponse({'products': products})

from django.conf import settings
from pymongo import MongoClient
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

@api_view(['GET'])
def dynamic_collection_api(request):
    query = request.GET.get('q', '')

    # Connect to MongoDB using settings
    client = MongoClient(settings.DB_NAME)  # Make sure to use the correct settings attribute for your MongoDB URI
    db = client['Safepick']
    collection = db['food']

    # Perform the query
    if query:
        search_results = list(collection.find({"product_name": {"$regex": query, "$options": "i"}}))
        client.close()  # Important to close the connection
        products = [serialize_doc(product) for product in search_results]


    # You would still need to serialize the data here manually
        return Response({"data": products})
    else:
        return Response({"message": "No query provided"}, status=status.HTTP_400_BAD_REQUEST)





