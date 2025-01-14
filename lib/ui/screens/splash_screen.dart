import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:recipes/data_repository/dbHelper.dart';
import 'package:recipes/ui/screens/main_recipe_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: CircleAvatar(
        radius: 70,
        backgroundColor: Colors.blue,
        child: CircleAvatar(
          backgroundImage: AssetImage('images/food_logo.png'),
          radius: 40,
        ),
      ),
      nextScreen: MainRecipeScreen(),
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: Colors.black,
    );
  }
}
