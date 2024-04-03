from rest_framework import serializers
from django.contrib.auth.hashers import make_password  
from .models import UserProfile

class UserRegistrationSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = UserProfile
        fields = ['username', 'email', 'password', 'photo_name']  

    def create(self, validated_data):
        password = validated_data.pop('password') 
        validated_data['password'] = make_password(password)  
        return super().create(validated_data)  

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = ['id', 'username', 'email'] 
        
class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = ['id', 'username', 'email', 'photo_name']
