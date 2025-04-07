import 'package:flutter/material.dart';
import 'package:fancy_switch_flutter/src/fancy_switch.dart';

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
            on_image_path: 'assets/images/day.png',
            off_image_path: 'assets/images/night.png',
            thumb_size: 50.0,
            height: 60.0,
            width: 120.0,
            onChanged: (val) {
              print('Switch state: $val');
            },
          ),
        ),
      ),
    );
  }
}
