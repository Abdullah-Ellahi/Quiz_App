import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flashcard/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flashcard/controller/dependency_injection.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupHomePage() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    DependencyInjection.init();
    await Future.delayed(Duration(seconds: 2));

    print("MOVED FORWARD");
    Navigator.pushReplacementNamed(context,'/home');
    }

  @override
  void initState() {
    super.initState();
    setupHomePage();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: SpinKitSpinningLines(
          color: Colors.black,
          size: 100.0,
        ),
      )
    );
  }
}
