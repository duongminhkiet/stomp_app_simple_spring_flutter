import 'package:chat_flutter/helper/global_variable.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'dart:math';

import 'dart:async';
import 'dart:convert';
class StompService {
  final String HOST = "10.72.34.198";
  static var stompClient = null;
  void initStomp(){
    stompClient = StompClient(
        config: StompConfig(
            url: 'ws://$HOST:6060/ws/websocket',
            onConnect: onConnect,
            onDisconnect: onDisconnect,
            onStompError: onStompError,
            onWebSocketError: (dynamic error) => print(error.toString()),
            stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
            webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'}));
  }
  void startStomp(){
    if(stompClient == null){
      initStomp();
    }
    stompClient.activate();
  }
  void desTroyStomp(){
    if(stompClient != null){
      stompClient.deactivate();
    }
  }

  dynamic onDisconnect(StompFrame frame){
    print("--onDisconnect---");
  }
  dynamic onStompError(StompFrame frame){
    print("--onStompError---");
    print(json.decode(frame.body));
  }
  dynamic onConnect(StompClient client, StompFrame frame) {
    //stompClient = client;
    // var url = stompClient.ws._transport.url;
    // url = url.replace(
    //     "ws://localhost:8080/spring-security-mvc-socket/secured/room/",  "");
    // url = url.replace("/websocket", "");
    // url = url.replace(/^[0-9]+\//, "");
    // console.log("Your current session is: " + url);
    // sessionId = url;
    StompService.stompClient?.subscribe(
        destination: "/user/"+GlobalVariable.currentUser.userId+"/queue/messages",
        callback: (StompFrame frame) {
//    List<dynamic> result = json.decode(frame.body);
          print("\n =================== \n ONE-ONE \n");
          print(json.decode(frame.body));

        });


      // client send => app
      // client get => topic
      // server send => topic
      // server get => messageMapping (without /app)

      client?.subscribe(
          destination: "/topic/chat/public",
          callback: (StompFrame frame) {
//    List<dynamic> result = json.decode(frame.body);
            print("\n public XXXXXXXXXXXX \n");
            print(json.decode(frame.body));

          });

      client?.subscribe(
          destination: "/secured/user/"+GlobalVariable.currentUser.userId+"/queue/messages",
          callback: (StompFrame frame) {
//    List<dynamic> result = json.decode(frame.body);
            print("\n =================== \n ONE-ONE \n");
            print(json.decode(frame.body));

          });

      // client?.send(
      //     destination: "/stompChatApp/chat.addUser.toPublic",
      //     body: json.encode({
      //       "sender": "FlutterFW",
      //       "type": "JOIN",
      //       "content": "Joining the chat"
      //     }));
      stompClient?.send(
          destination: "/stompChatApp/chat.addUser.toPublic",
          body: json.encode({
            "senderId": GlobalVariable.currentUser.userId,
            "type": "JOIN",
            "content": "Joining the chat"
          }));
    /*
      client?.subscribe(
          destination: "/topic/zmkchat/send/message/to/testchanel",
          callback: (StompFrame frame) {
            print("yyy");
            print(json.decode(frame.body));
          });

      Timer.periodic(Duration(seconds: 100), (_) {
        if(client.connected){
          client?.send(
              destination: "/stompChatApp/zmkchat/send/message/to/testchanel",
              body: json.encode({
                "sender": "FlutterFW 100",
                "type": "CHAT",
                "content": "CHAT - test content - flutter 100"
              }));
        }else{
          print('client is null 100');
        }
      });
      */
      for(int i = 0; i< 99; i++){
        String jd = i.toString();
        client?.subscribe(
            destination: "/topic/zmkchat/send/message/to/testchanel/roomX"+jd,
            callback: (StompFrame frame) {
              print("\n Got from ROOM: roomX"+jd);
              print(json.decode(frame.body));
            });
      }

      Timer.periodic(Duration(seconds: 15), (_) {
        Random random = new Random();
        int randomNumber = random.nextInt(100);
        print('client send from: roomX'+randomNumber.toString());
        if(client.connected){
          print('client.connected 111');
          // client?.send(
          //     destination: "/stompChatApp/zmkchat/send/message/to/testchanel/roomX"+randomNumber.toString(),
          //     body: json.encode({
          //       "sender": "FlutterFW 10",
          //       "type": "CHAT",
          //       "content": "CHAT - test content - flutter 10"
          //     }));
          client?.send(
              destination: "/stompChatApp/zmkchat/send/message/to/testchanel/roomX"+randomNumber.toString(),
              body: json.encode({
                "senderId": GlobalVariable.currentUser.userId,
                "receiverId": "XX-receiver",
                "type": "CHAT",
                "content": "CHAT - test content - flutter 10 + "+randomNumber.toString()
              }));
        }else{
          print('client is null');
        }
      });

  }
}