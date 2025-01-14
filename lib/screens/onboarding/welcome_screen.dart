import 'package:flutter/material.dart';
import 'package:recipe_app/screens/International_cuisine_screens/recipe_screen.dart';
import 'package:recipe_app/screens/bottom_nav_screens/homeView_screen.dart';
import 'package:recipe_app/screens/home_screen.dart';
import 'package:recipe_app/screens/local_cuisine_screens/local_recipe_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 70,),
              const Center(child: Image(image: AssetImage('assets/images/chef2.png', )
              ),
              ),
              const SizedBox(height: 20,),
              const Text('CHECKOUT UNLIMITED PREMIUM RECIPES',
              style: TextStyle(color: Colors.green,
              fontWeight: FontWeight.bold),),
              const Text("It's Cooking\nTime!",
                style: TextStyle(color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  const HomeScreen()
                        ));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width*0.9, 49),
                      backgroundColor: Colors.green.shade400,
                      foregroundColor: Colors.white
                    ),
                    child: const Text('Lets Go!', style: TextStyle(fontSize: 16),))
            ],
          ),)),
    );
  }
}


//AIzaSyArVV-tl7Fd7Z3MVyw0GYlBcZkr_vyw3Gg