import 'package:flutter/material.dart';
import 'package:recipe_app/model/recipe_model.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsScreen extends StatefulWidget {
  final Recipe recipe;
  const DetailsScreen({super.key, required this.recipe, });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // for detail screen image
                  Image(image:  NetworkImage(widget.recipe.image),
                    height: 400,
                    width: size.width,
                  ),
                  //for back button
                  Padding(
                      padding: MediaQuery.of(context).padding,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Positioned(
                    bottom: -70,
                      left: 20,
                      right: 20,
                      child: Container(
                        height: 140,
                        width: size.width,
                        decoration:  BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 5,
                              blurRadius: 5
                            )
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black26
                        ),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Padding(padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Name:${widget.recipe.name}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'MealType:${widget.recipe.mealType[0]}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                     const Text(
                                      " & ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Servings:${widget.recipe.servings.toString()}',
                                      style:  const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            ),
                            Container(
                              height: 55,
                              width: size.width,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)
                                )
                              ),
                              child:   Row(
                                children: [
                                  const SizedBox(width: 35),
                                  const Icon(Icons.star, color: Colors.orange),
                                  Text(widget.recipe.rating.toString()),
                                  const SizedBox(width: 50),
                                  const Icon(Icons.timer, color: Colors.green),
                                  Text(widget.recipe.cookTimeMinutes.toString()),
                                  const SizedBox(width: 50),
                                  const Icon(Icons.accessibility,
                                      color: Colors.blue),
                                  Text(
                                      '${widget.recipe.caloriesPerServings.toString()}kcl'),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  )
                ],
              ),
               Padding(padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 70),
                    const Text(
                      "Ingredients",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.green
                      ),
                    ),
                    Padding( padding: const EdgeInsets.only(left: 15, top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(widget.recipe.ingredients.length, (index){
                          return Text(widget.recipe.ingredients[index],
                          style: const TextStyle(color: Colors.black, fontSize: 17),);
                        }),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text('Instructions',
                    style: TextStyle(color: Colors.green,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),),
                    Padding(padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(widget.recipe.instructions.length, (index){
                        return Text(widget.recipe.instructions[index],
                        style: const TextStyle(
                          color: Colors.black, fontSize: 17
                        ),);
                      }),
                    ),)
                  ],
                ),
              ),
              //const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Watch Tutorial Video',
                style: TextStyle(color: Colors.green,
                    fontWeight: FontWeight.bold, fontSize: 18
                ),),
              ),
              if (widget.recipe.videoUrl != null && widget.recipe.videoUrl.isNotEmpty)
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: YoutubePlayer(
                   controller: YoutubePlayerController(
                       initialVideoId: YoutubePlayer.convertUrlToId(widget.recipe.videoUrl)!,
                     flags: const YoutubePlayerFlags(
                       autoPlay: true,
                       mute: false,
                       enableCaption: true,
                     )
                   ),
                 progressIndicatorColor: Colors.blue,
               ),
             ),

              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}

// String? videoId;
//   late YoutubePlayerController _youtubeController;
//   @override
//   void initState(){
//     super.initState();
//     fetchVideo();
//   }
//   // Fetch tutorial video using the recipe name
//   Future<void> fetchVideo()async{
//     YouTubeService youTubeService = YouTubeService();
//     final fetchedVideoId = await youTubeService.fetchRecipeVideoId(widget.recipe.name);
//     if(fetchedVideoId != null){
//         setState(() {
//           videoId = fetchedVideoId;
//           _youtubeController = YoutubePlayerController(
//               initialVideoId: videoId!,
//               flags: const YoutubePlayerFlags(
//                 autoPlay: true,
//                 mute: true,
//                 enableCaption: true,
//
//               )
//           );
//         });
//     }
//   }
//
//   @override
//   void dispose(){
//     super.dispose();
//   _youtubeController?.dispose();
//
//   }