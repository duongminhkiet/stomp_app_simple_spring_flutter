import 'dart:async';
import 'dart:convert';

import 'package:chat_flutter/views/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import 'locale/localization_delegate.dart';
import 'services/service_locatior.dart';
import 'views/stateModel/home_screen_model.dart';

//final String HOST = "10.72.34.198";
void main() {
  //stompClient.activate();
  setupServiceLocator();
//  runApp(MyApp());

  runApp(
    MultiProvider(
      // dùng cái này để thay thế cho return ChangeNotifierProvider trên từng screen/ ngoài ra dùng cái này để có thể sử dụng được Provider.of trên các screen để giao tiếp với nhau và hiện thị sự thay đổi dữ liệu ngay trên UI
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                HomeScreenModel()), // nếu không thêm vào main tại đây thì ở mỗi hàm Build của từng screen StatefulWidget phải return  về ChangeNotifierProvider, còn khai báo ở đây thì tại mỗi hàm Build sẽ return bình thưởng như build UI trước đây, chỉ bổ sung thêm các tiện ích như Consumer hoặc get data qua context: HomeScreenModel data = Provider.of<HomeScreenModel>(context);
        //ChangeNotifierProvider(create: (_) => ChanelObj()),
      ],
      child: MyApp(),
    ),
  );
}

/*
final stompClient = StompClient(
    config:
        StompConfig(url: 'ws://$HOST:6060/ws/websocket', onConnect: onConnect));
dynamic onConnect(StompClient client, StompFrame frame) {
  client.subscribe(
      destination: "/topic/chat/public",
      callback: (StompFrame frame) {
        print("xxx");
        print(json.decode(frame.body));
      });

  client.send(
      destination: "/xx/chat.addUser.toPublic",
      body: json.encode({
        "sender": "FlutterFW",
        "type": "JOIN",
        "content": "Joining the chat"
      }));
  client.subscribe(
      destination: "/topic/zmkchat/send/message/to/testchanel",
      callback: (StompFrame frame) {
        print("yyy");
        print(json.decode(frame.body));
      });
  Timer.periodic(Duration(seconds: 100), (_) {
    client.send(
        destination: "/xx/zmkchat/send/message/to/testchanel",
        body: json.encode({
          "sender": "FlutterFW 100",
          "type": "CHAT",
          "content": "CHAT - test content - flutter 100"
        }));
  });
  client.subscribe(
      destination: "/topic/zmkchat/send/message/to/testchanel/roomX",
      callback: (StompFrame frame) {
        print("yyy");
        print(json.decode(frame.body));
      });
 Timer.periodic(Duration(seconds: 10), (_) {
   client.send(
       destination: "/xx/zmkchat/send/message/to/testchanel/roomX",
       body: json.encode({
         "sender": "FlutterFW 10",
         "type": "CHAT",
         "content": "CHAT - test content - flutter 10"
       }));
 });
}
*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: LoginScreen(),
//    );
    return MaterialApp(
      localizationsDelegates: [
        const ZMKLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('vi', ''),
      ],
      home: LoginScreen(),
    );
  }
}
