import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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

  Future<Stream> getExercisesResults(
      String workoutId, String exerciseId) async {
    return FirebaseFirestore.instance
        .collection("workouts")
        .doc(workoutId)
        .collection('exercises')
        .doc(exerciseId)
        .collection('results')
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

  Future<String> createExercise(String exerciseName, String workoutId) async {
    DocumentReference workoutDocumentReference =
        await workoutCollection.doc(workoutId).collection('exercises').add({
      "exerciseName": exerciseName,
      "exerciseId": "",
    });
    await workoutDocumentReference.update({
      "exerciseId": workoutDocumentReference.id,
    });

    return workoutDocumentReference.collection('exercises').id;
  }

  Future<String> createExerciseResult(
      String exerciseName,
      String workoutId,
      String exerciseId,
      String? v1,
      String? v2,
      String? v3,
      String? v4,
      String? v5,
      String date) async {
    DocumentReference resultDocumentReference = await workoutCollection
        .doc(workoutId)
        .collection('exercises')
        .doc(exerciseId)
        .collection('results')
        .add({
      "date": date,
      "t1": '-',
      "t2": '-',
      "t3": '-',
      "t4": '-',
      "t5": '-',
      "resultId": "",
    });
    await resultDocumentReference.update({
      "resultId": resultDocumentReference.id,
    });
    if (v1 != null) {
      await resultDocumentReference.update({
        "t1": v1,
      });
    }
    if (v2 != null) {
      await resultDocumentReference.update({
        "t2": v2,
      });
    }
    if (v3 != null) {
      await resultDocumentReference.update({
        "t3": v3,
      });
    }
    if (v4 != null) {
      await resultDocumentReference.update({
        "t4": v4,
      });
    }
    if (v5 != null) {
      await resultDocumentReference.update({
        "t5": v5,
      });
    }

    return resultDocumentReference.collection('results').id;
  }

  Future<void> deleteWorkout(String workoutId, String workoutName) async {
    return workoutCollection.doc(workoutId).delete();
  }

  Future<void> deleteExercise(String workoutId, String exerciseId) async {
    return workoutCollection
        .doc(workoutId)
        .collection('exercises')
        .doc(exerciseId)
        .delete();
  }
  Future<void> deleteResult(String workoutId, String exerciseId, String resultId) async {
    return workoutCollection
        .doc(workoutId)
        .collection('exercises')
        .doc(exerciseId)
        .collection('results')
        .doc(resultId)
        .delete();
  }

  Future<void> renameWorkout(
      String workoutId, String workoutName, String newWorkoutName) async {
    return workoutCollection.doc(workoutId).update({
      "workoutName": newWorkoutName,
    });
  }
}
