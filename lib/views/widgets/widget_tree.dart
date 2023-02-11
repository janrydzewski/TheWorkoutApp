import 'package:flutter/material.dart';
import 'package:the_workout_app/controllers/auth.dart';
import 'package:the_workout_app/views/screens/login_page.dart';
import 'package:the_workout_app/views/screens/home_page.dart';
import 'package:the_workout_app/views/screens/start_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return const StartPage();
        }
      },
    );
  }
}
