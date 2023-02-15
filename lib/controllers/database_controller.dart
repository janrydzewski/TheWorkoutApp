import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference workoutCollection =
      FirebaseFirestore.instance.collection('workouts');

  Future gettingUserData(String uid) async {
    QuerySnapshot snapshot =
        await userCollection.where('uid', isEqualTo: uid).get();
    return snapshot;
  }

  getUserWorkouts() async {
    return userCollection.doc(uid).snapshots();
  }

  Future<Stream> getWorkouts(String uid) async {
    return FirebaseFirestore.instance
        .collection("workouts")
        .where("users", arrayContains: "$uid")
        .snapshots();
  }

  Future<Stream> getWorkoutsExercises(String id) async {
    return FirebaseFirestore.instance
        .collection("workouts")
        .doc(id)
        .collection('exercises')
        .snapshots();
  }

  Future<String> createWorkout(
      String userName, String id, String workoutName) async {
    DocumentReference workoutDocumentReference = await workoutCollection.add({
      "workoutName": workoutName,
      "users": [],
      "workoutId": "",
    });
    await workoutDocumentReference.update({
      "users": FieldValue.arrayUnion(["${uid}"]),
      "workoutId": workoutDocumentReference.id,
    });


    return workoutDocumentReference.id;
  }

  Future<String> createExercise(
      String exerciseName, String workoutId) async {
    DocumentReference workoutDocumentReference = await workoutCollection.doc(workoutId).collection('exercises').add({
      "exerciseName": exerciseName,
      "exerciseId": "",
    });
    await workoutDocumentReference.update({
      "exerciseId": workoutDocumentReference.id,
    });


    return workoutDocumentReference.collection('exercises').id;
  }

  Future<void> deleteWorkout(String workoutId, String workoutName) async {
    return workoutCollection.doc(workoutId).delete();
  }

  Future<void> deleteExercise(String workoutId, String exerciseId) async {
    return workoutCollection.doc(workoutId).collection('exercises').doc(exerciseId).delete();
  }

  Future<void> renameWorkout(String workoutId, String workoutName, String newWorkoutName) async {

    return workoutCollection.doc(workoutId).update({
      "workoutName": newWorkoutName,
    });
  }



}
