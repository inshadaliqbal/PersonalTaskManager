import 'package:flutter/material.dart';
import 'style.dart';
import 'imported_widgets.dart';
import 'package:flutter/cupertino.dart';

class MainTextField extends StatelessWidget {
  Function changeFunction;
  String? label;

  MainTextField({super.key, required this.label, required this.changeFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: kMainTextFieldBoxDecoration,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          changeFunction(value);
        },
        textAlign: TextAlign.right,
        decoration: MainTextFieldInputDecoration(label),
      ),
    );
  }
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
        Container(
          height: 60,
          width: 70,
          child: CupertinoPicker(
            itemExtent: 40,
            onSelectedItemChanged: (value) {
              zonePickFunction(value);
            },
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text('AM'),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text('PM'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
