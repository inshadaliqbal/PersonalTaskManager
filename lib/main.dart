import 'package:flutter/material.dart';
import 'package:personaltaskmanager/pages/login_screen.dart';
import 'package:personaltaskmanager/helpers/provider_engine.dart';
import 'package:personaltaskmanager/pages/welcome_screen.dart';

// Importing the screens for navigation
import 'pages/registration_screen.dart';
import 'pages/task_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(TaskManager());
}

// A global key to access the navigator from anywhere in the app
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class TaskManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Providing the main engine as a ChangeNotifier
      create: (context) => MainEngine(),
      child: MaterialApp(
        // Setting the global navigator key
        navigatorKey: navigatorKey,
        initialRoute: WelcomeScreen.welcomeScreen,
        // Route definitions for navigation
        routes: {
          WelcomeScreen.welcomeScreen: (context) => const WelcomeScreen(),
          Registration.registrationScreen: (context) => const Registration(),
          LoginScreen.loginScreen: (context) => const LoginScreen(),
          TaskScreen.taskScreen: (context) => TaskScreen(),
        },
        // The default home widget, in case no route matches
        home: Scaffold(
          body: Container(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
