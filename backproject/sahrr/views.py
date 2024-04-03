from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import UserRegistrationSerializer, UserProfileSerializer
from .models import UserProfile
from rest_framework.views import APIView


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
