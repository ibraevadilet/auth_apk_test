import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final String pass;
  const MyHomePage({Key? key, required this.pass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Ваш пароль - $pass"),
        ),
      ),
    );
  }
}
