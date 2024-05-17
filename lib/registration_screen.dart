import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:personaltaskmanager/buttons.dart';
import 'package:personaltaskmanager/constants.dart';
import 'package:personaltaskmanager/provider_engine.dart';
import 'package:provider/provider.dart';
import 'style.dart';
import 'task_screen.dart';
import 'extracted_widgets.dart';

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
  @override
  void initState() {
    // TODO: implement initState
  }
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
                        child:
                            Text('Welcome...', style: kRegistrationPageTitle),
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
                          }),
                      MainTextField(
                          label: 'PASSWORD',
                          changeFunction: (value) {
                            password = value;
                          }),
                    ],
                  ),
                  MainButton(
                      buttonText: 'REGISTER',
                      buttonOnPress: () async {
                        if (await Provider.of<MainEngine>(context,
                                listen: false)
                            .userRegistration(email, password)) {
                          Navigator.pushNamed(context, TaskScreen.taskScreen);
                        } else {}
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
