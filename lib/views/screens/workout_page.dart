import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_workout_app/controllers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_workout_app/controllers/database_controller.dart';
import 'package:the_workout_app/controllers/helper_functions.dart';
import 'package:the_workout_app/views/widgets/exercise_tile.dart';
import 'package:the_workout_app/views/widgets/sidebar.dart';
import 'package:the_workout_app/views/widgets/workout_tile.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;
  final String workoutId;

  const WorkoutPage({super.key, required this.workoutName, required this.workoutId});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final User? user = Auth().currentUser;
  bool _isLoading = false;
  String exerciseName = "";
  String exerciseId = "";
  Stream? exercises;
  Stream? exercisesStream;

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {

    await DatabaseService()
        .getWorkoutsExercises(widget.workoutId)
        .then((value) {
      setState(() {
        exercisesStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.workoutName,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.redAccent,
      ),
      body: exercisesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpCreateGroupDialog(context);
        },
        elevation: 0,
        backgroundColor: Colors.redAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }


  popUpCreateGroupDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  side: BorderSide(color: Colors.redAccent, width: 2)),
              title: const Text(
                "Create an excercise",
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.redAccent,
                          ),
                        )
                      : TextField(
                          onChanged: (val) {
                            setState(() {
                              exerciseName = val;
                            });
                          },
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "input exercise name"),
                        ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 2, color: Colors.redAccent),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      primary: Colors.white54),
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (exerciseName != "") {
                      setState(() {
                        _isLoading = true;
                      });
                      exerciseId = "";

                      await DatabaseService(
                              uid: FirebaseAuth.instance.currentUser!.uid)
                          .createExercise(
                              exerciseName, widget.workoutId)
                          .then((value) => exerciseId = value)
                          .whenComplete(() {
                        _isLoading = false;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 2, color: Colors.redAccent),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      primary: Colors.white54),
                  child: const Text(
                    "CREATE",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          });
        });
  }

  exercisesList() {
    return StreamBuilder(
        stream: exercisesStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return ExerciseTile(exerciseName: ds['exerciseName'], exerciseId: ds['exerciseId'], workoutId: widget.workoutId,);
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            );
          }
        });
  }
}
