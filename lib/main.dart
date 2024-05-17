
import 'package:flutter/material.dart';
import 'package:personaltaskmanager/login_screen.dart';
import 'package:personaltaskmanager/provider_engine.dart';
import 'package:personaltaskmanager/welcome_screen.dart';
import 'registration_screen.dart';
import 'task_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(TaskManager());
}

class TaskManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainEngine(),
      child: MaterialApp(
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
      ),
    );
  }
}
