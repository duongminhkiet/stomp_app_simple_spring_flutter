import 'package:chat_flutter/helper/common_helper.dart';
import 'package:chat_flutter/helper/global_variable.dart';
import 'package:chat_flutter/locale/localizations.dart';
import 'package:chat_flutter/object/user_obj.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:random_color/random_color.dart';
import 'package:swipedetector/swipedetector.dart';

import 'extension_mixin_all_screens.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with ExtensionMixinAllScreen {
  bool isLoginSuccess = false;
  bool isProcessing = false;
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode passWordFocusNode = FocusNode();

  void _login() async {
    String username = userNameController.text.trim();
    String password = passWordController.text.trim();

    if (username.isEmpty) {
      FocusScope.of(context).requestFocus(userNameFocusNode);
    } else if (password.isEmpty) {
      FocusScope.of(context).requestFocus(passWordFocusNode);
    } else {
      setState(() {
        UserObj userObj = UserObj();
        RandomColor _randomColor = RandomColor();
        Color _color2 = _randomColor.randomColor();
        userObj.colorAvatar = _color2;
        userObj.userName = username;
        userObj.passWord = password;
        userObj.userId = CommonHelper.getRandomUserID();
        print("\n ================================== MY ID: "+userObj.userId +"\n");
        userObj.status = 1;
        GlobalVariable.currentUser = userObj;
        isProcessing = true;
        //fetchUser(username, password);
        Route route = MaterialPageRoute(builder: (context) => HomeScreen());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  @override
  void dispose() {
    userNameFocusNode.dispose();
    passWordFocusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(LoginScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    String username = userNameController.text.trim();
    String password = passWordController.text.trim();
    if (username.isEmpty) {
      FocusScope.of(context).requestFocus(userNameFocusNode);
    } else if (password.isEmpty) {
      FocusScope.of(context).requestFocus(passWordFocusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    _fieldFocusChange(
        BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }

    var body = SwipeDetector(
      child: Column(children: <Widget>[
        Expanded(
            child: new Container(
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 40.0, bottom: 10.0),
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                child: new SingleChildScrollView(
                    child: new ConstrainedBox(
                        constraints: new BoxConstraints(),
                        child: new Column(children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
                            color: Colors.white,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: new Text(
                                    ZMKLocalizations.of(context)
                                        .title
                                        .toUpperCase(),
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF5d9b7c),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          KeyboardAvoider(
                              child: Container(
                                  child: new Column(children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(
                                    left: 0.0,
                                    right: 0.0,
                                    top: 50.0,
                                    bottom: 0.0),
                                child: new Theme(
                                  data: new ThemeData(
                                    primaryColor: Colors.redAccent,
                                    primaryColorDark: Colors.red,
                                  ),
                                  child: new TextFormField(
                                    focusNode: userNameFocusNode,
                                    controller: userNameController,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (term) {
                                      _fieldFocusChange(context,
                                          userNameFocusNode, passWordFocusNode);
                                    },
                                    decoration: new InputDecoration(
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.teal)),
                                        hintText: ZMKLocalizations.of(context)
                                            .login_title_home_username,
                                        helperText: '',
                                        labelText: ZMKLocalizations.of(context)
                                            .login_title_home_username,
                                        prefixIcon: const Icon(
                                          Icons.person,
                                          color: Colors.green,
                                        ),
                                        prefixText: '',
                                        suffixText: '',
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            userNameController.clear();
                                          },
                                          icon: Icon(
                                            Icons.clear,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        suffixStyle: const TextStyle(
                                            color: Colors.green)),
                                  ),
                                )),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 0.0,
                                    right: 0.0,
                                    top: 10.0,
                                    bottom: 10.0),
                                child: new Theme(
                                  data: new ThemeData(
                                    primaryColor: Colors.redAccent,
                                    primaryColorDark: Colors.red,
                                  ),
                                  child: new TextFormField(
                                    focusNode: passWordFocusNode,
                                    controller: passWordController,
                                    obscureText: true,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (value) {
                                      passWordFocusNode.unfocus();
                                      userNameFocusNode.unfocus();
                                      _login();
                                    },
                                    decoration: new InputDecoration(
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.teal)),
                                        hintText: ZMKLocalizations.of(context)
                                            .login_title_home_password,
                                        helperText: '',
                                        labelText: ZMKLocalizations.of(context)
                                            .login_title_home_password,
                                        prefixIcon: const Icon(
                                          Icons.security,
                                          color: Colors.green,
                                        ),
                                        prefixText: '',
                                        suffixText: '',
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            passWordController.clear();
                                          },
                                          icon: Icon(
                                            Icons.clear,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        suffixStyle: const TextStyle(
                                            color: Colors.green)),
                                  ),
                                )),
                          ]))),
                          Container(
                              child: RaisedButton(
                                  padding: EdgeInsets.only(
                                      left: 30.0,
                                      right: 30.0,
                                      top: 15.0,
                                      bottom: 15.0),
                                  textColor: Colors.white,
                                  color: Color(0xFF88d8b0),
                                  elevation: 14.0,
                                  splashColor: Color(0xFFf52321),
                                  child: new Text(
                                    ZMKLocalizations.of(context)
                                        .login_title_home_login,
                                    style: new TextStyle(
                                      fontSize: 23.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    _login();
                                  },
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0))))
                        ])))))
      ]),
      onSwipeUp: () {},
      onSwipeDown: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      onSwipeLeft: () {},
      onSwipeRight: () {},
      swipeConfiguration: SwipeConfiguration(
          verticalSwipeMinVelocity: 100.0,
          verticalSwipeMinDisplacement: 50.0,
          verticalSwipeMaxWidthThreshold: 100.0,
          horizontalSwipeMaxHeightThreshold: 50.0,
          horizontalSwipeMinDisplacement: 50.0,
          horizontalSwipeMinVelocity: 200.0),
    );
    //return body;
    return new Material(
      color: Colors.white,
      child: isProcessing ? processing : body,
    );
  }
}
