import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/model/recipe_model.dart';

class ServiceController extends GetxController{
  var isLoading = true.obs;
  var recipesModel = RecipeModel(recipes: [], total: 0, skip: 0, limit: 0).obs;
  var recipesWithVideos = <Recipe>[].obs;

  @override
  void onInit(){
    super.onInit();
    fetchRecipeWithVideos();
  }

  Future<List<Recipe>> fetchRecipes() async {
    try {
      var url = Uri.parse('https://dummyjson.com/recipes');
      var response = await http.get(url);
     // isLoading.toggle();

      if (response.statusCode == 200) {  // Only process for successful status codes
        final body = jsonDecode(response.body) as Map<String, dynamic>;

        // Ensure recipesModel is updated correctly
        recipesModel.value = RecipeModel.fromJson(body);

        print('Recipes fetched successfully!');

      } else {
        // Log error if the status code is not 200
        print('Failed to load recipes. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load recipes. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Log the exact error for debugging
      if (kDebugMode) {
        print('An error occurred: ${e.toString()}');
      }
      throw Exception('Couldn\'t load data: ${e.toString()}');
    }finally{
      isLoading.value = false;
    }
    return recipesModel.value.recipes   ;
  }

  Map<String, String> recipeVideoUrls = {
    '1': 'https://www.youtube.com/watch?v=bSMOMzyhGtI',
    '2': 'https://www.youtube.com/watch?v=h8IXBipqYgs',
    '3': 'https://www.youtube.com/watch?v=PFJAuAWxuvI',
    '4': 'https://www.youtube.com/watch?v=2vDWtRpXw5Q',
    '5': 'https://www.youtube.com/watch?v=L-txjOVg6G4',
    '6': 'https://www.youtube.com/watch?v=OQ9mU_zAtEs',
    '7': 'https://www.youtube.com/watch?v=Q3xg35pcLyo',
    '8': 'https://www.youtube.com/watch?v=8eITNSfct3Q',
    '9': 'https://www.youtube.com/watch?v=gOcfUgd4ekA',
    '10': 'https://www.youtube.com/watch?v=6lG_ZoF8ozk',
    '11': 'https://www.youtube.com/watch?v=95BCU1n268w',
    '12': 'https://www.youtube.com/watch?v=XDYNofJ1zI8',
    '13': 'https://www.youtube.com/watch?v=mPvd7fXxmqg',
    '14': 'https://www.youtube.com/watch?v=bqeivKZWP4Q',
    '15': 'https://www.youtube.com/watch?v=d8nJW-mA5DI',
    '16': 'https://www.youtube.com/watch?v=nC4t1LDDt4A',
    '17': 'https://www.youtube.com/watch?v=s7El4-hgEVE',
    '18': 'https://www.youtube.com/watch?v=_Bm-Y_skmeU',
    '19': 'https://www.youtube.com/watch?v=8U_29i9Qp5U',
    '20': 'https://www.youtube.com/watch?v=a03U45jFxOI',
    '21': 'https://www.youtube.com/watch?v=-cnfV7PwHH4',
    '22': 'https://www.youtube.com/watch?v=WoAvXV4lPZ0',
    '23': 'https://www.youtube.com/watch?v=7VTtenyKRg4',
    '24': 'https://www.youtube.com/watch?v=tNIMwUKCeNE',
    '25': 'https://www.youtube.com/watch?v=Q7HSqukRZTs',
    '26': 'https://www.youtube.com/watch?v=Mn6UgydcOPo',
    '27': 'https://www.youtube.com/watch?v=6CXgPVw_-0g',
    '28': 'https://www.youtube.com/watch?v=2PT3lvVfuYY',
    '29': 'https://www.youtube.com/watch?v=1kCTndfsoWU',
    '30': 'https://www.youtube.com/watch?v=ittNBnd1oT0',
  };

  Future<List<Recipe>> fetchRecipeWithVideos()async{
    isLoading.value = true;
    List<Recipe>fetchedRecipes = await fetchRecipes();
    // Map the video URLs to the fetched recipes
    List<Recipe> mappedRecipes = fetchedRecipes.map((recipe) {
      String recipeId = recipe.id.toString();
      String? videoUrl = recipeVideoUrls[recipeId];
      return Recipe(
          id: recipe.id,
          image: recipe.image,
          name: recipe.name,
          servings: recipe.servings,
          ingredients: recipe.ingredients,
          caloriesPerServings: recipe.caloriesPerServings,
          cookTimeMinutes: recipe.cookTimeMinutes,
          cusine: recipe.cusine,
          instructions: recipe.instructions,
          mealType: recipe.mealType,
          prepTimeMinutes: recipe.prepTimeMinutes,
          rating: recipe.rating,
          reviewCount: recipe.reviewCount,
          tags: recipe.tags,
          userId: recipe.userId,
          videoUrl: videoUrl ?? "");
    }).toList();
      isLoading.value = false;
    return recipesWithVideos.value = mappedRecipes;

  }
}