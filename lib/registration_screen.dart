import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personaltaskmanager/provider_engine.dart';
import 'package:personaltaskmanager/task_screen.dart';
import 'package:provider/provider.dart';

class Registration extends StatefulWidget {
  static String registrationScreen = 'registration_screen';
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String? email;
  String? password;
  bool? setSpinner = false;
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF2E1),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<MainEngine>(context).spinnerValue,
        child: CustomPaint(
          // Adjust size as needed
          painter: DrawingBookPainter(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Welcome...',
                              style: TextStyle(
                                fontFamily: 'germenia',
                                color: Colors.black,
                                fontSize: 40,
                                // fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Hero(
                              tag: 'logo',
                              child: Icon(
                                Icons.task_sharp,
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust border radius as needed
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black, // Shadow color
                                  offset: Offset(
                                      5, 5), // No offset in X and Y direction
                                  blurRadius: 0, // Adjust blur radius as needed
                                  spreadRadius:
                                      0, // Negative spread radius to prevent spreading on the right and bottom sides
                                ),
                              ],
                            ),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                email = value;
                              },
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                labelText: 'EMAIL',
                                labelStyle: TextStyle(letterSpacing: 3),
                                filled: true,
                                fillColor: Colors
                                    .white, // Set background color to white
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors
                                          .black), // Set border width and color
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust border radius as needed
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors
                                          .black), // Set border width and color
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust border radius as needed
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors
                                          .black), // Set border width and color
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust border radius as needed
                                ),
                                // Adjust content padding as needed
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust border radius as needed
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black, // Shadow color
                                  offset: Offset(
                                      5, 5), // No offset in X and Y direction
                                  blurRadius: 0, // Adjust blur radius as needed
                                  spreadRadius:
                                      0, // Negative spread radius to prevent spreading on the right and bottom sides
                                ),
                              ],
                            ),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                password = value;
                              },
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                labelText: 'PASSWORD',
                                labelStyle: TextStyle(letterSpacing: 3),
                                filled: true,
                                fillColor: Colors
                                    .white, // Set background color to white
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors
                                          .black), // Set border width and color
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust border radius as needed
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors
                                          .black), // Set border width and color
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust border radius as needed
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors
                                          .black), // Set border width and color
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust border radius as needed
                                ),
                                // Adjust content padding as needed
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust border radius as needed
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black, // Shadow color
                              offset: Offset(
                                  5, 5), // No offset in X and Y direction
                              blurRadius: 0, // Adjust blur radius as needed
                              spreadRadius:
                                  0, // Negative spread radius to prevent spreading on the right and bottom sides
                            ),
                          ],
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(8.0),
                            backgroundColor: MaterialStateProperty.all(Colors
                                .lightBlueAccent
                                .shade400), // Set background color to white
                            shape: MaterialStateProperty.all(
                              // Apply shape with border radius
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust border radius as needed
                                side: BorderSide(
                                    width: 1,
                                    color: Colors
                                        .black), // Add border with width and color
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(
                                Size(300, 50)), // Set button size
                          ),
                          onPressed: () async {
                            if (await Provider.of<MainEngine>(context,listen: false).userRegistration(email, password)){
                              Navigator.pushNamed(context, TaskScreen.taskScreen);

                            }else{
                            }
                          },
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                                color: Colors.white), // Set text color to black
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
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
