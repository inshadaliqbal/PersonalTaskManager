import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:personaltaskmanager/widgets/buttons.dart';
import 'package:personaltaskmanager/constants/constants.dart';
import 'package:personaltaskmanager/helpers/provider_engine.dart';
import 'package:provider/provider.dart';
import '../constants/style.dart';
import 'task_screen.dart';
import '../widgets/extracted_widgets.dart';

class Registration extends StatefulWidget {
  static String registrationScreen = 'registration_screen';
  const Registration({Key? key});

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF2E1),
      body: ModalProgressHUD(
        // Displaying a modal progress indicator based on a boolean value
        inAsyncCall: Provider.of<MainEngine>(context).spinnerValue,
        child: SquareBGCustomPaint(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title and logo
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('Welcome...', style: kRegistrationPageTitle),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Hero(
                        tag: 'logo ',
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
                      },
                    ),
                    MainTextFieldPassword(
                      label: 'PASSWORD',
                      changeFunction: (value) {
                        password = value;
                      },
                    ),
                  ],
                ),
                MainButton(
                  buttonColor: Colors.blueAccent.shade200,
                  buttonText: 'REGISTER',
                  buttonOnPress: () async {
                    // Performing user registration and navigating to task screen if successful
                    if (await Provider.of<MainEngine>(context, listen: false)
                        .userRegistration(email, password)) {
                      Navigator.pushNamed(context, TaskScreen.taskScreen);
                    } else {}
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
