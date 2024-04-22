class ProductC {
  String id;
  int? code;
  String? url;
  String? creator;
  String? productName;
  String? genericName;
  String? quantity;
  String? packaging;
  String? packagingTags;
  String? brands;
  String? brandsTags;
  String? categories;
  String? categoriesTags;
  String? categoriesEn;
  String? origins;
  String? originsTags;
  String? manufacturingPlaces;
  String? manufacturingPlacesTags;
  String? labels;
  String? labelsTags;
  String? labelsEn;
  String? stores;
  String? countries;
  String? countriesTags;
  String? countriesEn;
  String? ingredientsText;
  int? additivesN;
  String? additives;
  String? additivesTags;
  String? additivesEn;
  int? ingredientsFromPalmOilN;
  int? ingredientsThatMayBeFromPalmOilN;
  String? states;
  String? statesTags;
  String? statesEn;
  String? mainCategory;
  String? mainCategoryEn;
  String? imageUrl;
  String? imageSmallUrl;
  List<dynamic>? allergens;
  List<dynamic>? carcinogenic;
  List<dynamic>? endocrine;
  List<dynamic>? neurotoxicity;
  List<dynamic>? persistent;
  List<dynamic>? ecotoxicity;
  List<dynamic>? irritation;
  List<dynamic>? occupationalHazards;
  List<dynamic>? contamination;
  List<dynamic>? developmentalReproductiveToxicity;
  List<dynamic>? miscellaneous;

  double? score;
  String? pnnsGroups1;
  String? backgroundRemovedImage;

  ProductC({
    required this.id,
    this.code,
    this.url,
    this.creator,
    this.productName,
    this.genericName,
    this.quantity,
    this.packaging,
    this.packagingTags,
    this.brands,
    this.brandsTags,
    this.categories,
    this.categoriesTags,
    this.categoriesEn,
    this.origins,
    this.originsTags,
    this.manufacturingPlaces,
    this.manufacturingPlacesTags,
    this.labels,
    this.labelsTags,
    this.labelsEn,
    this.stores,
    this.countries,
    this.countriesTags,
    this.countriesEn,
    this.ingredientsText,
    this.additivesN,
    this.additives,
    this.additivesTags,
    this.additivesEn,
    this.ingredientsFromPalmOilN,
    this.ingredientsThatMayBeFromPalmOilN,
    this.states,
    this.statesTags,
    this.statesEn,
    this.mainCategory,
    this.mainCategoryEn,
    this.imageUrl,
    this.imageSmallUrl,
    this.allergens,
    this.carcinogenic,
    this.endocrine,
    this.neurotoxicity,
    this.persistent,
    this.ecotoxicity,
    this.irritation,
    this.occupationalHazards,
    this.contamination,
    this.developmentalReproductiveToxicity,
    this.miscellaneous,
    this.score,
    this.pnnsGroups1,
    this.backgroundRemovedImage,
  });

  Map<String, dynamic> get problematic {
    return {
      'allergens': allergens,
      'carcinogenic': carcinogenic,
      'endocrine': endocrine,
      'neurotoxicity': neurotoxicity,
      'persistent': persistent,
      'ecotoxicity': ecotoxicity,
      'irritation': irritation,
      'occupationalHazards': occupationalHazards,
      'contamination': contamination,
      'developmentalReproductiveToxicity': developmentalReproductiveToxicity,
      'miscellaneous': miscellaneous,
    };
  }

  Map<String, dynamic> get ingredientsadditives {
    return {
      'Ingredients': ingredientsText,
      'additives': additivesEn,
    };
  }

  factory ProductC.fromJson(Map<String, dynamic> json) {
    return ProductC(
      id: json['_id'],
      code: json['code'],
      url: json['url'],
      creator: json['creator'],
      productName: json['product_name'],
      genericName: json['generic_name'],
      quantity: json['quantity'],
      packaging: json['packaging'],
      packagingTags: json['packaging_tags'],
      brands: json['brands'],
      brandsTags: json['brands_tags'],
      categories: json['categories'],
      categoriesTags: json['categories_tags'],
      categoriesEn: json['categories_en'],
      origins: json['origins'],
      originsTags: json['origins_tags'],
      manufacturingPlaces: json['manufacturing_places'],
      manufacturingPlacesTags: json['manufacturing_places_tags'],
      labels: json['labels'],
      labelsTags: json['labels_tags'],
      labelsEn: json['labels_en'],
      stores: json['stores'],
      countries: json['countries'],
      countriesTags: json['countries_tags'],
      countriesEn: json['countries_en'],
      ingredientsText: json['ingredients_text'],
      additivesN: json['additives_n'],
      additives: json['additives'],
      additivesTags: json['additives_tags'],
      additivesEn: json['additives_en'],
      ingredientsFromPalmOilN: json['ingredients_from_palm_oil_n'],
      ingredientsThatMayBeFromPalmOilN:
          json['ingredients_that_may_be_from_palm_oil_n'],
      states: json['states'],
      statesTags: json['states_tags'],
      statesEn: json['states_en'],
      mainCategory: json['main_category'],
      mainCategoryEn: json['main_category_en'],
      imageUrl: json['image_url'],
      imageSmallUrl: json['image_small_url'],
      allergens: json['allergens'],
      carcinogenic: json['carcinogenic'],
      endocrine: json['endocrine'],
      neurotoxicity: json['neurotoxicity'],
      persistent: json['persistent'],
      ecotoxicity: json['ecotoxicity'],
      irritation: json['irritation'],
      occupationalHazards: json['occupational_hazards'],
      contamination: json['contamination'],
      developmentalReproductiveToxicity:
          json['developmental_reproductive_toxicity'],
      miscellaneous: json['miscellaneous'],
      score: json['score'] != null
          ? double.tryParse(json['score'].toString())
          : null,
      pnnsGroups1: json['pnns_groups_1'],
      backgroundRemovedImage: json['background_removed_image'],
    );
  }
}
