import 'package:fancy_switch_flutter/fancy_switch_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Fancy Switch Demo')),
        body: Center(
          child: FancySwitch(
            initialValue: true,
            onImagePath: 'assets/images/day.pn',
            offImagePath: 'assets/images/night.pn',
            thumbSize: 50.0,
            height: 60.0,
            width: 120.0,
            enableColor: Colors.lightGreen,
            disableColor: Colors.black26,
            onChanged: (val) {
              //print('Switch state: $val');
            },
          ),
        ),
      ),
    );
  }
}
