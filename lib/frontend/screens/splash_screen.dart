import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semanasi/backend/controllers/auth_controller.dart';
import 'package:semanasi/frontend/auth/login.dart';
import 'package:semanasi/frontend/screens/dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        ()  {
          if(AuthController.to.parseUser.value!=null){
            Get.offAll(()=>const Dashboard());
          }else{
            Get.offAll(()=>const Login());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245,242,237, 1),
      body: Center(
        child: Image.asset('img/first_logo.jpeg'),
      ),
    );
  }
}