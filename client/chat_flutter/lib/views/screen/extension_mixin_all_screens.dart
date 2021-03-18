import 'package:chat_flutter/locale/localizations.dart';
import 'package:chat_flutter/object/parent_obj.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'chat_screen.dart';
import 'home_screen.dart';

class ExtensionMixinAllScreen {
  bool processingRight = false;
  String title = "";
  String subTitle = "";

  Widget topAppBar(BuildContext context, ExtensionMixinAllScreen screen,
      ParentObj parentObj) {
    Widget leadingWidget(BuildContext context, ExtensionMixinAllScreen screen,
        ParentObj parentObj) {
      if (screen is HomeScreenState) {
        return null;
      } else if (screen is ChatScreenState) {
        return new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              SystemNavigator.pop();
            }
          },
        );
      }
    }

    Widget titleWidget(BuildContext context, ExtensionMixinAllScreen screen,
        ParentObj parentObj) {
      if (screen is HomeScreenState) {
        return Column(children: [
          Text(
            ZMKLocalizations.of(context).home_title,
            style: new TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF064AF7),
            ),
          ),
        ]);
      } else if (screen is ChatScreenState) {
        return Column(children: [
          Text(
            title,
            style: new TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF064AF7),
            ),
          ),
          Text(subTitle,
              style: new TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF064AF7),
              ))
        ]);
      }
    }

    createRoom() async {}

    rightWidget(BuildContext context, ExtensionMixinAllScreen screen,
        ParentObj parentObj) {
      if (screen is HomeScreenState) {
        return processingRight
            ? <Widget>[
                Center(child: CircularProgressIndicator()),
              ]
            : <Widget>[
                SizedBox(
                    width: 80.00,
                    child: Opacity(
                      opacity: 1.0,
                      child: RaisedButton(
                          padding: EdgeInsets.only(
                              left: 2.0, right: 2.0, top: 2.0, bottom: 2.0),
                          textColor: Colors.white,
                          color: Color(0xFFff0055),
                          elevation: 14.0,
                          splashColor: Color(0xFFf52321),
                          child: new Text(
                            ZMKLocalizations.of(context).home_right_btn,
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            screen.createRoom();
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(00.0))),
                    ))
              ];
      } else if (screen is Null) {}
    }

    final topAppBar = AppBar(
      leading: leadingWidget(context, screen, parentObj),
      centerTitle: true,
      elevation: 0.1,
      backgroundColor: Color(0xFFCFE9DD),
      //Color.fromRGBO(58, 66, 86, 1.0),
      title: titleWidget(context, screen, parentObj),
      actions: rightWidget(context, screen, parentObj),
    );
    return topAppBar;
  }

  createRoom() async {}
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
