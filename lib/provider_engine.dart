
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
import 'package:personaltaskmanager/reminder_page.dart';

class MainEngine extends ChangeNotifier {
  FirebaseAuth? _auth;
  FirebaseFirestore? _firestore;
  String? userEmail;
  bool spinnerValue = false;
  var streamFirestoreSnapshot;

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

  Future<dynamic> userRegistration(String? email, String? password) async {
    loadingSpinner(true);
    try {
      final newUser = await _auth!
          .createUserWithEmailAndPassword(email: email!, password: password!);
      _firestore!.collection('users').doc("$email").set({'emailid': email});
      userEmail = email;
      if (newUser != null) {
        loadingSpinner(false);
        return true;
      }
    } catch (e) {
      print(e);
      loadingSpinner(false);
      return false;
    }
  }

  Future<dynamic> userSignIN(String? email, String? password) async {
    loadingSpinner(true);
    try {
      await _auth!
          .signInWithEmailAndPassword(email: email!, password: password!);
      userEmail = email;
      loadingSpinner(false);
      updateSnapshot();

      return true;
    } catch (e) {
      print(e);
      loadingSpinner(false);
      return false;
    }
  }

  void loadingSpinner(bool currentState) {
    spinnerValue = currentState;
    notifyListeners();
  }

  void addTask(Map<String, dynamic> taskDetails) async {
    loadingSpinner(true);
    try {
      await _firestore!
          .collection("users")
          .doc(userEmail)
          .collection("tasks")
          .add(taskDetails);
      updateSnapshot();
      addAlarm();
    } catch (e) {
      print(e);
    }
    loadingSpinner(false);
  }

  void updateSnapshot() async {
    streamFirestoreSnapshot = _firestore!
        .collection('users')
        .doc("$userEmail")
        .collection("tasks")
        .snapshots();
    customNotifyListeners();
  }

  void deleteTask(String dataID) async {
    _firestore!
        .collection('users')
        .doc("$userEmail")
        .collection("tasks")
        .doc(dataID)
        .delete();
    customNotifyListeners();
  }

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
        loopAudio: true,
        vibrate: true,
        volume: 0.8,
        fadeDuration: 3.0,
        notificationTitle: 'This is the title',
        notificationBody: 'This is the body',
      );
      await Alarm.set(alarmSettings: alarmSettings);
      Alarm.ringStream.stream.listen(
        (_) {
          navigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (context) {
                return ReminderPage(
                  functionForClose: () {},
                  functionForSnooze: () {},
                );
              },
            ),
          );
        },
      );
    }
  }

  void customNotifyListeners() {
    notifyListeners();
    addAlarm();
  }
}
