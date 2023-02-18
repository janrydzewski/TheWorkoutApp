import 'package:flutter/material.dart';
import 'package:the_workout_app/controllers/database_controller.dart';
import 'package:the_workout_app/views/screens/exercise_page.dart';
import 'package:the_workout_app/views/screens/workout_page.dart';

class ExerciseTile extends StatefulWidget {
  final String exerciseName;
  final String exerciseId;
  final String workoutId;

  const ExerciseTile({
    Key? key,
    required this.exerciseName,
    required this.exerciseId,
    required this.workoutId,
  }) : super(key: key);

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExercisePage(
                      exerciseName: widget.exerciseName,
                      exerciseId: widget.exerciseId,
                    )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.redAccent,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        width: 50,
        child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.redAccent,
              child: Text(
                widget.exerciseName.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            title: Text(
              widget.exerciseName,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case "delete":
                    popUpDeleteDialog(context);
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("Delete"),
                    value: "delete",
                  ),
                ];
              },
            )),
      ),
    );
  }

  popUpDeleteDialog(BuildContext context) {
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
                "Are you sure?",
                textAlign: TextAlign.center,
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        DatabaseService().deleteExercise(
                            widget.workoutId, widget.exerciseId);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 2, color: Colors.redAccent),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          primary: Colors.white54),
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            );
          });
        });
  }
}
