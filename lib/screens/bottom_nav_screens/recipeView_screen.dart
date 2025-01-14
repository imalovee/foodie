import 'package:flutter/material.dart';
import 'package:recipe_app/screens/International_cuisine_screens/recipe_screen.dart';
import 'package:recipe_app/screens/local_cuisine_screens/local_recipe_screen.dart';

class RecipeviewScreen extends StatefulWidget {
  const RecipeviewScreen({super.key});

  @override
  State<RecipeviewScreen> createState() => _RecipeviewScreenState();
}

class _RecipeviewScreenState extends State<RecipeviewScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Recipes'),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Padding(padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                indicator: BoxDecoration(
                 color: Colors.green,
                  borderRadius: BorderRadius.circular(8)
                ),
                labelColor: Colors.black,
                tabs: [
                  Container(
                    height: 35,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: const Text('International',
                    style: TextStyle(fontSize: 16),),
                  ),
                  Container(
                      height: 35,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: const Text('Nigerian',
                        style: TextStyle(fontSize: 16),))
                ],
              ),
              const Expanded(
                child: TabBarView(
                    children: [
                      RecipeScreen(),
                      LocalRecipeScreen()
                    ]
                ),
              )
            ],
          ),),
        )
    );

  }
}
