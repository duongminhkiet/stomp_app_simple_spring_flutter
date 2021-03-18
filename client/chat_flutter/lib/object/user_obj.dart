import 'dart:ui';

import 'package:chat_flutter/object/parent_obj.dart';

class UserObj extends ParentObj {
  String userId;
  String userName; //Annv
  String fullName; // Nguyen Van An
  String passWord;
  int status; //1:online, 2: take way, 3: offline
  Color colorAvatar;
  UserObj(
      {this.userId, this.userName, this.fullName, this.passWord, this.status});
}
