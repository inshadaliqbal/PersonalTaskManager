import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personaltaskmanager/provider_engine.dart';
import 'package:provider/provider.dart';

import 'buttons.dart';
import 'package:flutter/widgets.dart';
import 'bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'style.dart';

class TaskScreen extends StatelessWidget {
  static const taskScreen = 'TaskScreen';
  TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool? isDone = false;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: (context),
              builder: (context) => BottomSheetWidget());
        },
      ),
      backgroundColor: Color(0xFFFFF2E1),
      body: SquareBGCustomPaint(
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: Provider.of<MainEngine>(context).streamFirestoreSnapshot,
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  var data = snapshot.data!.docs;
                  print(snapshot.data!.docs[1].id);
                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return TaskContainer(isDone: isDone,taskTitle: data[index]["tasktitle"],taskDesc: data[index]["taskdescription"],dateTime: data[index]["datetime"],);
                    },
                  );
                }
                return Container();
              }),
        ),
      ),
    );
  }
}
//


class TaskContainer extends StatelessWidget {
  bool? isDone;
  String? taskTitle;
  Timestamp? dateTime;
  String? taskDesc;
  TaskContainer({required this.isDone,required this.dateTime,required this.taskTitle,required this.taskDesc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
                Text('$taskTitle'),
                TaskContainerButton(
                    isActiveValue: isDone!,
                    onChangedFunction: (value) {
                      isDone = value;
                    }),
              ],
            ),
            Text("Time Remaining:-"),
            Text("0 days"),
            Text("15 Hours"),
          ],
        ),
      ),
    );
  }
}
