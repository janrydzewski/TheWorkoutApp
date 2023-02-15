import 'package:flutter/material.dart';
import 'package:the_workout_app/controllers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_workout_app/controllers/database_controller.dart';
import 'package:the_workout_app/controllers/helper_functions.dart';
import 'package:the_workout_app/views/widgets/sidebar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;
  bool _isLoading = false;
  String workoutName = "";
  String workoutId = "";
  Stream? workouts;
  String username = "";
  String email = "";
  Stream? workoutsStream;

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarWidget(),
      appBar: AppBar(
        title: const Text(
          "The Workout App",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      //floatingActionButton:
        //  FloatingActionButton(onPressed: popUpCreateGroupDialog(context)),
    );
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((value) {
      setState(() {
        username = value!;
      });
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserWorkouts()
        .then((snapshot) {
      setState(() {
        workouts = snapshot;
      });
    });
    await DatabaseService()
        .getWorkouts(FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      setState(() {
        workoutsStream = value;
      });
    });
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
                "Create a workout",
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
                              workoutName = val;
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
                              hintText: "input workout name"),
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
                    if (workoutName != "") {
                      setState(() {
                        _isLoading = true;
                      });
                      workoutId = "";

                      await DatabaseService(
                              uid: FirebaseAuth.instance.currentUser!.uid)
                          .createWorkout(
                              username,
                              FirebaseAuth.instance.currentUser!.uid,
                              workoutName)
                          .then((value) => workoutId = value)
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
}
