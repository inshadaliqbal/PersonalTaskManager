import 'package:flutter/material.dart';
import 'package:personaltaskmanager/constants/constants.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import '../constants/style.dart';
import '../helpers/provider_engine.dart';
import 'package:provider/provider.dart';
import '../widgets/buttons.dart';
import 'package:alarm/alarm.dart';

class WelcomeScreen extends StatefulWidget {
  static String welcomeScreen = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    // Initializing animation controller
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    // Defining color animation
    animation = ColorTween(begin: Colors.white, end: const Color(0xFFFFF2E1))
        .animate(controller);
    controller.forward();
    // Adding listener to animation controller
    controller.addListener(() {
      setState(() {});
    });

    // Initializing alarm service
    Alarm.init();
  }

  @override
  void dispose() {
    super.dispose();
    // Disposing animation controller
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initializing Firebase
    Provider.of<MainEngine>(context).fireBaseInitialize();
    var squareBGCustomPaint = SquareBGCustomPaint(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Text(
                  'Personal \nTask Manager. ',
                  style: kWelcomePageMainTitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            MainButton(
              buttonColor: Colors.blueAccent.shade200,
              buttonText: 'LOGIN',
              buttonOnPress: () {
                Navigator.pushNamed(context, LoginScreen.loginScreen);
              },
            ),
            MainButton(
              buttonColor: Colors.blueAccent.shade200,
              buttonText: 'REGISTER',
              buttonOnPress: () {
                Navigator.pushNamed(context, Registration.registrationScreen);
              },
            )
          ],
        ),
      ),
    );
    return Scaffold(
      backgroundColor: animation.value,
      body: squareBGCustomPaint,
    );
  }
}
