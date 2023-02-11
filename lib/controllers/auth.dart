import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:the_workout_app/models/user.dart' as user_model;
import 'package:the_workout_app/views/screens/home_page.dart';
import 'package:the_workout_app/views/screens/start_page.dart';
import 'package:flutter/material.dart';

class Auth extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static Auth instance = Get.put(Auth());

  late Rx<User?> _user;
  late Rx<File?> _pickImage;

  User get user => _user.value!;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<void> onReady() async {
    super.onReady();
    updateData();
    ever(_user, _setInitialScreen);
  }

  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> loginUser(String email, String password, BuildContext context) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password);
        updateData();
        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Get.snackbar('Error logging in', 'Enter all the fields');
      }
    } catch (e) {
      Get.snackbar('Error logging in', e.toString());
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
    required BuildContext context
  }) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential credential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        user_model.User user = user_model.User(
          name: username,
          email: email,
          uid: credential.user!.uid,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson());
        updateData();
        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Get.snackbar('Error Creating Account', 'Please enter all the files');
      }
    } catch (e) {
      Get.snackbar('Error Creating Account', e.toString());
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> updateData() async {
    _user = Rx<User?>(_firebaseAuth.currentUser);
    _user.bindStream(_firebaseAuth.authStateChanges());
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => StartPage());
    } else {
      Get.offAll(() => HomePage());
    }
  }
}
