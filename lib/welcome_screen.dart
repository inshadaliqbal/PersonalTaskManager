import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'provider_engine.dart';
import 'package:provider/provider.dart';
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
    Provider.of<MainEngine>(context).fireBaseInitialize();
    return Scaffold(
      backgroundColor: animation.value,
      body: CustomPaint(
        // Adjust size as needed
        painter: DrawingBookPainter(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Personal Task Manager',
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w200,
                    color: Colors.black,
                    fontFamily: 'sketch'),
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
                  style: const TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Canterbury',
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ScaleAnimatedText('Personal'),
                      ScaleAnimatedText('Task Manager'),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
              ],
            ),
            roundedButton(
              buttonColor: Colors.blueAccent.shade200,
              buttonText: 'LOGIN',
              buttonDest: () {
                Navigator.pushNamed(context, LoginScreen.loginScreen);
              },
            ),
            roundedButton(
              buttonColor: Colors.cyan,
              buttonText: 'REGISTER',
              buttonDest: () {
                Navigator.pushNamed(context, Registration.registrationScreen);
              },
            )
          ],
        ),
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(10), // Adjust border radius as needed
        boxShadow: [
          BoxShadow(
            color: Colors.black, // Shadow color
            offset: Offset(5, 5), // No offset in X and Y direction
            blurRadius: 0, // Adjust blur radius as needed
            spreadRadius:
                0, // Negative spread radius to prevent spreading on the right and bottom sides
          ),
        ],
      ),
      child: TextButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(8.0),
          backgroundColor: MaterialStateProperty.all(
              Colors.lightBlueAccent.shade400), // Set background color to white
          shape: MaterialStateProperty.all(
            // Apply shape with border radius
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // Adjust border radius as needed
              side: BorderSide(
                  width: 1,
                  color: Colors.black), // Add border with width and color
            ),
          ),
          minimumSize: MaterialStateProperty.all(
            Size(300, 50),
          ), // Set button size
        ),
        onPressed: buttonDest,
        child: Text(
          buttonText!,
          style:
              TextStyle(color: Colors.white, fontSize: 15.0, letterSpacing: 3),
        ),
      ),
    );
  }
}

class DrawingBookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..strokeWidth = 1.0;

    final double step = 15.0; // Adjust the spacing between lines
    final double maxX = size.width;
    final double maxY = size.height;

    // Drawing vertical lines
    for (double i = 0; i <= maxX; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, maxY), paint);
    }

    // Drawing horizontal lines
    for (double i = 0; i <= maxY; i += step) {
      canvas.drawLine(Offset(0, i), Offset(maxX, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
