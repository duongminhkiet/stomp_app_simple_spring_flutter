import 'package:chat_flutter/helper/global_variable.dart';
import 'package:chat_flutter/object/parent_obj.dart';
import 'package:chat_flutter/object/user_obj.dart';

class ChatMessageObject extends ParentObj {
  String chatMessageId;
  String date;
  String content;
  String linkFile;

  UserObj sender;
  UserObj receiver;

  bool isMe(){
    if(GlobalVariable.currentUser.userId == sender.userId){
      return true;
    }else{
      return false;
    }
  }
}
