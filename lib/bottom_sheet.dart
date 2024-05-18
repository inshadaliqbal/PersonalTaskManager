import 'package:flutter/material.dart';
import 'package:personaltaskmanager/buttons.dart';
import 'package:personaltaskmanager/provider_engine.dart';
import 'package:provider/provider.dart';
import 'extracted_widgets.dart';
import 'dart:math';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class BottomSheetWidget extends StatefulWidget {
  String title;
  String description;
  bool isReEdit;
  String docID;
  BottomSheetWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.isReEdit,
      required this.docID});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final _formKey = GlobalKey<FormState>();

  var _titleController = TextEditingController();

  var _descriptionController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.title;
    _descriptionController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    int? hourSelected;
    int? minuteSelected;
    String? zoneSelected;
    DateTime? datePicked;
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
            MainButton(buttonText: 'Date', buttonOnPress: ()async{
              datePicked = await DatePicker.showSimpleDatePicker(
                context,
                // initialDate: DateTime(2020),
                firstDate: DateTime(2020),
                lastDate: DateTime(2090),
                dateFormat: "dd-MMMM-yyyy",
                locale: DateTimePickerLocale.en_us,
                looping: true,
              );
              print(datePicked);
            }),
            MainButton(
              buttonText: 'Add Task',
              buttonOnPress: () {
                if (widget.isReEdit) {
                  Provider.of<MainEngine>(context, listen: false)
                      .reEditTask(widget.docID, {
                    "tasktitle": _titleController.text,
                    "taskdescription": _descriptionController.text,
                    "isdone": false,
                    "datetime": DateTime(
                        datePicked!.year,
                        datePicked!.month,
                        datePicked!.day,
                        hourSelected!,
                        minuteSelected!,
                        0,
                        0,
                        0)
                  });
                } else {
                  Provider.of<MainEngine>(context, listen: false).addTask({
                    "tasktitle": _titleController.text,
                    "taskdescription": _descriptionController.text,
                    "isdone": false,
                    "datetime": DateTime(
                        datePicked!.year,
                        datePicked!.month,
                        datePicked!.day,
                        hourSelected!,
                        minuteSelected!,
                        0,
                        0,
                        0),
                    "alarmid": Random().nextInt(1000)
                  });
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
