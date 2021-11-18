import 'package:flutter/material.dart';
import 'package:interview_assesment/login_screen.dart';
import 'package:interview_assesment/weight_screen.dart';
import 'main_screen.dart';
import 'package:interview_assesment/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: 'main_screen',
        routes: {
          'main_screen':(context)=>main_screen(),
          'signin_screen':(context)=>signin_screen(),
          'login_screen':(context)=>login_screen(),
          'weight_screen':(context)=>weight_screen(),
        }
    );
  }
}
