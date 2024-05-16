import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskScreen extends StatefulWidget {
  static const taskScreen = 'TaskScreen';
  TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _auth = FirebaseAuth.instance;

  User? loggedInUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser()async{
    try{
      final user = await _auth.currentUser;
      if (user != null){
        loggedInUser = user;
        print(user.email);
      }
    } catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(),
    );
  }
}
