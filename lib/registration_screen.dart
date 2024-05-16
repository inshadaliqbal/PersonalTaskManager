import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personaltaskmanager/task_screen.dart';

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
  @override
  void initState() {
    // TODO: implement initState
  }
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
                Hero(
                  tag: 'logo',
                  child: Icon(
                    Icons.electric_bolt,
                    size: 100,
                    color: Colors.orangeAccent,
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
                          obscureText: true,
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
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email!, password: password!);
                      if (newUser != null) {
                        print("Done");
                        Navigator.pushNamed(context, TaskScreen.taskScreen);
                      }

                      setState(() {
                        setSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text(
                    'Register',
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
