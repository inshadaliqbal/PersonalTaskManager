import 'package:flutter/material.dart';
import 'package:personaltaskmanager/constants.dart';
import 'style.dart';
import 'package:flutter/cupertino.dart';


class MainButton extends StatelessWidget {
  MainButton({super.key, this.buttonColor,required this.buttonText, required this.buttonOnPress});
  final Color? buttonColor;
  final String? buttonText;
  Function buttonOnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: kMainButtonContainerDecoration,
      child: TextButton(
        style: kMainButtonStyle,
        onPressed: () {
          buttonOnPress();
        },
        child: Text(
          buttonText!,
          style:
          kMainButtonTextStyle,
        ),
      ),
    );
  }
}


class TaskContainerButton extends StatelessWidget {
  const TaskContainerButton({
    super.key,
    required this.isActiveValue,
    required this.onChangedFunction,
  });

  final bool isActiveValue;
  final Function onChangedFunction;

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
        trackColor: Colors.white38,
        thumbColor: Colors.blueGrey,
        activeColor: Colors.white,
        value: isActiveValue,
        onChanged: (bool newValue) {
          onChangedFunction();
        });
  }
}