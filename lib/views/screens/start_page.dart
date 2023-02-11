import 'package:flutter/material.dart';
import 'package:the_workout_app/views/screens/login_page.dart';
import 'package:the_workout_app/views/screens/signup_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 150,
          ),
          Container(
            child: Image.asset('assets/images/logo.png'),
            width: 180,
            height: 180,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "The Workout App",
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 170,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: Container(
                child: Center(
                    child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 16),
                )),
                width: size.width * 0.65,
                height: size.height * 0.06,
              ),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.redAccent)),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Container(
              child: Center(
                  child: const Text(
                "Log In",
                style: TextStyle(fontSize: 16),
              )),
              width: size.width * 0.65,
              height: size.height * 0.06,
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 3, // thickness
                        color: Colors.redAccent // color
                        ),
                    borderRadius: BorderRadius.circular(4))),
          ),
        ]),
      ),
    );
  }
}
