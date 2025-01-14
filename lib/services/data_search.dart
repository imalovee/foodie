import 'package:flutter/material.dart';
import 'package:recipe_app/screens/local_cuisine_screens/local_recipee_details.dart';

import '../model/recipe_model.dart';

class DataSearch extends SearchDelegate<String>{
  final List<String> recipeNames;
  DataSearch({required this.recipeNames});

  //create a list of recipes to be suggested
  final List<String> suggestedNames = [
    'Amala and ewedu',
    'Ofe Aku',
    'Suya meat',
    'Kilishi',
    'Yam Porridge'
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
   return [
     IconButton(
         onPressed: (){
           query = '';
         },
         icon: const Icon(Icons.cancel))
   ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    IconButton(
        onPressed: (){

        },
        icon: const Icon(Icons.search));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    final result = recipeNames.where((title) => title.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
        itemCount: result.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(result[index]),
            leading: const Icon(Icons.fastfood_sharp),
            onTap: (){

            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionList = query.isEmpty? suggestedNames : recipeNames.
    where((title) => title.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index){
      return ListTile(
        title: Text(suggestionList[index]),
        leading: const Icon(Icons.fastfood_rounded),
        onTap: (){
          query = suggestionList[index];
          showResults(context);
        },
      );
    });
  }

  // Recipe? findRecipeByTitle(String title){
  //   return [...apiRecipeList, ...manualRecipeList].firstWhere(recipeNames)=> recipeNames.title == title,
  // }
  
}