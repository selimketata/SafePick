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
        
from django.db.models import Q
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import Message  # Ensure this is correctly mapped to MongoDB

@api_view(['POST'])
def search_messages_in_community(request):
    community_name = request.data.get('community_name')
    search_term = request.data.get('search_term')

    if not community_name or not search_term:
        return Response({"error": "Both community name and search term are required"}, status=status.HTTP_400_BAD_REQUEST)

    try:
        # Assuming using Djongo to query MongoDB
        messages = Message.objects.filter(
            community_name=community_name,
            content__icontains=search_term
        ).order_by('-timestamp')

        if not messages:
            return Response({"error": "No messages found"}, status=status.HTTP_404_NOT_FOUND)

        messages_data = [{
          
            "email": message.email,
            "content": message.content,
            "timestamp": message.timestamp.isoformat()
        } for message in messages]

        return Response({
           
            "messages": messages_data
        }, status=status.HTTP_200_OK)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
@api_view(['PATCH'])
def update_user_name(request):
    if request.method == 'PATCH':
        email = request.data.get('email')
        if not email:
            return Response({'error': 'Email is required'}, status=status.HTTP_400_BAD_REQUEST)

        user_profile = get_object_or_404(UserProfile, email=email)
        serializer = UserProfileSerializer(user_profile, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
from django.contrib.auth.hashers import make_password 
@api_view(['PATCH'])
def update_user_password(request):
    if request.method == 'PATCH':
        email = request.data.get('email')
        new_password = request.data.get('new_password')

        if not email or not new_password:
            return Response({'error': 'Email and new password are required'}, status=status.HTTP_400_BAD_REQUEST)

        # Fetching the user profile
        user_profile = get_object_or_404(UserProfile, email=email)

        # Hashing the new password before saving it
        user_profile.password = make_password(new_password)

        # Creating a serializer instance with the updated user data
        serializer = UserProfileSerializer(user_profile, data=request.data, partial=True)

        if serializer.is_valid():
            # Saving the new password to the database
            serializer.save()
            return Response({'message': 'Password updated successfully'}, status=status.HTTP_200_OK)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.shortcuts import get_object_or_404
from .models import UserProfile, Message,CommunityMember

@api_view(['DELETE'])
def delete_user_profile(request):
    email = request.data.get('email')
    if not email:
        return Response({'error': 'Email is required'}, status=status.HTTP_400_BAD_REQUEST)

    # Fetching the user profile
    user_profile = get_object_or_404(UserProfile, email=email)

    # Delete user messages
    Message.objects.filter(email=email).delete()

    # Delete community memberships
    CommunityMember.objects.filter(email=email).delete()

    # Delete the user profile
    user_profile.delete()

    return Response({'message': 'User account and related data successfully deleted'}, status=status.HTTP_200_OK)
