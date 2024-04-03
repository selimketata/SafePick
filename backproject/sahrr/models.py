from django.db import models

class UserProfile(models.Model):
    username = models.CharField(max_length=150)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=128)
    photo_name = models.CharField(max_length=100, null=True)  # Field to store the image name

    def __str__(self):
        return self.email
