import 'package:chat_flutter/object/chat_message_obj.dart';
import 'package:chat_flutter/object/parent_obj.dart';
import 'package:chat_flutter/object/user_obj.dart';
import 'package:flutter/foundation.dart';

//chanel có thể là room nếu -> chat room
//chanel có thể là user nếu -> chat 1-1
class ChanelObj extends ParentObj with ChangeNotifier {
  String chanelId;
  //start chat room
  String chanelName;
  String chanelPassword;
  bool isRoom;
  //end chat room

  //start chat 1-1
  UserObj receiver;
  //end chat 1-1
  List<ChatMessageObject> mArrChatMessageLists = []; // các message trong chanel
  void addArrayChatMessageList(List<ChatMessageObject> mArrs) {
    mArrChatMessageLists.addAll(mArrs);
    notifyListeners();
  }

  void addOne(ChatMessageObject obj) {
    mArrChatMessageLists.add(obj);
    //notifyListeners();
  }

  List<UserObj> mArrUsersLists = []; // các user trong chanel
  void addArrayUsersList(List<UserObj> mArrUsers) {
    mArrUsersLists.addAll(mArrUsers);
    notifyListeners();
  }

  String typing = ""; // typing at home screen

  //for scroll to bottom in listview
  //final lastKey = null;

  String _lastMessage;
  String getLastMessage() {
    int sizeArray = mArrChatMessageLists.length;
    if (sizeArray > 0) {
      _lastMessage = mArrChatMessageLists[sizeArray - 1].content;
    } else {
      _lastMessage = "";
    }
    //notifyListeners();
    return _lastMessage;
  }

  //String get getLastMessage => _lastMessage;
  void setLastMessage(String lastMsg) {
    this._lastMessage = lastMsg;
    notifyListeners();
  }

  ChanelObj();
  ChanelObj.fromChanel(ChanelObj chanel)
      : chanelId = chanel.chanelId,
        chanelName = chanel.chanelName,
        chanelPassword = chanel.chanelPassword,
        isRoom = chanel.isRoom,
        mArrChatMessageLists = chanel.mArrChatMessageLists,
        mArrUsersLists = chanel.mArrUsersLists;
}
