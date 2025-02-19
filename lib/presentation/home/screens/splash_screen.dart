import 'package:atharitmt/presentation/home/screens/home_splash.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
        return const HomeSplash();
      }), (route) => false);
    });
    return const Scaffold(
      backgroundColor: Colors.black,
      body:  Center(child: Text('UseBy',style: TextStyle(fontSize: 70,color: Colors.white),)),

    );
  }
}