import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/provider_engine.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

class ReminderPage extends StatelessWidget {
  static String reminderScreen = 'reminder_screen';
  final Function functionForClose;
  final String? title;
  final String? description;
  ReminderPage({Key? key, required this.functionForClose, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainEngine(),
      child: Scaffold(
        backgroundColor: const Color(0xFF779BA1),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 250, horizontal: 40),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title of the reminder
                  Text(
                    title!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w900),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF897A74),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            description!,
                            style: const TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [Colors.white, Color(0xFFF6E2BA)],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp,
                        ),
                      ),
                      // Swipe action cell for actions
                      child: SwipeActionCell(
                        backgroundColor: Colors.transparent,
                        key: const ObjectKey('list[index]'),
                        trailingActions: <SwipeAction>[
                          SwipeAction(
                            color: Colors.transparent,
                            performsFirstActionWithFullSwipe: true,
                            onTap: (CompletionHandler handler) async {
                              functionForClose;
                              Navigator.pop(context);
                            },
                          ),
                        ],
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_back_outlined,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                              const Text(
                                "Stop     ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                child: const Icon(
                                  Icons.alarm,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
