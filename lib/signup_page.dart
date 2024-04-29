import 'package:finishit/Task_screen.dart';
import 'package:finishit/constants.dart';
import 'package:finishit/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupPage extends StatefulWidget {
  static const String id = 'signup_page';

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late dynamic email;
  late dynamic password;
  final _auth = FirebaseAuth.instance;
  bool spinner = false;

  void navigate() {
    Navigator.pushNamed(context, TaskScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/tick.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your E-mail')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Password')),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.blueAccent,
                label: 'Register',
                onPress: () async {
                  setState(() {
                    spinner = true;
                  });
                  try {
                    await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    // Navigator.pushNamed(context, LoginScreen.id);
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    spinner = false;
                  });
                  navigate();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
