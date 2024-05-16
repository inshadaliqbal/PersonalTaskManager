import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personaltaskmanager/task_screen.dart';

final _auth = FirebaseAuth.instance;


class LoginScreen extends StatefulWidget {
  static String loginScreen = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  bool? setSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text('Registration'),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: setSpinner!,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Hero(
                    tag: 'logo',
                    child: Icon(
                      Icons.electric_bolt,
                      size: 100,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            email = value;
                          },
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              icon: Icon(
                                Icons.person,
                                size: 30,
                              ),
                              iconColor: Colors.black12,
                              labelText: 'USERNAME',
                              labelStyle: TextStyle(letterSpacing: 3),
                              filled: true,
                              fillColor: Colors.cyan),
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            password = value;
                          },
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              icon: Icon(
                                Icons.person,
                                size: 30,
                              ),
                              iconColor: Colors.black12,
                              labelText: 'PASSWORD',
                              labelStyle: TextStyle(letterSpacing: 3),
                              filled: true,
                              fillColor: Colors.cyan),
                        ),
                      )
                    ],
                  ),
                ),
                TextField(),
                TextButton(
                  style: ButtonStyle(
                    elevation: MaterialStatePropertyAll(8.0),
                    shadowColor: MaterialStatePropertyAll(Colors.black),
                    backgroundColor:
                    MaterialStatePropertyAll(Colors.blueAccent.shade200),
                    fixedSize: MaterialStatePropertyAll(
                      Size(300, 50),
                    ),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      setSpinner = true;
                    });
                    try {
                      await _auth.signInWithEmailAndPassword(
                          email: email!, password: password!);
                      Navigator.pushNamed(context, TaskScreen.taskScreen);
                      setState(() {
                        setSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text(
                    'LOG IN',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

