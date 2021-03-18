import 'package:flutter/material.dart';

class CopyScreen extends StatefulWidget {
  @override
  _CopyScreenState createState() => _CopyScreenState();
}

class _CopyScreenState extends State<CopyScreen> {
  bool isNotProcessing = true;
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: isNotProcessing ? body : processing,
    );
    /*return Scaffold(
      backgroundColor: Colors.white,
      appBar: topAppBar(context, this),
      body: isNotProcessing ? body : processing,
    );*/
  }

  Widget body = Container(
    color: Color.fromARGB(1, 123, 234, 90),
  );
  Widget processing = Center(
    child: new SizedBox(
      height: 50.0,
      width: 50.0,
      child: new CircularProgressIndicator(
        value: null,
        strokeWidth: 7.0,
      ),
    ),
  );
}
