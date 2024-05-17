import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class MainEngine extends ChangeNotifier {

  FirebaseAuth? _auth;
  FirebaseFirestore? _firestore;
  String? userEmail;
  bool spinnerValue = false;
  var streamFirestoreSnapshot;

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
      updateSnapshot();

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
      updateSnapshot();
    }catch(e){
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
    notifyListeners();
  }

  void deleteTask(int index)async{
    var data = _firestore!
        .collection('users')
        .doc("$userEmail")
        .collection("tasks").doc();

    // data.
  }

}


