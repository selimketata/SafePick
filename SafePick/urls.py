from django.urls import path
from . import views
from django.conf.urls.static import static
from django.conf import settings
from .views import register_user, get_messages_in_community

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
     path('add_community/', views.add_community, name='add_community'),
      path('add_email_to_community/', views.add_email_to_community, name='add_email_to_community'),
      path('get_community_members/', views.get_community_members, name='get_community_members'),
path('get_user_communities/', views.get_user_communities, name='get_user_communities'),
path('get_communities_not_user_exists/', views.get_communities_not_user_exists, name='get_communities_not_user_exists'),
path('remove_community/', views.remove_community, name='remove_community'),
path('remove_user_from_community/', views.remove_user_from_community, name='remove_user_from_community'),
path('get_all_communities/', views.get_all_communities, name='get_all_communities'),
path('create_message/', views.create_message, name='create_message'),
 path('get_messages_in_community/', get_messages_in_community, name='get_messages_in_community'),
 path('alternatives/food/<int:product_code>/', views.food_Alternatives, name='food_Alternatives'),
path('alternatives/cosmetics/<int:product_code>/', views.cosmetics_Alternatives, name='cosmetics_Alternatives'),
path('<str:email>/<int:code>/', views.update_user_code, name='update_user_code'),
 path('food/category/<str:category>/', views.get_category_products, name='category_products'),

] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

