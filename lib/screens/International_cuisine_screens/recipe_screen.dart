import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:recipe_app/screens/International_cuisine_screens/details_screen.dart';
import 'package:recipe_app/services/recipe_service.dart';

import '../../model/recipe_model.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final controller = Get.put(ServiceController());
  @override
  Widget build(BuildContext context) {
    return Obx((){
      final screenState = controller.isLoading.value;
      final recipes = controller.recipesWithVideos;
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: const Text('Recipes', style: TextStyle(fontWeight: FontWeight.bold,
        //  ),),
        //   centerTitle: true,
        // ),
        body: screenState? const Center(
          child: CircularProgressIndicator(color: Colors.blueAccent,),
        ) :
        ListView.builder(
            itemCount: recipes.length ,
            itemBuilder: (context, index){
              final recipe = recipes[index];
              return  Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  DetailsScreen(recipe: recipe,),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image:  DecorationImage(
                            image: NetworkImage(recipe.image),
                            fit: BoxFit.fill,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(-5, 7),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            height: 45,
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child:   Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      recipe.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const Icon(Icons.star,color: Colors.orange,
                                ),
                                Text(
                                  recipe.rating.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  recipe.cookTimeMinutes.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  " min",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                ),
              );
            }
        ),
      );
    }
    );
  }
}
