import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
      duration: Duration(seconds: 5),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.white, end: Colors.tealAccent)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
      print(animation.value);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      appBar: AppBar(
        title: Center(
          child: Text('Chat App'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Icon(
                    Icons.electric_bolt,
                    size: 60,
                    color: Colors.orangeAccent.shade400,
                  ),
                ),
              ),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 70.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Canterbury',
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    ScaleAnimatedText('CHAT'),
                    ScaleAnimatedText('APP'),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          roundedButton(
            buttonColor: Colors.blueAccent.shade200,
            buttonText: 'LOGIN',
            buttonDest: () {
              Navigator.pushNamed(context, LoginScreen.loginScreen);
            },
          ),
          SizedBox(
            height: 20,
          ),
          roundedButton(
            buttonColor: Colors.cyan,
            buttonText: 'Register',
            buttonDest: () {
              Navigator.pushNamed(context, Registration.registrationScreen);
            },
          )
        ],
      ),
    );
  }
}

class roundedButton extends StatelessWidget {
  roundedButton({this.buttonColor, this.buttonText, this.buttonDest});
  final Color? buttonColor;
  final String? buttonText;
  final buttonDest;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        elevation: MaterialStatePropertyAll(8.0),
        shadowColor: MaterialStatePropertyAll(Colors.black),
        backgroundColor: MaterialStatePropertyAll(buttonColor),
        fixedSize: MaterialStatePropertyAll(
          Size(300, 50),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      onPressed: buttonDest,
      child: Text(
        buttonText!,
        style: TextStyle(color: Colors.white, fontSize: 15.0, letterSpacing: 3),
      ),
    );
  }
}
