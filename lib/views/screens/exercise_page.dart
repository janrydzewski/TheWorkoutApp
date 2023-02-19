import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_workout_app/controllers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_workout_app/controllers/database_controller.dart';
import 'package:the_workout_app/controllers/helper_functions.dart';
import 'package:the_workout_app/views/widgets/exercise_tile.dart';
import 'package:the_workout_app/views/widgets/result_tile.dart';
import 'package:the_workout_app/views/widgets/sidebar.dart';
import 'package:the_workout_app/views/widgets/workout_tile.dart';

class ExercisePage extends StatefulWidget {
  final String exerciseName;
  final String exerciseId;
  final String workoutId;

  const ExercisePage(
      {super.key,
      required this.exerciseName,
      required this.exerciseId,
      required this.workoutId});

  @override
  State<ExercisePage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<ExercisePage> {
  TextEditingController dateInput = TextEditingController();
  final User? user = Auth().currentUser;
  bool _isLoading = false;
  String? date,
      t1 = '-',
      t2 = '-',
      t3 = '-',
      t4 = '-',
      t5 = '-',
      w1 = '-',
      w2 = '-',
      w3 = '-',
      w4 = '-',
      w5 = '-';
  Stream? resultStream;

  @override
  void initState() {
    super.initState();
    dateInput.text = "";
    gettingUserData();
  }

  gettingUserData() async {
    await DatabaseService()
        .getExercisesResults(widget.workoutId, widget.exerciseId)
        .then((value) {
      setState(() {
        resultStream = value;
      });
    });
  }

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
      body: resultList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpCreateResultDialog(context);
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

  resultList() {
    return StreamBuilder(
        stream: resultStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return ResultTile(
                      date: ds['date'],
                      t1: ds['t1'],
                      t2: ds['t2'],
                      t3: ds['t3'],
                      t4: ds['t4'],
                      t5: ds['t5'],
                      resultId: ds['resultId'],
                      exerciseId: widget.exerciseId,
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

  popUpCreateResultDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                "Create a result",
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
                      : Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (val) {
                                  setState(() {
                                    w1 = val;
                                  });
                                },
                                decoration: InputDecoration(hintText: 'weight'),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextField(
                                onChanged: (val) {
                                  setState(() {
                                    t1 = val;
                                  });
                                },
                                decoration: InputDecoration(hintText: 'reps'),
                              ),
                            ),
                          ],
                        ),
                  _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.redAccent,
                          ),
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (val) {
                                  setState(() {
                                    w2 = val;
                                  });
                                },
                                decoration: InputDecoration(hintText: 'weight'),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextField(
                                onChanged: (val) {
                                  setState(() {
                                    t2 = val;
                                  });
                                },
                                decoration: InputDecoration(hintText: 'reps'),
                              ),
                            ),
                          ],
                        ),
                  _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.redAccent,
                          ),
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (val) {
                                  setState(() {
                                    w3 = val;
                                  });
                                },
                                decoration: InputDecoration(hintText: 'weight'),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextField(
                                onChanged: (val) {
                                  setState(() {
                                    t3 = val;
                                  });
                                },
                                decoration: InputDecoration(hintText: 'reps'),
                              ),
                            ),
                          ],
                        ),
                  _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.redAccent,
                          ),
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (val) {
                                  setState(() {
                                    w4 = val;
                                  });
                                },
                                decoration: InputDecoration(hintText: 'weight'),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextField(
                                onChanged: (val) {
                                  setState(() {
                                    t4 = val;
                                  });
                                },
                                decoration: InputDecoration(hintText: 'reps'),
                              ),
                            ),
                          ],
                        ),
                  _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.redAccent,
                          ),
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (val) {
                                  setState(() {
                                    w5 = val;
                                  });
                                },
                                decoration: InputDecoration(hintText: 'weight'),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextField(
                                onChanged: (val) {
                                  setState(() {
                                    t5 = val;
                                  });
                                },
                                decoration: InputDecoration(hintText: 'reps'),
                              ),
                            ),
                          ],
                        ),
                  Container(
                      padding: EdgeInsets.all(15),
                      height: MediaQuery.of(context).size.width / 3,
                      child: Center(
                          child: TextField(
                        controller: dateInput,
                        decoration: InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            labelText: "Enter Date"),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);

                            setState(() {
                              dateInput.text = formattedDate;
                              date = dateInput.text;
                            });
                          } else {}
                        },
                      ))),
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
                    setState(() {
                      _isLoading = true;
                    });

                    await DatabaseService(
                            uid: FirebaseAuth.instance.currentUser!.uid)
                        .createExerciseResult(
                            widget.exerciseName,
                            widget.workoutId,
                            widget.exerciseId,
                            '${w1}/${t1}',
                            '${w2}/${t2}',
                            '${w3}/${t3}',
                            '${w4}/${t4}',
                            '${w5}/${t5}',
                            date.toString())
                        .whenComplete(() {
                      _isLoading = false;
                    });
                    Navigator.of(context).pop();
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
}

