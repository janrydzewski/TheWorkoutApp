import 'package:flutter/material.dart';
import 'package:the_workout_app/controllers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_workout_app/views/screens/home_page.dart';
import 'package:the_workout_app/views/widgets/textfield_tile.dart';
import 'package:the_workout_app/views/screens/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth.instance
          .loginUser(_controllerEmail.text, _controllerPassword.text, context);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: signInWithEmailAndPassword,
      child: const Text('Login'),
    );
  }

  Widget _loginButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: const Text('Register instead'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Log In",
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
                    signInWithEmailAndPassword;
                  },
                  child: Container(
                    child: Center(
                        child: const Text(
                      "Log In",
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
