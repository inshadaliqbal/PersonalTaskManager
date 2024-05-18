import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personaltaskmanager/widgets/buttons.dart';
import 'package:personaltaskmanager/helpers/provider_engine.dart';
import 'package:personaltaskmanager/constants/style.dart';
import 'package:provider/provider.dart';
import 'extracted_widgets.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class BottomSheetWidget extends StatefulWidget {
  final String title;
  final String description;
  final bool isReEdit;
  final String docID;

  BottomSheetWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.isReEdit,
    required this.docID,
  });

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int? hourSelected;
  int? minuteSelected;
  String? zoneSelected;
  DateTime? datePicked;

  @override
  void initState() {
    _titleController.text = widget.title;
    _descriptionController.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF2E1),
      child: SquareBGCustomPaint(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 50,
              bottom: 8.0,
              left: 8.0,
              right: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextFormField(
                  controller: _titleController,
                  decoration: MainTextFieldInputDecoration('Enter Your Task Title'),
                  validator: (title) => title!.length < 5 ? 'Title Should Atleast 5 Characters' : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: MainTextFieldInputDecoration('Enter Your Task Description')
                      .copyWith(
                    contentPadding: EdgeInsets.all(5),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 7,
                  validator: (description) => description!.length < 10 ? 'Description Should Atleast 10 Characters' : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
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
                  buttonColor: Color(0xFF897A74),
                  buttonText: 'Date',
                  buttonOnPress: () async {
                    datePicked = await DatePicker.showSimpleDatePicker(
                      textColor: Colors.black,
                      backgroundColor: Color(0xFFF6E2BA),
                      context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2090),
                      dateFormat: "dd-MMMM-yyyy",
                      locale: DateTimePickerLocale.en_us,
                      looping: true,
                    );
                  },
                ),
                MainButton(
                  buttonColor: Colors.blueAccent.shade200,
                  buttonText: 'Add Task',
                  buttonOnPress: () {
                    _formKey.currentState!.validate();
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
                          0,
                        )
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
                          0,
                        ),
                        "alarmid": Random().nextInt(1000)
                      });
                    }
                    Navigator.pop(context);
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
