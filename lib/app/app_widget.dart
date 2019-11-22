import 'package:flutter/material.dart';
import 'package:todo_hasura/app/pages/home/home_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomeModule(),
    );
  }
}
