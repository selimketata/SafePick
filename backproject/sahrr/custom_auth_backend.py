from django.contrib.auth.backends import BaseBackend
from .models import UserProfile
from django.contrib.auth.hashers import check_password

class MongoDBBackend(BaseBackend):
    def authenticate(self, request, email=None, password=None):
        try:
            user_profile = UserProfile.objects.get(email=email)
            if check_password(password, user_profile.password):
                return user_profile
            else:
                return None
        except UserProfile.DoesNotExist:
            return None
