import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants/style.dart';
import 'imported_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../helpers/provider_engine.dart';
import 'package:provider/provider.dart';
import 'bottom_sheet.dart';
import 'buttons.dart';
import '../helpers/functions.dart';

class MainTextField extends StatelessWidget {
  Function changeFunction;
  String? label;
  final _formKey = GlobalKey<FormState>();

  MainTextField({super.key, required this.label, required this.changeFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: kMainTextFieldBoxDecoration,
      child: Form(
        key: _formKey,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            changeFunction(value);
          },
          textAlign: TextAlign.right,
          decoration: MainTextFieldInputDecoration(label),
          validator: _validateEmail,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }
}

String? _validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email address.';
  }
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address.';
  }
  return null;
}

class MainTextFieldPassword extends StatelessWidget {
  Function changeFunction;
  String? label;
  final _formKey = GlobalKey<FormState>();

  MainTextFieldPassword(
      {super.key, required this.label, required this.changeFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: kMainTextFieldBoxDecoration,
      child: Form(
        key: _formKey,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            changeFunction(value);
          },
          textAlign: TextAlign.right,
          decoration: MainTextFieldInputDecoration(label),
          validator: _validatePassword,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: true,
        ),
      ),
    );
  }
}

String? _validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password.';
  }
  if (value.length < 7) {
    return 'Password should contain min 6 characters';
  }
  return null;
}

class DialWidgetAlarmSet extends StatelessWidget {
  DialWidgetAlarmSet({
    super.key,
    required this.minuteSetFunction,
    required this.hourSetFunction,
    required this.zonePickFunction,
  });

  Function minuteSetFunction;
  Function hourSetFunction;
  Function zonePickFunction;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Center(
          child: RotatableDial1(
            minuteSetFunction,
          ),
        ),
        Center(
          child: RotatableDial(hourSetFunction),
        ),
      ],
    );
  }
}

class TaskContainer extends StatelessWidget {
  bool? isDone;
  String? taskTitle;
  Timestamp? dateTime;
  String? taskDesc;
  String? dataID;
  TaskContainer(
      {super.key,
      required this.isDone,
      required this.dateTime,
      required this.taskTitle,
      required this.taskDesc,
      required this.dataID});

  @override
  Widget build(BuildContext context) {
    Map<String, int> differenceInDateTime = calculateTimeDifference(DateTime(
        dateTime!.toDate().year,
        dateTime!.toDate().month,
        dateTime!.toDate().day,
        dateTime!.toDate().hour,
        dateTime!.toDate().minute,
        0,
        0,
        0));
    return GestureDetector(
      onLongPress: () {
        Provider.of<MainEngine>(context, listen: false).deleteTask(dataID!);
      },
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: (context),
            builder: (context) => BottomSheetWidget(
                  title: taskTitle!,
                  description: taskDesc!,
                  docID: dataID!,
                  isReEdit: true,
                ));
      },
      child: Container(
        constraints: BoxConstraints(
          minWidth: 150,
          minHeight: 150,
        ),
        decoration: kTaskContainerBoxDecoration,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '$taskTitle',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                TaskContainerButton(
                    isActiveValue: isDone,
                    onChangedFunction: () {
                      Provider.of<MainEngine>(context,listen: false).completeTask(dataID, isDone);
                    }),
              ],
            ),
            Text("Time Remaining:-"),
            Text("${differenceInDateTime["days"]} Days"),
            Text("${differenceInDateTime["hours"]} Hours"),
            Text("${differenceInDateTime["minutes"]} Minutes"),
          ],
        ),
      ),
    );
  }
}
