import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:personaltaskmanager/widgets/buttons.dart';
import 'package:personaltaskmanager/constants/constants.dart';
import 'package:personaltaskmanager/widgets/extracted_widgets.dart';
import '../constants/style.dart';
import 'package:personaltaskmanager/helpers/provider_engine.dart';
import 'package:personaltaskmanager/pages/task_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String loginScreen = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

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
        // Display spinner if there's an ongoing operation
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
                        child: Text('Welcome Back',
                            style: kLoginPageTitleTextStyle),
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
                      MainTextField(
                          label: 'EMAIL',
                          changeFunction: (value) {
                            email = value;
                            print(value);
                          }),
                      MainTextFieldPassword(
                          label: 'PASSWORD',
                          changeFunction: (value) {
                            password = value;
                          }),
                    ],
                  ),
                  // Button for logging in
                  MainButton(
                    buttonColor: Colors.blueAccent.shade200,
                    buttonText: 'LOG IN',
                    buttonOnPress: () async {
                      if (await Provider.of<MainEngine>(context, listen: false)
                          .userSignIN(email, password)) {
                        Navigator.pushNamed(context, TaskScreen.taskScreen);
                      } else {}
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
