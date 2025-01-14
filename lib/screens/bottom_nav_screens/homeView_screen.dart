import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:recipe_app/model/local_recipe_model/dummy_data.dart';
import 'package:recipe_app/screens/local_cuisine_screens/local_recipee_details.dart';

import '../../controllers/user_controller.dart';

class HomeviewScreen extends StatefulWidget {
  const HomeviewScreen({super.key});

  @override
  State<HomeviewScreen> createState() => _HomeviewScreenState();
}

class _HomeviewScreenState extends State<HomeviewScreen> {
  List<String> combinedRecipeList = [
  ];
  var mealCategory = categories;
  var recipeItems = dummyMeals;
  UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.grey.shade50,
      body:  SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Obx((){
                  return Row(
                    children: [
                      const Text('Hello',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          fontSize: 16
                        ),),
                      const SizedBox(width: 6,),
                      Text(userController.name.value.isEmpty? 'Anne'
                          : userController.name.value
                        , style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 16
                      ),),
                    ],
                  );
                }),
                 const SizedBox(height: 8,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('What would you like\n to cook today?',  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800
                    ),),
                    Obx((){
                      return userController.image.value.isNotEmpty?
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.green,
                        backgroundImage: NetworkImage(userController.image.value),
                      ):
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.green,
                            child: Icon(Icons.person, color: Colors.white,),
                          );
                    })
                  ],
                ),
                const SizedBox(height: 16,),
                const SearchBar(
                  hintText: 'Search any recipes',
                  hintStyle: WidgetStatePropertyAll(TextStyle(color: Colors.grey)),
                  leading: Icon(Icons.saved_search),
                  trailing: [Icon(Icons.cancel)],
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 15, vertical: 8)),
                  elevation: WidgetStatePropertyAll(1.0),
                ),
                const SizedBox(height: 16,),
                const Text('Categories', style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20
                ),),
                const SizedBox(height: 8,),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: mealCategory.length,
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                      var mealItem = mealCategory[index];
                    return Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          shape: BoxShape.rectangle
                        ),
                        child: Image(image: AssetImage(mealItem.imageUrl),),
                      ),
                        Text(mealItem.title, style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                        ),),
                    ],);
                  }),
                ),
                const SizedBox(height: 8,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Recommended For You', style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6 ,
                          itemBuilder: (context, index){
                          var recipe = recipeItems[index];
                            return  GestureDetector(
                              onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context){
                                      return LocalRecipeeDetails(recipe: recipe);
                                    }));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 176,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 12),
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(image: NetworkImage(recipe.imgUrl),
                                        fit: BoxFit.cover)
                                      ),
                                    ),
                                  ),
                                  Text(recipe.title, style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  ),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.timer, color: Colors.green,),
                                      Text(recipe.cookTimeMinutes.toString()),
                                      const SizedBox(width: 8,),
                                      const Icon(Icons.star, color: Colors.orange,),
                                      Text(recipe.rating.toString())
                                    ],
                                  )
                                ],
                              ),
                            );
                          }
                      ),
                    )
                  ],
                )
              ],
            ),),
          )),
    );
  }
}
