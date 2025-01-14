import 'package:flutter/material.dart';
import 'package:recipe_app/model/local_recipe_model/dummy_data.dart';
import 'package:recipe_app/screens/local_cuisine_screens/local_recipee_details.dart';

class LocalRecipeScreen extends StatelessWidget {
  const LocalRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var recipes = dummyMeals;
    return  Scaffold(
      backgroundColor: Colors.grey.shade100,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text('Nigerian Recipes'),
      //   centerTitle: true,
      // ) ,
      body: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, index){
            var recipeItem = recipes[index];
            return  Padding(padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return LocalRecipeeDetails(recipe: recipeItem);
                    }));
              },
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    decoration:  BoxDecoration(
                      //color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(image: NetworkImage(recipeItem.imgUrl),
                        fit: BoxFit.cover
                      ),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(-5, 7),
                          color: Colors.black
                        )
                      ]
                    ),
                  ),
                  Positioned(
                    left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 45,
                        decoration:  const BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16))
                        ),
                        child:  Padding(padding: const EdgeInsets.only(left: 10, right: 6),
                        child: Row(
                          children: [
                            Expanded(child: Text(recipeItem.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800
                              ),)),
                            const SizedBox(width: 20,),
                            const Icon(Icons.star, color: Colors.orange,),
                            Text(recipeItem.rating.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                                fontWeight: FontWeight.w800, fontSize: 18),),
                            const SizedBox(width: 20,),
                            Text(recipeItem.cookTimeMinutes.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800
                            ),),
                            const Text('Min', style: TextStyle(
                              color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800
                            ),)
                          ],
                        ),),
                      ))
                ],
              ),
            ),);
          }
      ),
    );
  }
}
