import 'dart:io';
import 'dart:math';
import 'package:chat_flutter/helper/global_variable.dart';
import 'package:chat_flutter/locale/localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CommonHelper {
  static String getTheFirstCharacterInString(String string) {
    if (string != null && string.length > 0) {
      return string[0];
    }
  }

  static void showDialog1Button(
      BuildContext context, String title, String body) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(body),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(ZMKLocalizations.of(context).ok_btn),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<bool> _execute(String test) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result != null) {
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  static Future<bool> isInternetAvailable() async {
    return await compute(_execute, '');
  }
  static String getRandomString(int length){
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
  static String getRandomUserID(){
    return getRandomString(GlobalVariable.ID_STRENGTH);
  }
}
