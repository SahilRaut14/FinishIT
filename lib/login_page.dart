import 'package:finishit/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finishit/Task_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:finishit/rounded_button.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Your Password')),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.lightBlueAccent,
                label: 'log in',
                onPress: () async {
                  setState(() {
                    spinner = true;
                  });
                  try {
                    await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
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
