import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signInEmailPassword(String userName,password) async {
    try{
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('admin').doc(userName).get();
      String email;
      try {
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
        email = userData['emailId'];
      }catch(e){
        throw Exception("User Not Found");
      }
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  Future<UserCredential?> signUpEmailPassword(
      String email, String password, String username, dynamic AdminModel, BuildContext context) async {

    DocumentSnapshot doc = await _firestore.collection('admin').doc(username).get();
    final bool exists = doc.exists;

    if (exists) {
      // ✅ Show alert dialog and prevent navigation
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: const Text("User Already Exists"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close dialog
              child: const Text("OK"),
            )
          ],
        ),
      );
      return null; // ✅ Prevents further execution
    }
    else {
      try {
        UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _firestore
            .collection('admin')
            .doc(username)
            .set(AdminModel.toMap());
        if (exists) {
          return null;
        } else {
          return userCredential;
        }
      } on FirebaseAuthException catch (e) {
        throw Exception(e.code);
      }
    }
  }

  Future<void> adminSignOut() async {
    return await _auth.signOut();
  }
}