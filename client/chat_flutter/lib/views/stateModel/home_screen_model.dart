import 'dart:ui';

import 'package:chat_flutter/helper/common_helper.dart';
import 'package:chat_flutter/helper/global_variable.dart';
import 'package:chat_flutter/object/chanel_obj.dart';
import 'package:chat_flutter/object/chat_message_obj.dart';
import 'package:chat_flutter/object/user_obj.dart';
import 'package:flutter/foundation.dart';
import 'package:random_color/random_color.dart';

class HomeScreenModel extends ChangeNotifier {
  List<ChanelObj> _mArrChanel = [];
  List<ChanelObj> get mArrChanel => _mArrChanel;
  void addChanel(ChanelObj chanelObj) {
    _mArrChanel.add(chanelObj);
    notifyListeners();
  }

  void changeWhenResignedObject() {
    if (_mArrChanel != null) {
      if (_mArrChanel.length >= 20) {
        _mArrChanel?.removeAt(19);
      }
    }

    notifyListeners();
  }

  void updateChanelObjectContent(ChanelObj chanelObj, ChatMessageObject cmo) {
//    int position = mArrChanel
//        .indexWhere((element) => element.chanelId == chanelObj.chanelId);

    chanelObj.addOne(cmo);
    notifyListeners();
  }

  void updateAtIndex(ChanelObj chanelObj, int index) {
    _mArrChanel.removeAt(index);
    _mArrChanel.insert(index, chanelObj);
    notifyListeners();
  }

  void removeChanel(ChanelObj chanelObj) {
    _mArrChanel.remove(chanelObj);
    notifyListeners();
  }

  String getLastMessageInChanel(ChanelObj chanelObj) {
    String lastMessage = chanelObj?.getLastMessage();
    notifyListeners();
    return lastMessage;
  }

  //START CREATE DATA DEMO
//  String _testContent = "11";
//  void setTestContent(String content) {
//    this._testContent = content;
//    notifyListeners();
//  }
//  String get testContent => _testContent;
  HomeScreenModel() {
    //initData();
  }
  int start = 0, end = 0;
  void initData() async {
    end = start + 20;
    int i;
    for (i = start; i < end; i++) {
      ChanelObj chanelObj = ChanelObj();
      chanelObj.chanelId = "" + i.toString();
      chanelObj.chanelName = "Name of chanel " + i.toString();
      if (i % 2 == 0) {
        chanelObj.isRoom = true;
        chanelObj.chanelPassword = "*";

        List<UserObj> mArrUsersLists = []; // các user trong chanel
        for (int j = 0; j < 20; j++) {
          RandomColor _randomColor = RandomColor();
          Color _color = _randomColor.randomColor();
          UserObj user = UserObj(
              userId: CommonHelper.getRandomUserID(),
              userName: "$j Username",
              fullName: "Full name $j",
              passWord: "**",
              status: j < 4 ? j : j % 2);
          user.colorAvatar = _color;
          mArrUsersLists.add(user);
        }

        List<ChatMessageObject> mArrChatMessageLists =
            []; // các message trong chanel
        int x = i % 20;
        for (int j = start; j < end; j++) {
          ChatMessageObject chatMessageObject = ChatMessageObject();
          chatMessageObject.content =
              "Nội dung tin nhắn test thử thứ: Nội dung tin nhắn test thử thứ:Nội dung tin nhắn test thử thứ:Nội dung tin nhắn test thử thứ:Nội dung tin nhắn test thử thứ:Nội dung tin nhắn test thử thứ:Nội dung tin nhắn test thử thứ:Nội dung tin nhắn test thử thứ:Nội dung tin nhắn test thử thứ:" +
                  j.toString();
          chatMessageObject.chatMessageId = "$j";
          chatMessageObject.date = "31/12/2020";

          if (j == 1) {
            chatMessageObject.sender = mArrUsersLists[j];
          } else if (j == 2) {
            chatMessageObject.sender = mArrUsersLists[j];
          } else if (j == 3) {
            chatMessageObject.sender = mArrUsersLists[j];
          } else if (j == 4) {
            chatMessageObject.sender = mArrUsersLists[j];
          } else if (j == 5) {
            chatMessageObject.sender = mArrUsersLists[j];
          } else if (j == 6) {
            chatMessageObject.sender = mArrUsersLists[j];
          } else if (j == 7) {
            chatMessageObject.sender = mArrUsersLists[j];
          } else if (j == 8) {
            chatMessageObject.sender = mArrUsersLists[j];
          } else if (j == 9) {
            chatMessageObject.sender = mArrUsersLists[j];
          } else {
            if (j % 2 == 1) {
              chatMessageObject.sender = mArrUsersLists[1];
            } else {
              chatMessageObject.sender = mArrUsersLists[x];
            }
          }

          mArrChatMessageLists.add(chatMessageObject);
          //create list users

        }

//        chanelObj.mArrUsersLists = mArrUsersLists;
//        chanelObj.mArrChatMessageLists = mArrChatMessageLists;
        chanelObj.addArrayUsersList(mArrUsersLists);
        chanelObj.addArrayChatMessageList(mArrChatMessageLists);
      } else {
        chanelObj.isRoom = false;

        List<ChatMessageObject> mArrChatMessageLists =
            []; // các message trong chanel
        List<UserObj> mArrUsersLists = []; // các user trong chanel
        String idUser1 = CommonHelper.getRandomUserID();
        UserObj user1 = UserObj(
            userId: idUser1,
            userName: "XuserName "+idUser1,
            fullName: "Full name "+idUser1,
            passWord: "**",
            status: 1);

        RandomColor _randomColor = RandomColor();
        Color _color1 = _randomColor.randomColor();
        user1.colorAvatar = _color1;

        mArrUsersLists.add(user1);
        mArrUsersLists.add(GlobalVariable.currentUser);

        for (int j = start; j < end; j++) {
          ChatMessageObject chatMessageObject = ChatMessageObject();
          chatMessageObject.content =
              //"Nội dung tin nhắn test thử thứ: Nội dung tin nhắn test thử thứ: Nội dung tin nhắn test thử thứ:Nội dung tin nhắn test thử thứ:Nội dung tin nhắn test thử thứ:Nội dung tin nhắn test thử thứNội dung tin nhắn test thử thứ: Nội dung tin nhắn test thử thứ:Nội dung tin nhắn test thử thứ:Nội dung tin nhắn test thử thứ:Nội dung tin nhắn test thử thứ" +
              "Nội dung tin nhắn " + j.toString();
          chatMessageObject.chatMessageId = "$j";
          chatMessageObject.date = "31/12/2020";

          if (j % 2 == 1) {
            chatMessageObject.sender = user1;
          } else {
            chatMessageObject.sender = GlobalVariable.currentUser;
          }
          mArrChatMessageLists.add(chatMessageObject);
          //create list users

        }

//        chanelObj.mArrUsersLists = mArrUsersLists;
//        chanelObj.mArrChatMessageLists = mArrChatMessageLists;
        chanelObj.receiver = user1;
        chanelObj.addArrayUsersList(mArrUsersLists);
        chanelObj.addArrayChatMessageList(mArrChatMessageLists);
      }
      mArrChanel.add(chanelObj);
    }
    start = i;
  }
}
