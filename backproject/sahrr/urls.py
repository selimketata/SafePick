from django.urls import path
from . import views

from .views import register_user
urlpatterns = [
    path('register/', register_user, name='register_user'),
    path('check-email-existence/', views.check_email_existence, name='check_email_existence'),
    path('user-profile/', views.UserProfileView.as_view(), name='user-profile'),
     path('login/', views.login, name='login'),
]
