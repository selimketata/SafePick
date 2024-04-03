from rest_framework import serializers
from .models import ProductF, ProductC

class ProductFSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductF
        fields = '__all__'

class ProductCSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductC
        fields = '__all__'
