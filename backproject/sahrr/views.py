from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import UserRegistrationSerializer
from django.contrib.auth import authenticate, login
from rest_framework.views import APIView
from django.http import JsonResponse
from .models import UserProfile
from .serializers import UserProfileSerializer

class UserProfileView(APIView):
    def get(self, request):
        # Retrieve user profile data
        user_profiles = UserProfile.objects.all()
        
        # Serialize the data
        serializer = UserProfileSerializer(user_profiles, many=True)
        
        # Return the serialized data as a JSON response
        return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['POST'])
def register_user(request):
    if request.method == 'POST':
        serializer = UserRegistrationSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import UserProfile
@api_view(['POST'])
def check_email_existence(request):
    if request.method == 'POST':
        if 'email' in request.data:
            email = request.data['email']
            print("Email:", email)  # Debug statement
            
            try:
                user_profile = UserProfile.objects.get(email=email)
                print("User Profile:", user_profile)  # Debug statement
                return Response({'exists': True}, status=status.HTTP_200_OK)
            except UserProfile.DoesNotExist:
                print("User Profile does not exist")  # Debug statement
                return Response({'exists': False}, status=status.HTTP_200_OK)
        else:
            return Response({'error': 'Email parameter is missing'}, status=status.HTTP_400_BAD_REQUEST)
@api_view(['POST'])
def login(request):
    if request.method == 'POST':
        if 'email' in request.data and 'password' in request.data:
            email = request.data['email']
            password = request.data['password']
            print("Email:", email)  
            print("Password:", password)  
            
            try:
                user_profile = UserProfile.objects.get(email=email, password=password)
                print("User Profile:", user_profile)  # Debug statement
                return Response({'exists': True}, status=status.HTTP_200_OK)
            except UserProfile.DoesNotExist:
                print("User Profile does not exist")  # Debug statement
                return Response({'exists': False}, status=status.HTTP_200_OK)
            except UserProfile.MultipleObjectsReturned:
                print("Multiple user profiles found for the same email and password")  # Debug statement
                return Response({'error': 'Multiple user profiles found for the same email and password'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        else:
            return Response({'error': 'email and/or password parameters are missing'}, status=status.HTTP_400_BAD_REQUEST)
