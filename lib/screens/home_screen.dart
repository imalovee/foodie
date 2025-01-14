import 'package:flutter/material.dart';
import 'package:recipe_app/screens/bottom_nav_screens/bookmarks_screen.dart';
import 'package:recipe_app/screens/bottom_nav_screens/homeView_screen.dart';
import 'package:recipe_app/screens/bottom_nav_screens/recipeView_screen.dart';
import 'package:recipe_app/screens/bottom_nav_screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  var screens = [
     const HomeviewScreen(),
     const RecipeviewScreen(),
     const BookmarksScreen(),
     const SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index){
          setState(() {
            selectedIndex = index;
          });
        },
        currentIndex: selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          //selectedLabelStyle: const TextStyle(color: Colors.green),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_sharp, ),
              label: 'Recipes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmarks, ),
              label: 'Bookmarks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, ),
              label: 'Settings',
            )
          ]),
    );
  }
}
