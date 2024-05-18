import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personaltaskmanager/widgets/buttons.dart';
import 'package:personaltaskmanager/helpers/provider_engine.dart';
import 'package:provider/provider.dart';
import '../widgets/extracted_widgets.dart';
import 'package:flutter/widgets.dart';
import '../widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../constants/style.dart';

class TaskScreen extends StatelessWidget {
  static const taskScreen = 'TaskScreen';
  TaskScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    bool? isDone = false;
    return Scaffold(
      backgroundColor: Color(0xFFFFF2E1),
      body: SquareBGCustomPaint(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 300,
                    ),
                    // Stream builder to listen for changes in Firestore data
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Provider.of<MainEngine>(context)
                          .streamFirestoreSnapshot,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!.docs;
                          // GridView to display tasks
                          return GridView.builder(
                            padding: const EdgeInsets.all(10),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              print(data[index].id);
                              // TaskContainer widget to display individual task
                              return TaskContainer(
                                isDone: data[index]["isdone"],
                                taskTitle: data[index]["tasktitle"],
                                taskDesc: data[index]["taskdescription"],
                                dateTime: data[index]["datetime"],
                                dataID: data[index].id,
                              );
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
                MainButton(
                  buttonColor: Colors.blueAccent.shade200,
                  buttonText: "Add Task",
                  buttonOnPress: () {
                    // Show bottom sheet for adding new task
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: (context),
                      builder: (context) => BottomSheetWidget(
                        title: '',
                        description: '',
                        isReEdit: false,
                        docID: '',
                      ),
                    );
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
//
