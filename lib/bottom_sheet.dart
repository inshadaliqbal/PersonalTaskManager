import 'package:flutter/material.dart';
import 'package:personaltaskmanager/buttons.dart';
import 'package:personaltaskmanager/provider_engine.dart';
import 'package:provider/provider.dart';
import 'extracted_widgets.dart';

class BottomSheetWidget extends StatefulWidget {
  BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();

  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int? hourSelected;
    int? minuteSelected;
    String? zoneSelected;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Enter Task Title'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Task Description'),
            ),
            SizedBox(height: 20.0),
            SizedBox(height: 20.0),
            DialWidgetAlarmSet(
              hourSetFunction: (value) {
                hourSelected = value;
              },
              minuteSetFunction: (value) {
                minuteSelected = value;
              },
              zonePickFunction: (value) {
                List<String> zoneListSelect = ['AM', 'PM'];
                zoneSelected = zoneListSelect[value];
              },
            ),
            MainButton(
              buttonText: 'Add Task',
              buttonOnPress: () {
                Provider.of<MainEngine>(context, listen: false).addTask({
                  "tasktitle": _titleController.text,
                  "taskdescription": _descriptionController.text,
                  "isdone": false,
                  "datetime": DateTime(
                      DateTime.now().year,
                      DateTime.august,
                      DateTime.saturday,
                      hourSelected!,
                      minuteSelected!,
                      0,
                      0,
                      0)
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
