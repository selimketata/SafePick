class ProductF {
  String id;
  int? code;
  String? url;
  String? productName;
  String? categories;
  String? categoriesTags;
  String? categoriesEn;
  String? labels;
  String? labelsTags;
  String? labelsEn;
  String? ingredientsText;
  String? ingredientsTags;
  String? ingredientsAnalysisTags;
  String? allergens;
  int? additivesN;
  int? nutriscoreScore;
  String? nutriscoreGrade;
  int? novaGroup;
  String? pnnsGroups1;
  String? pnnsGroups2;
  String? foodGroups;
  String? foodGroupsTags;
  String? foodGroupsEn;
  String? states;
  String? statesTags;
  String? statesEn;
  String? brandOwner;
  String? ecoscoreGrade;
  String? nutrientLevelsTags;
  String? mainCategory;
  String? mainCategoryEn;
  String? imageUrl;
  double? energy100g;
  double? fat100g;
  double? saturatedFat100g;
  double? transFat100g;
  double? cholesterol100g;
  double? carbohydrates100g;
  double? sugars100g;
  double? fiber100g;
  double? proteins100g;
  double? salt100g;
  double? sodium100g;
  double? vitaminA100g;
  double? vitaminK100g;
  double? vitaminC100g;
  double? vitaminB1100g;
  double? vitaminB2100g;
  double? vitaminPp100g;
  double? vitaminB6100g;
  double? vitaminB9100g;
  double? pantothenicAcid100g;
  double? potassium100g;
  double? calcium100g;
  double? phosphorus100g;
  double? iron100g;
  double? magnesium100g;
  double? zinc100g;
  double? copper100g;
  double? manganese100g;
  double? selenium100g;
  double? fruitsVegetablesNuts100g;
  double? nutritionScoreFr100g;
  double? phylloquinone100g;
  int? nutriscoreScoreOutOf100;
  String? backgroundRemovedImage;
  double? energyKcal100g;

  ProductF({
    required this.id,
    this.code,
    this.url,
    this.productName,
    this.categories,
    this.categoriesTags,
    this.categoriesEn,
    this.labels,
    this.labelsTags,
    this.labelsEn,
    this.ingredientsText,
    this.ingredientsTags,
    this.ingredientsAnalysisTags,
    this.allergens,
    this.additivesN,
    this.nutriscoreScore,
    this.nutriscoreGrade,
    this.novaGroup,
    this.pnnsGroups1,
    this.pnnsGroups2,
    this.foodGroups,
    this.foodGroupsTags,
    this.foodGroupsEn,
    this.states,
    this.statesTags,
    this.statesEn,
    this.brandOwner,
    this.ecoscoreGrade,
    this.nutrientLevelsTags,
    this.mainCategory,
    this.mainCategoryEn,
    this.imageUrl,
    this.energy100g,
    this.fat100g,
    this.saturatedFat100g,
    this.transFat100g,
    this.cholesterol100g,
    this.carbohydrates100g,
    this.sugars100g,
    this.fiber100g,
    this.proteins100g,
    this.salt100g,
    this.sodium100g,
    this.vitaminA100g,
    this.vitaminK100g,
    this.vitaminC100g,
    this.vitaminB1100g,
    this.vitaminB2100g,
    this.vitaminPp100g,
    this.vitaminB6100g,
    this.vitaminB9100g,
    this.pantothenicAcid100g,
    this.potassium100g,
    this.calcium100g,
    this.phosphorus100g,
    this.iron100g,
    this.magnesium100g,
    this.zinc100g,
    this.copper100g,
    this.manganese100g,
    this.selenium100g,
    this.fruitsVegetablesNuts100g,
    this.nutritionScoreFr100g,
    this.phylloquinone100g,
    this.nutriscoreScoreOutOf100,
    this.backgroundRemovedImage,
    this.energyKcal100g,
  });
  Map<String, dynamic> get nutrientMap {
    return {
      'fat100g': fat100g,
      'saturatedFat100g': saturatedFat100g,
      'transFat100g': transFat100g,
      'cholesterol100g': cholesterol100g,
      'carbohydrates100g': carbohydrates100g,
      'sugars100g': sugars100g,
      'fiber100g': fiber100g,
      'proteins100g': proteins100g,
      'salt100g': salt100g,
      'sodium100g': sodium100g,
      'vitaminA100g': vitaminA100g,
      'vitaminK100g': vitaminK100g,
      'vitaminC100g': vitaminC100g,
      'vitaminB1100g': vitaminB1100g,
      'vitaminB2100g': vitaminB2100g,
      'vitaminPp100g': vitaminPp100g,
      'vitaminB6100g': vitaminB6100g,
      'vitaminB9100g': vitaminB9100g,
      'pantothenicAcid100g': pantothenicAcid100g,
      'potassium100g': potassium100g,
      'calcium100g': calcium100g,
      'phosphorus100g': phosphorus100g,
      'iron100g': iron100g,
      'magnesium100g': magnesium100g,
      'zinc100g': zinc100g,
      'copper100g': copper100g,
      'manganese100g': manganese100g,
      'selenium100g': selenium100g,
      'fruitsVegetablesNuts100g': fruitsVegetablesNuts100g,
      'phylloquinone100g': phylloquinone100g,
      'allergens': allergens,
      'additivesN': additivesN
    };
  }

  factory ProductF.fromJson(Map<String, dynamic> json) {
    double? parseDouble(dynamic value, String fieldName) {
      if (value == null) return null;
      try {
        return double.tryParse(value.toString()) ?? (throw FormatException("Failed to parse $fieldName as double."));
      } catch (e) {
        throw FormatException("Failed to parse $fieldName with value $value as double. Error: $e");
      }
    }

    return ProductF(
      id: json['_id'],
      code: json['code'],
      url: json['url'],
      productName: json['product_name'],
      categories: json['categories'],
      categoriesTags: json['categories_tags'],
      categoriesEn: json['categories_en'],
      labels: json['labels'],
      labelsTags: json['labels_tags'],
      labelsEn: json['labels_en'],
      ingredientsText: json['ingredients_text'],
      ingredientsTags: json['ingredients_tags'],
      ingredientsAnalysisTags: json['ingredients_analysis_tags'],
      allergens: json['allergens'],
      additivesN: json['additives_n'],
      nutriscoreScore: json['nutriscore_score'],
      nutriscoreGrade: json['nutriscore_grade'],
      novaGroup: json['nova_group'],
      pnnsGroups1: json['pnns_groups_1'],
      pnnsGroups2: json['pnns_groups_2'],
      foodGroups: json['food_groups'],
      foodGroupsTags: json['food_groups_tags'],
      foodGroupsEn: json['food_groups_en'],
      states: json['states'],
      statesTags: json['states_tags'],
      statesEn: json['states_en'],
      brandOwner: json['brand_owner'],
      ecoscoreGrade: json['ecoscore_grade'],
      nutrientLevelsTags: json['nutrient_levels_tags'],
      mainCategory: json['main_category'],
      mainCategoryEn: json['main_category_en'],
      imageUrl: json['image_url'],
      energy100g: parseDouble(json['energy_100g'], 'energy100g'),
      fat100g: parseDouble(json['fat_100g'], 'fat100g'),
      saturatedFat100g: parseDouble(
          json['saturated_fat_100g'], 'saturatedFat100g'),
      transFat100g: parseDouble(json['trans_fat_100g'], 'transFat100g'),
      cholesterol100g: parseDouble(json['cholesterol_100g'], 'cholesterol100g'),
      carbohydrates100g: parseDouble(
          json['carbohydrates_100g'], 'carbohydrates100g'),
      sugars100g: parseDouble(json['sugars_100g'], 'sugars100g'),
      fiber100g: parseDouble(json['fiber_100g'], 'fiber100g'),
      proteins100g: parseDouble(json['proteins_100g'], 'proteins100g'),
      salt100g: parseDouble(json['salt_100g'], 'salt100g'),
      sodium100g: parseDouble(json['sodium_100g'], 'sodium100g'),
      vitaminA100g: parseDouble(json['vitamin_a_100g'], 'vitaminA100g'),
      vitaminK100g: parseDouble(json['vitamin_k_100g'], 'vitaminK100g'),
      vitaminC100g: parseDouble(json['vitamin_c_100g'], 'vitaminC100g'),
      vitaminB1100g: parseDouble(json['vitamin_b1_100g'], 'vitaminB1100g'),
      vitaminB2100g: parseDouble(json['vitamin_b2_100g'], 'vitaminB2100g'),
      vitaminPp100g: parseDouble(json['vitamin_pp_100g'], 'vitaminPp100g'),
      vitaminB6100g: parseDouble(json['vitamin_b6_100g'], 'vitaminB6100g'),
      vitaminB9100g: parseDouble(json['vitamin_b9_100g'], 'vitaminB9100g'),
      pantothenicAcid100g: parseDouble(
          json['pantothenic_acid_100g'], 'pantothenicAcid100g'),
      potassium100g: parseDouble(json['potassium_100g'], 'potassium100g'),
      calcium100g: parseDouble(json['calcium_100g'], 'calcium100g'),
      phosphorus100g: parseDouble(json['phosphorus_100g'], 'phosphorus100g'),
      iron100g: parseDouble(json['iron_100g'], 'iron100g'),
      magnesium100g: parseDouble(json['magnesium_100g'], 'magnesium100g'),
      zinc100g: parseDouble(json['zinc_100g'], 'zinc100g'),
      copper100g: parseDouble(json['copper_100g'], 'copper100g'),
      manganese100g: parseDouble(json['manganese_100g'], 'manganese100g'),
      selenium100g: parseDouble(json['selenium_100g'], 'selenium100g'),
      fruitsVegetablesNuts100g: parseDouble(
          json['fruits_vegetables_nuts_estimate_from_ingredients_100g'],
          'fruitsVegetablesNutsEstimateFromIngredients100g'),
      nutritionScoreFr100g: parseDouble(
          json['nutrition_score_fr_100g'], 'nutritionScoreFr100g'),
      phylloquinone100g: parseDouble(
          json['phylloquinone_100g'], 'phylloquinone100g'),
      nutriscoreScoreOutOf100: json['nutriscore_score_out_of_100'],
      backgroundRemovedImage: json['background_removed_image'],
      energyKcal100g: parseDouble(json['energy_kcal_100g'], 'energyKcal100g'),
    );
  }
}