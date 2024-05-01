import 'package:finishit/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:finishit/Task_screen.dart';
import 'package:finishit/commonbox.dart';
import 'package:finishit/home_screen.dart';
import 'package:finishit/login_page.dart';
import 'package:finishit/signup_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return CommonBox();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KeepUP',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          LoginPage.id: (context) => const LoginPage(),
          SignupPage.id: (context) => const SignupPage(),
          TaskScreen.id: (context) => const TaskScreen(),
        },
      ),
    );
  }
}
