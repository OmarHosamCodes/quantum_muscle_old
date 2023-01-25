import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(child: Text("TestPage$index"),),
   );
  }
}