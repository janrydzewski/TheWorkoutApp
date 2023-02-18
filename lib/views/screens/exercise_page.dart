import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_workout_app/controllers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_workout_app/controllers/database_controller.dart';
import 'package:the_workout_app/controllers/helper_functions.dart';
import 'package:the_workout_app/views/widgets/exercise_tile.dart';
import 'package:the_workout_app/views/widgets/sidebar.dart';
import 'package:the_workout_app/views/widgets/workout_tile.dart';

class ExercisePage extends StatefulWidget {
  final String exerciseName;
  final String exerciseId;

  const ExercisePage(
      {super.key, required this.exerciseName, required this.exerciseId});

  @override
  State<ExercisePage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<ExercisePage> {
  TextEditingController dateInput = TextEditingController();
  final User? user = Auth().currentUser;
  bool _isLoading = false;
  String exerciseName = "";
  String exerciseId = "";
  Stream? exercises;
  Stream? exercisesStream;

  @override
  void initState() {
    super.initState();
    dateInput.text = "";
    //gettingUserData();
  }
  /*
  gettingUserData() async {

    await DatabaseService()
        .getWorkoutsExercises(widget.workoutId)
        .then((value) {
      setState(() {
        exercisesStream = value;
      });
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.exerciseName,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.width / 3,
          child: Center(
              child: TextField(
            controller: dateInput,
            
            decoration: InputDecoration(
                icon: Icon(Icons.calendar_today), //icon of text field
                labelText: "Enter Date" //label text of field
                ),
            readOnly: true,
            //set it true, so that user will not able to edit text
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2100));

              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                setState(() {
                  dateInput.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {}
            },
          ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
  /*
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
                    return ExerciseTile(
                      exerciseName: ds['exerciseName'],
                      exerciseId: ds['exerciseId'],
                      workoutId: widget.workoutId,
                    );
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
  */
}
