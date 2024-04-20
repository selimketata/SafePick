from django.urls import path
from . import views
from django.conf.urls.static import static
from django.conf import settings
from .views import register_user

urlpatterns = [
    path('food/', views.foodApi),
    path('cosmetics/', views.cosmeticApi),
    path('food/<int:product_code>/<str:field_name>/', views.get_productF_field, name='get_productF_field'),
    path('food/<int:product_code>/', views.get_productF, name='get_productF'),
    path('cosmetics/<int:product_code>/<str:field_name>/', views.get_productC_field, name='get_productC_field'),
    path('cosmetics/<int:product_code>/', views.get_productC, name='get_productC'),
    path('register/', register_user, name='register_user'),
    path('check-email-existence/', views.check_email_existence, name='check_email_existence'),
    path('user-profile/', views.UserProfileView.as_view(), name='user-profile'),
    path('login/', views.login, name='login'),
    path('get_user_profile/', views.get_user_profile, name='get_user_profile'),

] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
