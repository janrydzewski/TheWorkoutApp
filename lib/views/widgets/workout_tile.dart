import 'package:flutter/material.dart';
import 'package:the_workout_app/controllers/database_controller.dart';
import 'package:the_workout_app/views/screens/workout_page.dart';

class WorkoutTile extends StatefulWidget {
  final String username;
  final String workoutId;
  final String workoutName;

  const WorkoutTile(
      {Key? key,
      required this.username,
      required this.workoutId,
      required this.workoutName})
      : super(key: key);

  @override
  State<WorkoutTile> createState() => _WorkoutTileState();
}

class _WorkoutTileState extends State<WorkoutTile> {

  String newWorkoutName = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WorkoutPage(workoutName: widget.workoutName, workoutId: widget.workoutId,)));
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
                widget.workoutName.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            title: Text(
              widget.workoutName,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value){
                switch(value){
                  case "delete":
                    popUpDeleteDialog(context);
                    break;
                  case "rename":
                    popUpRenameDialog(context);
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("Rename"),
                    value: "rename",
                  ),
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

  popUpRenameDialog(BuildContext context) {
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
                "Rename a workout",
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (val) {
                      setState(() {
                        newWorkoutName = val;
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
                        hintText: "input new workout name"),
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
                  onPressed: () {
                    if(newWorkoutName != ""){
                      DatabaseService().renameWorkout(widget.workoutId, widget.workoutName, newWorkoutName);
                    }
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
            );
          });
        });
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
                    SizedBox(width: 15,),
                    ElevatedButton(
                      onPressed: () {
                        DatabaseService().deleteWorkout(widget.workoutId, widget.workoutName);
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
