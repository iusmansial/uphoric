import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uphoric/Chatroom/Test.dart';
import 'package:uphoric/Home/Homescreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyCc0gRHnhsYfkfSNax6aGHOwLmVTauAR54",
  authDomain: "auth-b3418.firebaseapp.com",
  projectId: "auth-b3418",
  storageBucket: "auth-b3418.appspot.com",
  messagingSenderId: "384606757572",
  appId: "1:384606757572:web:7dd9d484d4d97c2cee9f91"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Homescreen();
    
  }
}
