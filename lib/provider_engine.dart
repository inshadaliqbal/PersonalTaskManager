import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class MainEngine extends ChangeNotifier {

  FirebaseAuth? _auth;
  FirebaseFirestore? _firestore;
  String? userEmail;
  bool spinnerValue = false;

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
      final newUser = await _auth!.createUserWithEmailAndPassword(
          email: email!, password: password!);
      _firestore!
          .collection('users')
          .doc("$email")
          .set({'emailid': email});
      userEmail = email;
      if (newUser != null){
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
    try{
      await _auth!.signInWithEmailAndPassword(email: email!, password: password!);
      userEmail = email;
      loadingSpinner(false);
      return true;

    }catch(e){
      print(e);
      loadingSpinner(false);
      return false;
    }
  }


  void loadingSpinner(bool currentState){
    spinnerValue = currentState;
    notifyListeners();
  }


  void addTask(Map<String, dynamic> taskDetails) async {

    loadingSpinner(true);
    try{
      await _firestore!
          .collection("users")
          .doc(userEmail)
          .collection("tasks")
          .add(taskDetails);
    }catch(e){
      print(e);
    }
    loadingSpinner(false);
    final tasks = await _firestore!
        .collection('users')
        .doc("edmhack3r@gmail.com")
        .collection("tasks")
        .snapshots();

    await for (var snapshot in tasks) {
      for (var task in snapshot.docs) {
        print(task["tasktitle"]);
      }
    }
  }

}
