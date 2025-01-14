import 'package:flutter/material.dart';
import 'package:recipe_app/model/local_recipe_model/meals_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LocalRecipeeDetails extends StatefulWidget {
  final MealsModel recipe ;
  const LocalRecipeeDetails({super.key,required this.recipe});

  @override
  State<LocalRecipeeDetails> createState() => _LocalRecipeeDetailsState();
}

class _LocalRecipeeDetailsState extends State<LocalRecipeeDetails> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold( 
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(widget.recipe.title, style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),) ,
      ),
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding:  const EdgeInsets.all(8.0),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(image: NetworkImage(widget.recipe.imgUrl),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Colors.white)
                          ),
                          icon: const Icon(Icons.arrow_back, color: Colors.black,)),
                      IconButton(onPressed: (){
                        setState(() {
                          widget.recipe.isbookMarked = !widget.recipe.isbookMarked;
                        });
                      },
                          style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Colors.white)
                          ),
                          icon: Icon(
                            widget.recipe.isbookMarked? Icons.bookmark_added
                                : Icons.bookmark,
                            color: widget.recipe.isbookMarked? Colors.red: Colors.black ,))
                    ],
                  ),
                ),
                Positioned(
                  left: 20,
                    right: 20,
                    bottom: -40,
                    child: Container(
                      height: 140,
                      decoration:  BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            spreadRadius: 5,
                            blurRadius: 5,
                            color: Colors.black12
                          )
                        ]
                      ),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                const Text('Cuisine: ' , style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20
                                ),),

                                Text(widget.recipe.cuisine, style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18
                                ),)
                              ],
                            ),
                          ),
                          Container(
                            height: 55,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                    '${widget.recipe.caloriesPerServings.toString()}kcl')
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
            const SizedBox(height: 30,),
             Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ingredients', style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    //fontWeight: FontWeight.w800
                  ),),
                  Padding(padding: const EdgeInsets.only(left: 15, top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for(var ingredients in widget.recipe.ingredients)
                        Text(ingredients, style: const TextStyle(
                          fontSize: 16
                        ),)
                    ],
                  ),),
                  const SizedBox(height: 20,),
                  const Text('Cooking Instructions', style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    //fontWeight: FontWeight.w800
                  ),),
                   Padding(padding: const EdgeInsets.only(left: 15, top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                      List.generate(widget.recipe.instructions.length, (index){
                        return Text(widget.recipe.instructions[index], style: const TextStyle(
                          fontSize: 17,
                          //fontWeight: FontWeight.w800
                        ),);
                      })

                  ),)
                ],
              ),
            ),
            const SizedBox(height: 20,),
            const Padding(padding: EdgeInsets.all(16),
            child: Text('Watch Tutorial Video'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: YoutubePlayer(
                  controller: YoutubePlayerController(
                      initialVideoId: YoutubePlayer.convertUrlToId(widget.recipe.videoUrl)!,
                    flags: const YoutubePlayerFlags(
                      autoPlay: true,
                      mute: false,
                      enableCaption: true,
                      captionLanguage: 'en',
                      controlsVisibleAtStart: true
                    )
                  ),
              showVideoProgressIndicator: true,),
            )
          ],
        ),
      ),
    );
  }
}
