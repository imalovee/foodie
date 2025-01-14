

class MealsModel{
    String id;
   String title;
   String imgUrl;
   String videoUrl;
   List<String> instructions;
   List<String> ingredients;
   int prepTimeMinutes;
   int cookTimeMinutes;
   int servings;
   String cuisine;
   int caloriesPerServings;
   double rating;
   bool isbookMarked;

   MealsModel({
      required this.id,
      required this.title,
     required this.videoUrl,
     required this.instructions,
     required this.ingredients,
     required this.prepTimeMinutes,
     required this.cookTimeMinutes,
     required this.servings,
     required this.cuisine,
     required this.caloriesPerServings,
     required this.rating,
     required this.imgUrl,
     this.isbookMarked = false
});

   // factory MealsModel.fromJson(Map<String, dynamic> json) => MealsModel(
   //  id: json['id'] ?? 0,
   //  title: json['title'] ?? '',
   //  videoUrl: json['videoUrl'] ?? '',
   //  instructions: List<String>.from(json['instructions'] ?? []),
   //  methods: List<String>.from(json['methods']),
   //  prepTimeMinutes: prepTimeMinutes,
   //  cookTimeMinutes: cookTimeMinutes,
   //  servings: servings,
   //  cusine: cusine,
   //  caloriesPerServings: caloriesPerServings,
   //  rating: rating,
   //  imgUrl: imgUrl);
}