import 'package:flutter/material.dart';
import 'package:the_workout_app/controllers/database_controller.dart';
import 'package:the_workout_app/views/screens/exercise_page.dart';
import 'package:the_workout_app/views/screens/workout_page.dart';

class ResultTile extends StatefulWidget {
  final String workoutId;
  final String exerciseId;
  final String resultId;
  final String date;
  final String t1;
  final String t2;
  final String t3;
  final String t4;
  final String t5;

  const ResultTile({
    Key? key,
    required this.date,
    required this.t1,
    required this.t2,
    required this.t3,
    required this.t4,
    required this.t5,
    required this.workoutId,
    required this.exerciseId,
    required this.resultId,
  }) : super(key: key);

  @override
  State<ResultTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ResultTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
            title: Text(
              '${widget.t1}  ${widget.t2}  ${widget.t3}  ${widget.t4}  ${widget.t5}',
              style: TextStyle(fontSize: 19),
            ),
            subtitle: Text(
              widget.date,
              style: TextStyle(fontSize: 15),
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
                        DatabaseService().deleteResult(widget.workoutId,
                            widget.exerciseId, widget.resultId);
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
