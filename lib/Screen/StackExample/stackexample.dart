import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StackScreen extends StatelessWidget {
  const StackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(10),
      child: Stack(
        children: [
          Container(height: 200,width: 200,color: Colors.red,),
          Positioned(
            top: 10,
            bottom: 20,
            right: 20,
            left: 30,
            child: Container(height: 100,width: 100,color: Colors.blue,))
        ],
      ),
      ),
    );
  }
}