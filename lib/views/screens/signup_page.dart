import 'package:flutter/material.dart';
import 'package:the_workout_app/controllers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_workout_app/views/screens/home_page.dart';
import 'package:the_workout_app/views/widgets/textfield_tile.dart';
import 'package:the_workout_app/views/screens/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Widget _registerButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: const Text('Login instead'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset('assets/images/logo.png'),
                width: 110,
                height: 110,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "The Workout App",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 115,
              ),
              TextFieldWidget(
                title: 'username',
                controller: _controllerUsername,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                title: 'email',
                controller: _controllerEmail,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                title: 'password',
                controller: _controllerPassword,
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    Auth.instance.createUserWithEmailAndPassword(
                      username: _controllerUsername.text,
                      email: _controllerEmail.text,
                      password: _controllerPassword.text,
                      context: context,
                    );
                  },
                  child: Container(
                    child: Center(
                        child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 16),
                    )),
                    width: size.width * 0.75,
                    height: size.height * 0.06,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent)),
            ],
          ),
        ),
      ),
    );
  }
}
