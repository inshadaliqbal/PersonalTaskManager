import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:personaltaskmanager/provider_engine.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'imported_widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class TaskScreen extends StatefulWidget {
  static const taskScreen = 'TaskScreen';
  TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _auth = FirebaseAuth.instance;

  User? loggedInUser;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(user.email);
      }
    } catch (e) {
      print(e);
    }
  }

  final _titleController = TextEditingController();

  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int? hourSelected;
    int? minuteSelected;
    String? zoneSelected;
    bool? isDone = false;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: (context),
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: _titleController,
                          decoration:
                              InputDecoration(labelText: 'Enter Task Title'),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _descriptionController,
                          decoration:
                              InputDecoration(labelText: 'Task Description'),
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(height: 20.0),
                        DialWidgetAlarmSet(
                          hourSetFunction: (value) {
                            setState(() {
                              hourSelected = value;
                            });
                          },
                          minuteSetFunction: (value) {
                            setState(() {
                              minuteSelected = value;
                            });
                          },
                          zonePickFunction: (value) {
                            List<String> zoneListSelect = ['AM', 'PM'];
                            zoneSelected = zoneListSelect[value];
                          },
                        ),
                        TextButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(8.0),
                            backgroundColor: MaterialStateProperty.all(Colors
                                .lightBlueAccent
                                .shade400), // Set background color to white
                            shape: MaterialStateProperty.all(
                              // Apply shape with border radius
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust border radius as needed
                                side: BorderSide(
                                    width: 1,
                                    color: Colors
                                        .black), // Add border with width and color
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(
                                Size(300, 50)), // Set button size
                          ),
                          onPressed: () {
                            Provider.of<MainEngine>(context, listen: false)
                                .addTask({
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
                          child: Text("child"),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
      backgroundColor: Color(0xFFFFF2E1),
      body: CustomPaint(
        painter: DrawingBookPainter(),
        child: SafeArea(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 10, // Space between columns
              mainAxisSpacing: 10, // Space between rows
            ),
            itemCount: 10, // Number of items in the grid
            itemBuilder: (context, index) {
              return TaskContainer(isDone: isDone,);
            },
          ),
        ),
      ),
    );
  }
}

class TaskContainer extends StatelessWidget {
  bool? isDone;
  TaskContainer({required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 150,
        minHeight: 150,
      ),
      decoration: BoxDecoration(
        color: Colors.greenAccent.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(3, 3),
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Task Title'),
              AlarmCardMainButton(isActiveValue: isDone!, onChangedFunction: (value){
                isDone = value;
              }),
            ],
          ),
          Text("Time Remaining:-"),
          Text("0 days"),
          Text("15 Hours"),
        ],
      ),
    );
  }
}

class DatePickerWidget extends StatefulWidget {
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              _selectedDate == null
                  ? 'No date selected'
                  : 'Selected Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select date'),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawingBookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..strokeWidth = 1.0;

    final double step = 15.0; // Adjust the spacing between lines
    final double maxX = size.width;
    final double maxY = size.height;

    // Drawing vertical lines
    for (double i = 0; i <= maxX; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, maxY), paint);
    }

    // Drawing horizontal lines
    for (double i = 0; i <= maxY; i += step) {
      canvas.drawLine(Offset(0, i), Offset(maxX, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
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


class AlarmCardMainButton extends StatelessWidget {
  const AlarmCardMainButton({
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