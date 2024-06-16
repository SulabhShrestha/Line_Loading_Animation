import 'package:flutter/material.dart';
import 'package:line_loading_animation/line_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LineAnimation(
                delayDuration: Duration(milliseconds: 700),
              ),
              SizedBox(width: 12),
              LineAnimation(
                delayDuration: Duration(milliseconds: 500),
              ),
              SizedBox(width: 12),
              LineAnimation(
                delayDuration: Duration(milliseconds: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
