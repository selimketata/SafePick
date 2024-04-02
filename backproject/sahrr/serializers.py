from rest_framework import serializers
from .models import UserProfile

class UserRegistrationSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = UserProfile
        fields = ['username', 'email', 'password', 'photo_name']  # Change 'photo' to 'photo_name'

    def create(self, validated_data):
     photo_name = validated_data.pop('photo_name', None)
     user = UserProfile.objects.create(**validated_data)
     if photo_name:
        user.photo_name = photo_name  # Assign photo name to the 'photo_name' field
        user.save()
       
  
     return user
