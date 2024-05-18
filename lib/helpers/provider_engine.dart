import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:personaltaskmanager/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:alarm/alarm.dart';
import 'package:personaltaskmanager/pages/reminder_page.dart';

// Class responsible for managing the main functionalities of the app
class MainEngine extends ChangeNotifier {
  FirebaseAuth? _auth;
  FirebaseFirestore? _firestore;
  String? userEmail;
  bool spinnerValue = false;
  var streamFirestoreSnapshot;

  // Function to check network connectivity
  Future<dynamic> checkConnection() async {
    try {
      final ConnectivityResult connectivityResult =
      await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      showSnackBar(ContentType.help, 'Something Error', e.toString());
    }
  }

  // Function to initialize Firebase services
  void fireBaseInitialize() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAJ-xNtN1_kscOT4cQlk-3F45SRAki-rF0',
        appId: 'id',
        messagingSenderId: 'sendid',
        projectId: 'personal-task-manager-c526b',
        storageBucket: 'myapp-b9yt18.appspot.com',
      ),
    );
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
  }

  // Function for user registration
  Future<dynamic> userRegistration(String? email, String? password) async {
    loadingSpinner(true);
    if (await checkConnection()) {
      try {
        final newUser = await _auth!
            .createUserWithEmailAndPassword(email: email!, password: password!);
        _firestore!.collection('users').doc("$email").set({'emailid': email});
        userEmail = email;
        if (newUser != null) {
          showSnackBar(
              ContentType.success, 'Success', 'User Registered Successfully');
          loadingSpinner(false);
          return true;
        }
      } catch (e) {
        showSnackBar(ContentType.help, 'Something Error', e.toString());
      }
      loadingSpinner(false);
    } else {
      showSnackBar(ContentType.failure, 'Network Failure',
          'Please Check Your Mobile Network');
    }
  }

  // Function for user login
  Future<dynamic> userSignIN(String? email, String? password) async {
    loadingSpinner(true);

    if (await checkConnection()) {
      try {
        await _auth!
            .signInWithEmailAndPassword(email: email!, password: password!);
        userEmail = email;
        loadingSpinner(false);
        updateSnapshot();
        showSnackBar(ContentType.success, 'Success', 'Succesfully Logged In');
        return true;
      } catch (e) {
        showSnackBar(ContentType.help, 'Something Error', e.toString());
      }
      loadingSpinner(false);
    } else {
      showSnackBar(ContentType.failure, 'Network Failure',
          'Please Check Your Mobile Network');
    }
  }

  // Function to toggle the loading spinner
  void loadingSpinner(bool currentState) {
    spinnerValue = currentState;
    notifyListeners();
  }

  // Function to add a new task
  void addTask(Map<String, dynamic> taskDetails) async {
    loadingSpinner(true);
    if (await checkConnection()) {
      try {
        await _firestore!
            .collection("users")
            .doc(userEmail)
            .collection("tasks")
            .add(taskDetails);
        updateSnapshot();
        addAlarm();
        showSnackBar(
            ContentType.success, 'Success', 'Succesfully Added Your Task');
      } catch (e) {
        showSnackBar(ContentType.help, 'Something Error', e.toString());
      }
      loadingSpinner(false);
    } else {
      showSnackBar(ContentType.failure, 'Network Failure',
          'Please Check Your Mobile Network');
    }
    loadingSpinner(false);
  }

  // Function to update the Firestore snapshot
  void updateSnapshot() async {
    streamFirestoreSnapshot = _firestore!
        .collection('users')
        .doc("$userEmail")
        .collection("tasks")
        .snapshots();
    customNotifyListeners();
  }

  // Function to delete a task
  void deleteTask(String dataID) async {
    if (await checkConnection()) {
      try {
        _firestore!
            .collection('users')
            .doc("$userEmail")
            .collection("tasks")
            .doc(dataID)
            .delete();
        customNotifyListeners();
        showSnackBar(
            ContentType.success, 'Success', 'Succesfully Deleted Your Task');
      } catch (e) {
        showSnackBar(ContentType.help, 'Something Error', e.toString());
      }
      loadingSpinner(false);
    } else {
      showSnackBar(ContentType.failure, 'Network Failure',
          'Please Check Your Mobile Network');
    }
  }

  // Function to edit a task
  void reEditTask(String docID, Map<String, dynamic> taskDetails) async {
    loadingSpinner(true);
    if (await checkConnection()) {
      try {
        await _firestore!
            .collection("users")
            .doc(userEmail)
            .collection("tasks")
            .doc(docID)
            .update(taskDetails);
        updateSnapshot();
        showSnackBar(
            ContentType.success, 'Success', 'Succesfully Edited Your Task');
      } catch (e) {
        showSnackBar(ContentType.help, 'Something Error', e.toString());
      }
      loadingSpinner(false);
    } else {
      showSnackBar(ContentType.failure, 'Network Failure',
          'Please Check Your Mobile Network');
    }
  }

  void showSnackBar(
      ContentType contentType, String snackBarTitle, String snackBarMessage) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: snackBarTitle,
        message: snackBarMessage,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(navigatorKey.currentState!.context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void addAlarm() async {
    if (await checkConnection()) {
      try {
        var data = await _firestore!
            .collection('users')
            .doc("$userEmail")
            .collection("tasks")
            .get();
        for (var task in data.docs) {
          DateTime datetime = task["datetime"].toDate();
          final alarmSettings = await AlarmSettings(
              id: task["alarmid"],
              dateTime: DateTime(datetime.year, datetime.month, datetime.day,
                  datetime.hour, datetime.minute - 10, 0, 0, 0),
              assetAudioPath: 'assets/sound.wav',
              loopAudio: false,
              vibrate: true,
              volume: 0.8,
              fadeDuration: 3.0,
              notificationTitle: task["tasktitle"],
              notificationBody: task["taskdescription"],
              enableNotificationOnKill: true);
          await Alarm.set(alarmSettings: alarmSettings);
          Alarm.ringStream.stream.listen(
                (_) {
              navigatorKey.currentState!.push(
                MaterialPageRoute(
                  builder: (context) {
                    return ReminderPage(
                      title: 'Task Reminder',
                      description:
                      'Your task time will finish in another 10 minutes',
                      functionForClose: () {
                        Alarm.stopAll();
                      },
                    );
                  },
                ),
              );
            },
          );
        }

      } catch (e) {
        print(e);
      }
      loadingSpinner(false);
    } else {
      showSnackBar(ContentType.failure, 'Network Failure',
          'Please Check Your Mobile Network');
    }
  }

  void customNotifyListeners() {
    notifyListeners();
    addAlarm();
  }

  void completeTask(String? docID,bool? isdone)async{

    _firestore!
        .collection("users")
        .doc(userEmail)
        .collection("tasks")
        .doc(docID)
        .update({"isdone": !isdone!});
    updateSnapshot();
    customNotifyListeners();
  }
}

