import 'package:flutter/material.dart';
import 'package:personaltaskmanager/constants.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'style.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'provider_engine.dart';
import 'package:provider/provider.dart';
import 'buttons.dart';
import 'package:alarm/alarm.dart';

class WelcomeScreen extends StatefulWidget {
  static String welcomeScreen = 'welcome_screen';
  const WelcomeScreen({super.key});

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
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.white, end: Color(0xFFFFF2E1))
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });

    Alarm.init();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MainEngine>(context).fireBaseInitialize();
    var squareBGCustomPaint = SquareBGCustomPaint(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              'Personal Task Manager',
              style: kWelcomePageMainTitle,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Icon(
                    Icons.task,
                    size: 60,
                    color: Colors.black,
                  ),
                ),
              ),
              DefaultTextStyle(
                style: kMainPageAnimationTextStyle,
                child: AnimatedTextKit(
                  animatedTexts: [
                    ScaleAnimatedText('Personal'),
                    ScaleAnimatedText('Task Manager'),
                  ],
                ),
              ),
            ],
          ),
          MainButton(
            buttonColor: Colors.blueAccent.shade200,
            buttonText: 'LOGIN',
            buttonOnPress: () {
              Navigator.pushNamed(context, LoginScreen.loginScreen);
            },
          ),
          MainButton(
            buttonColor: Colors.cyan,
            buttonText: 'REGISTER',
            buttonOnPress: () {
              Navigator.pushNamed(context, Registration.registrationScreen);
            },
          )
        ],
      ),
    );
    return Scaffold(
      backgroundColor: animation.value,
      body: squareBGCustomPaint,
    );
  }
}

