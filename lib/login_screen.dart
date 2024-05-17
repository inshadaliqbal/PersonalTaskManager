import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:personaltaskmanager/buttons.dart';
import 'package:personaltaskmanager/constants.dart';
import 'package:personaltaskmanager/extracted_widgets.dart';
import 'style.dart';
import 'package:personaltaskmanager/provider_engine.dart';
import 'package:personaltaskmanager/task_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String loginScreen = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF2E1),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<MainEngine>(context).spinnerValue,
        child: SquareBGCustomPaint(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Welcome Back',
                          style: kLoginPageTitleTextStyle
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
                      MainTextField(label: 'EMAIL', changeFunction: (value){
                        email = value;
                        print(value);
                      }),
                      MainTextField(label: 'PASSWORD', changeFunction: (value){
                        password = value;
                      }),
                    ],
                  ),
                  MainButton(buttonText: 'LOG IN',buttonOnPress: () async {
                    if (await Provider.of<MainEngine>(context,
                        listen: false)
                        .userSignIN(email, password)) {
                      Navigator.pushNamed(
                          context, TaskScreen.taskScreen);
                    } else {}
                  },),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//
// onPressed: () async {
// if (await Provider.of<MainEngine>(context,
// listen: false)
//     .userSignIN(email, password)) {
// Navigator.pushNamed(
// context, TaskScreen.taskScreen);
// } else {}
// },