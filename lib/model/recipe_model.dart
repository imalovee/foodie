
class RecipeModel {
  List<Recipe> recipes;
  int total;
  int skip;
  int limit;

  RecipeModel({
    required this.recipes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
    recipes:
    List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
    total: json["total"] ?? 0,
    skip: json["skip"] ?? 0,
    limit: json["limit"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "recipes": List<dynamic>.from(recipes.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}


class Recipe{
    int id;
   String name;
   List<String> ingredients;
   List<String> instructions;
   int prepTimeMinutes;
   int cookTimeMinutes;
   int servings;
   String cusine;
   int caloriesPerServings;
   List<String> tags;
   int userId;
   String image;
   double rating;
   int reviewCount;
   List<String> mealType;
   String videoUrl;
   bool isBookmarked;

  Recipe({
    required this.id,
    required this.image,
    required this.name,
    required this.servings,
    required this.ingredients,
    required this.caloriesPerServings,
    required this.cookTimeMinutes,
    required this.cusine,
    required this.instructions,
    required this.mealType,
    required this.prepTimeMinutes,
    required this.rating,
    required this.reviewCount,
    required this.tags,
    required this.userId,
    required this.videoUrl,
    this.isBookmarked = false
});


  factory Recipe.fromJson(Map<String, dynamic>json) => Recipe(
      id: json['id'] ?? 0,
      image: json['image'] ?? "",
      name: json['name'] ?? "",
      servings: json['servings'] ?? "",
      ingredients: List<String>.from(json['ingredients']) ?? [],
      caloriesPerServings: json['caloriesPerServings'] ?? 15,
      cookTimeMinutes: json['cookTimeMinutes'] ?? 15 ,
      cusine: json['cusine'] ?? "",
      instructions: List<String>.from(json['instructions']) ?? [],
      mealType: List<String>.from(json['mealType']) ?? [],
      prepTimeMinutes: json['prepTimeMinutes'] ?? 5,
      rating: double.parse(json['rating'].toString() ) ,
      reviewCount: json['ratingCount'] ?? 2,
      tags: List<String>.from(json['tags']) ?? [],
      userId: json['userId'] ?? 1,
      videoUrl: ""
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'ingredients': ingredients,
    'instructions': instructions,
    'prepTimeMinutes': prepTimeMinutes,
    'cookTimeMinutes': cookTimeMinutes,
    'servings': servings,
    'cusine': cusine,
    'caloriesPerServings': caloriesPerServings,
    'tags': tags,
    'userId': userId,
    'image': image,
    'rating': rating,
    'reviewCount': reviewCount,
    'mealType': mealType,
  };
}