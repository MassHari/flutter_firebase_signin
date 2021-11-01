import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('welcome',
      style: TextStyle(
        fontSize: 35.0,
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold
      ),),
    );
  }
}
