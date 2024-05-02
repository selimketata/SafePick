from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager
from django.utils import timezone



class ProductF(models.Model):
    _id = models.CharField(max_length=100, primary_key=True)
    code = models.BigIntegerField(null=True)
    url = models.URLField(max_length=200, null=True)
    product_name = models.CharField(max_length=10000, null=True)
    quantity = models.CharField(max_length=10000, null=True)
    brands = models.CharField(max_length=10000, null=True)
    brands_tags = models.CharField(max_length=10000, null=True)
    categories = models.CharField(max_length=10000, null=True)
    categories_tags = models.CharField(max_length=10000, null=True)
    categories_en = models.CharField(max_length=10000, null=True)
    labels = models.CharField(max_length=10000, null=True)
    labels_tags = models.CharField(max_length=10000, null=True)
    labels_en = models.CharField(max_length=10000, null=True)
    countries = models.CharField(max_length=10000, null=True)
    countries_tags = models.CharField(max_length=10000, null=True)
    countries_en = models.CharField(max_length=10000, null=True)
    ingredients_text = models.TextField(null=True)
    ingredients_tags = models.CharField(max_length=10000, null=True)
    ingredients_analysis_tags = models.CharField(max_length=10000, null=True)
    allergens = models.CharField(max_length=10000, null=True)
    serving_size = models.CharField(max_length=10000, null=True)
    serving_quantity = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    additives_n = models.IntegerField(null=True)
    nutriscore_score = models.IntegerField(null=True)
    nutriscore_grade = models.CharField(max_length=1, null=True)
    nova_group = models.IntegerField(null=True)
    pnns_groups_1 = models.CharField(max_length=10000, null=True)
    pnns_groups_2 = models.CharField(max_length=10000, null=True)
    food_groups = models.CharField(max_length=10000, null=True)
    food_groups_tags = models.CharField(max_length=10000, null=True)
    food_groups_en = models.CharField(max_length=10000, null=True)
    states = models.CharField(max_length=10000, null=True)
    states_tags = models.CharField(max_length=10000, null=True)
    states_en = models.CharField(max_length=10000, null=True)
    brand_owner = models.CharField(max_length=10000, null=True)
    ecoscore_grade = models.CharField(max_length=10000, null=True)
    nutrient_levels_tags = models.CharField(max_length=10000, null=True)
    product_quantity = models.FloatField(null=True)
    unique_scans_n = models.IntegerField(null=True)
    popularity_tags = models.CharField(max_length=10000, null=True)
    completeness = models.FloatField(null=True)
    last_image_t = models.IntegerField(null=True)
    main_category = models.CharField(max_length=10000, null=True)
    main_category_en = models.CharField(max_length=10000, null=True)
    image_url = models.URLField(max_length=200, null=True)
    image_small_url = models.URLField(max_length=200, null=True)
    image_ingredients_url = models.URLField(max_length=200, null=True)
    image_ingredients_small_url = models.URLField(max_length=200, null=True)
    energy_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    fat_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    saturated_fat_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    trans_fat_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    cholesterol_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    carbohydrates_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    sugars_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    fiber_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    proteins_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    salt_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    sodium_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    vitamin_a_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    vitamin_k_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    vitamin_c_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    vitamin_b1_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    vitamin_b2_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    vitamin_pp_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    vitamin_b6_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    vitamin_b9_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    pantothenic_acid_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    potassium_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    calcium_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    phosphorus_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    iron_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    magnesium_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    zinc_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    copper_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    manganese_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    selenium_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    fruits_vegetables_nuts_estimate_from_ingredients_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    nutrition_score_fr_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    phylloquinone_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)
    nutriscore_score_out_of_100 = models.IntegerField(null=True)
    background_removed_image = models.CharField(max_length=100000000, null=True)
    energy_kcal_100g = models.DecimalField(max_digits=10000, decimal_places=2, null=True)


    def __str__(self):
        return self.product_name


class ProductC(models.Model):
    _id = models.CharField(max_length=100, primary_key=True)
    code = models.IntegerField(null=True)
    url = models.URLField(null=True)
    creator = models.CharField(max_length=10000, null=True)
    product_name = models.CharField(max_length=10000, null=True)
    generic_name = models.CharField(max_length=10000, null=True)
    quantity = models.CharField(max_length=10000, null=True)
    packaging = models.CharField(max_length=10000, null=True)
    packaging_tags = models.CharField(max_length=10000, null=True)
    brands = models.CharField(max_length=10000, null=True)
    brands_tags = models.CharField(max_length=10000, null=True)
    categories = models.CharField(max_length=10000, null=True)
    categories_tags = models.CharField(max_length=10000, null=True)
    categories_en = models.CharField(max_length=10000, null=True)
    origins = models.CharField(max_length=10000, null=True)
    origins_tags = models.CharField(max_length=10000, null=True)
    manufacturing_places = models.CharField(max_length=10000, null=True)
    manufacturing_places_tags = models.CharField(max_length=10000, null=True)
    labels = models.CharField(max_length=10000, null=True)
    labels_tags = models.CharField(max_length=10000, null=True)
    labels_en = models.CharField(max_length=10000, null=True)
    stores = models.CharField(max_length=10000, null=True)
    countries = models.CharField(max_length=10000, null=True)
    countries_tags = models.CharField(max_length=10000, null=True)
    countries_en = models.CharField(max_length=10000, null=True)
    ingredients_text = models.TextField(null=True)
    additives_n = models.IntegerField(null=True)
    additives = models.TextField(null=True)
    additives_tags = models.CharField(max_length=10000, null=True)
    additives_en = models.CharField(max_length=10000, null=True)
    ingredients_from_palm_oil_n = models.IntegerField(null=True)
    ingredients_that_may_be_from_palm_oil_n = models.IntegerField(null=True)
    states = models.CharField(max_length=10000, null=True)
    states_tags = models.CharField(max_length=10000, null=True)
    states_en = models.CharField(max_length=10000, null=True)
    main_category = models.CharField(max_length=10000, null=True)
    main_category_en = models.CharField(max_length=10000, null=True)
    image_url = models.URLField(null=True)
    image_small_url = models.URLField(null=True)
    allergens = models.JSONField(null=True)
    carcinogenic = models.JSONField(null=True)
    endocrine = models.JSONField(null=True)
    neurotoxicity = models.JSONField(null=True)
    persistent = models.JSONField(null=True)
    ecotoxicity = models.JSONField(null=True)
    irritation = models.JSONField(null=True)
    occupational_hazards = models.JSONField(null=True)
    contamination = models.JSONField(null=True)
    developmental_reproductive_toxicity = models.JSONField(null=True)
    miscellaneous = models.JSONField(null=True)
    score = models.DecimalField(decimal_places=2, max_digits=10000, null=True)
    pnns_groups_1 = models.CharField(max_length=10000, null=True)
    background_removed_image = models.CharField(max_length=100000000, null=True)

    def __str__(self):
        return self.product_name
    
class UserProfileManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        if not email:
            raise ValueError('The Email field must be set')
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must have is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')

        return self.create_user(email, password, **extra_fields)

class UserProfile(AbstractBaseUser):
    date_joined = models.DateTimeField(default=timezone.now)
    email = models.EmailField(unique=True)
    username = models.CharField(max_length=150, blank=True)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    photo_name = models.CharField(max_length=100, null=True)

    objects = UserProfileManager()

    USERNAME_FIELD = 'email'

    def __str__(self):
        return self.email

    def has_perm(self, perm, obj=None):
        return self.is_staff

    def has_module_perms(self, app_label):
        return self.is_staff

# models.py

from django.db import models

class Community(models.Model):
    community_name = models.CharField(max_length=100, unique=True)
 

    def __str__(self):
        return self.community_name

class CommunityMember(models.Model):
    community_name = models.CharField(max_length=100, unique=True)
    email = models.EmailField()

    def __str__(self):
        return self.email
from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone

class Message(models.Model):
    email = models.CharField(max_length=100)
    community_name = models.CharField(max_length=100, unique=True)
    content = models.TextField()
    timestamp = models.DateTimeField(default=timezone.now)


    def __str__(self):
        return self.community_name
