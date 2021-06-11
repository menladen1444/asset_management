// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:asset_management/homepage/components/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new SplashScreen1(),
  ));
}
