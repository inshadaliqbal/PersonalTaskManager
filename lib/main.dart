import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personaltaskmanager/login_screen.dart';
import 'package:personaltaskmanager/welcome_screen.dart';
import 'registration_screen.dart';
import 'task_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAJ-xNtN1_kscOT4cQlk-3F45SRAki-rF0',
      appId: 'id',
      messagingSenderId: 'sendid',
      projectId: 'personal-task-manager-c526b',
      storageBucket: 'myapp-b9yt18.appspot.com',
    ),
  );
  runApp(TaskManager());
}

class TaskManager extends StatefulWidget {
  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.welcomeScreen,
      routes: {
        WelcomeScreen.welcomeScreen: (context) => const WelcomeScreen(),
        Registration.registrationScreen: (context) => const Registration(),
        LoginScreen.loginScreen: (context) => const LoginScreen(),
        TaskScreen.taskScreen: (context) => TaskScreen(),

      },
      home: Scaffold(
        body: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
