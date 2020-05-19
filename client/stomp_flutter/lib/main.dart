import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

final String HOST = "10.72.34.94"; //IP of local server stomp (Spring)
void main() {
  stompClient.activate();
  runApp(MyApp());
}

final stompClient = StompClient(
    config: StompConfig(
        url: 'wss://$HOST:8080/ws/websocket', onConnect: onConnect));
dynamic onConnect(StompClient client, StompFrame frame) {
  client.subscribe(
      destination: "/topic/chat/public",
      callback: (StompFrame frame) {
//    List<dynamic> result = json.decode(frame.body);
        print("xxx");
        print(json.decode(frame.body));
      });
  client.send(
      destination: "/app/chat.addUser.toPublic",
      body: json.encode({
        "sender": "FlutterFW",
        "type": "JOIN",
        "content": "Joining the chat"
      }));
  client.subscribe(
      destination: "/topic/zmkchat/send/message/to/testchanel",
      callback: (StompFrame frame) {
//    List<dynamic> result = json.decode(frame.body);
        print("yyy");
        print(json.decode(frame.body));
      });
  Timer.periodic(Duration(seconds: 2), (_) {
    client.send(
        destination: "/app/zmkchat/send/message/to/testchanel",
        body: json.encode({
          "sender": "FlutterFW",
          "type": "CHAT",
          "content": "CHAT - test content - flutter"
        }));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
