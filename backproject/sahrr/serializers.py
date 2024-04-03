from rest_framework import serializers
from django.contrib.auth.hashers import make_password  # Import make_password
from .models import UserProfile

class UserRegistrationSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = UserProfile
        fields = ['username', 'email', 'password', 'photo_name']  # Change 'photo' to 'photo_name'

    def create(self, validated_data):
        password = validated_data.pop('password')  # Retrieve and remove password from validated data
        validated_data['password'] = make_password(password)  # Hash the password
        return super().create(validated_data)  # Call the superclass's create method with the updated validated data

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = ['id', 'username', 'email'] 
        
class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = ['id', 'username', 'email', 'photo_name']
