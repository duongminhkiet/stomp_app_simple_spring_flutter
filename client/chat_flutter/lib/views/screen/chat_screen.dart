import 'dart:convert';
import 'dart:developer';

import 'package:bubble/bubble.dart';
import 'package:chat_flutter/helper/common_helper.dart';
import 'package:chat_flutter/helper/global_variable.dart';
import 'package:chat_flutter/locale/localizations.dart';
import 'package:chat_flutter/object/chanel_obj.dart';
import 'package:chat_flutter/object/chat_message_obj.dart';
import 'package:chat_flutter/object/user_obj.dart';
import 'package:chat_flutter/services/service_locatior.dart';
import 'package:chat_flutter/services/stomp_service.dart';
import 'package:chat_flutter/views/stateModel/home_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:swipedetector/swipedetector.dart';

import 'extension_mixin_all_screens.dart';

class ChatScreen extends StatefulWidget {

  //final void Function(ChanelObj item) callbackFunction;
  ChanelObj chanel;
  //ChatScreen({Key key, this.chanel, this.callbackFunction}) : super(key: key);
  ChatScreen({Key key, this.chanel}) : super(key: key);
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with ExtensionMixinAllScreen {
  bool isProcessing = false;
  final FocusNode textChatFocusNode = FocusNode();
  final textChatController = TextEditingController();
  final Color backgroundColor = Color(0xFFFCE4E4);
  ScrollController _scrollController = new ScrollController();

  HomeScreenModel modelX = serviceLocator
      .get<HomeScreenModel>(); // = serviceLocator<HomeScreenModel>();
  @override
  void initState() {

    //modelX = serviceLocator.get<HomeScreenModel>();

//    modelX.changeWhenResignedObject();

//    data = serviceLocator<HomeScreenModel>();
//    modelX = serviceLocator<HomeScreenModel>();
//    String objStr = modelX.toString();

//    var b1 = modelX?.mArrChanel;
//    log('ID MODEL AT CHAT SCREEN: $b1');
    print('\n================================================'+'My ID: '+GlobalVariable.currentUser.userId+' \n RECEIVER ID: '+widget.chanel.receiver.userId+"\n");

    title = widget.chanel.chanelName;
    if (widget.chanel.isRoom) {
      for (UserObj user in widget.chanel.mArrUsersLists) {
        subTitle += user.userName + "|";
      }
      if (subTitle.length > 0) {
        subTitle = subTitle.substring(0, subTitle.length - 1);
      }
    }
    // StompService.stompClient?.subscribe(
    //     destination: "/user/"+GlobalVariable.currentUser.userId+"/queue/messages",
    //     callback: (StompFrame frame) {
    //       print("\n =================== \n ONE-ONE \n");
    //       print(json.decode(frame.body));
    //
    //     });
    // StompService.stompClient?.subscribe(
    //     destination: "/user/"+widget.chanel.receiver.userId+"/queue/messages",
    //     callback: (StompFrame frame) {
    //       print("\n =================== \n ONE-ONE RECEIVER \n");
    //       print(json.decode(frame.body));
    //
    //     });
  }

  @override
  void dispose() {
    textChatController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  Widget createAvatar(ChatMessageObject chatMessageObject) {
    return Stack(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: chatMessageObject?.sender?.colorAvatar,
              shape: BoxShape.circle),
          child: Text(
            CommonHelper.getTheFirstCharacterInString(
                chatMessageObject?.sender?.userName),
            style: new TextStyle(
              fontSize: 38.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
          ),
          alignment: Alignment.center,
        ),
      ],
    );
  }

  Widget leftBubble(ChatMessageObject chatMessageObject) {
    return Bubble(
      margin: BubbleEdges.only(top: 5),
      padding: BubbleEdges.only(left: 10, top: 10, right: 10, bottom: 5),
      alignment: Alignment.topLeft,
      nip: BubbleNip.leftTop,
      child: Text(chatMessageObject.content),
    );
  }

  Widget rightBubble(ChatMessageObject chatMessageObject) {
    return Bubble(
      margin: BubbleEdges.only(top: 5),
      padding: BubbleEdges.only(left: 10, top: 10, right: 10, bottom: 5),
      alignment: Alignment.topRight,
      nip: BubbleNip.rightTop,
      color: Color.fromARGB(255, 225, 255, 199),
      child: Text(chatMessageObject.content),
    );
  }

  void sendMessage(ChatMessageObject chatMessageObject, HomeScreenModel data) {
    setState(() {
      //serviceLocator<HomeScreenModel>().update();
      ChatMessageObject cmo = ChatMessageObject();
      cmo.sender = GlobalVariable.currentUser;
      cmo.receiver = widget.chanel.receiver;
      cmo.content = textChatController.text.toString();
      cmo.date = "hom nay";
      textChatController.clear();
      widget.chanel.addOne(cmo);
      widget.chanel.setLastMessage(cmo.content);
      widget.chanel.getLastMessage();

//      ChanelObj cn2 = ChanelObj.fromChanel(widget.chanel);
//      ChanelObj cn3 = data.mArrChanel
//          .firstWhere((chanel) => chanel.chanelId == widget.chanel.chanelId);
//      int position = data.mArrChanel
//          .indexWhere((element) => element.chanelId == widget.chanel.chanelId);

      data.updateChanelObjectContent(widget.chanel, cmo);
//      modelX.updateChanelObjectContent(widget.chanel, cmo);
//      data.updateAtIndex(cn2, position);
      StompService.stompClient?.send(
          destination: "/stompChatApp/chatone",
          body: json.encode({
            "senderId": GlobalVariable.currentUser.userId,
            "receiverId": cmo.receiver.userId,
            "type": "CHAT",
            "content": cmo.content
          }));

      //widget.callbackFunction(widget.chanel);
    });

    //widget.chanel.getLastMessage();
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToEnd());
  }

  void scrollToEnd() async {
    var scrollPosition = _scrollController.position;
/*
    if (scrollPosition.viewportDimension < scrollPosition.maxScrollExtent) {
      log('######################################################');
      await _scrollController.animateTo(
        scrollPosition.maxScrollExtent,
        duration: new Duration(milliseconds: 200),
        curve: Curves.fastLinearToSlowEaseIn,
      );
      Scrollable.ensureVisible(lastKey.currentContext);
    }
*/

    log('############################ scrollToEnd ##########################');
    await _scrollController.animateTo(
      scrollPosition.maxScrollExtent,
      duration: new Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    modelX = Provider.of<HomeScreenModel>(context);
    // phải dùng cái này để khi thay đổi dữ liệu ở màn hình này thì màn hình khác có liên quan tới object này cũng được thay đổi theo, nếu không dùng cái này thì màn hình khác có liên quan tới object này ko thể thay đổi trên UI ngay lập tức được

    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToEnd());
    Column makeRow(ChatMessageObject chatMessageObject) {
      return chatMessageObject.isMe()
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: rightBubble(chatMessageObject),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Text(chatMessageObject.date,
                          style: new TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          )),
                      margin: const EdgeInsets.only(
                          left: 0, top: 0, right: 10, bottom: 0),
                    ),
                  ],
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    createAvatar(chatMessageObject),
                    Expanded(
                      flex: 1,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: leftBubble(chatMessageObject),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(chatMessageObject.date,
                                      style: new TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                      )),
                                  margin: const EdgeInsets.only(
                                      left: 10, top: 0, right: 0, bottom: 0),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ],
                ),
              ],
            );
    }

    GestureDetector makeCard(ChatMessageObject chatMessageObject) =>
        GestureDetector(
//      onTap: () {
//        Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (context) => ChatScreen(
//                  chanel: chanelObj,
//                )));
//      },
          child: Card(
            elevation: 0.0,
            child: Container(
              padding: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
              decoration: BoxDecoration(color: backgroundColor),
              child: makeRow(chatMessageObject),
            ),
          ),
        );
    //var count = widget.chanel?.mArrChatMessageLists?.length;
    final makeBody = Container(
      color: backgroundColor,
      child: ListView.separated(
        controller: _scrollController,
        itemCount: (widget.chanel.mArrChatMessageLists != null)
            ? widget.chanel?.mArrChatMessageLists?.length
            : 0,
        separatorBuilder: (BuildContext context, int index) => Container(
          padding: EdgeInsets.all(0.0),
          child: Center(
            child: null,
          ),
          color: Colors.transparent,
        ),
        itemBuilder: (BuildContext context, int index) {
          //if (index < 50)

          return makeCard(widget.chanel?.mArrChatMessageLists[index]);
        },
      ),
    );
    Widget makeChatBox(HomeScreenModel model) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: TextFormField(
              focusNode: textChatFocusNode,
              controller: textChatController,
              textInputAction: TextInputAction.send,
              onFieldSubmitted: (term) {
                sendMessage(null, model);
              },
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  hintText: ZMKLocalizations.of(context).chat_hint_enterchat,
                  helperText: '',
                  labelText: '',
                  prefixIcon: IconButton(
                    onPressed: () {
                      CommonHelper.showDialog1Button(
                          context, "Title prefixIcon", "body prefixIcon");
                    },
                    icon: Icon(
                      Icons.open_with,
                      color: Colors.blue,
                    ),
                  ),
                  prefixText: '',
                  suffixText: '',
                  suffixIcon: IconButton(
                    onPressed: () {
                      sendMessage(null, model);
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  ),
                  suffixStyle: const TextStyle(color: Colors.green)),
            ),
          ),
        ],
      );
    }

//    final body = SwipeDetector(
//      child:
//          Column(children: <Widget>[Expanded(child: makeBody), makeChatBox()]),
//      onSwipeUp: () {},
//      onSwipeDown: () {
//        FocusScope.of(context).requestFocus(new FocusNode());
//      },
//      onSwipeLeft: () {},
//      onSwipeRight: () {},
//      swipeConfiguration: SwipeConfiguration(
//          verticalSwipeMinVelocity: 100.0,
//          verticalSwipeMinDisplacement: 50.0,
//          verticalSwipeMaxWidthThreshold: 100.0,
//          horizontalSwipeMaxHeightThreshold: 50.0,
//          horizontalSwipeMinDisplacement: 50.0,
//          horizontalSwipeMinVelocity: 200.0),
//    );

    Widget body(HomeScreenModel model) {
      return SwipeDetector(
        child: Column(
            children: <Widget>[Expanded(child: makeBody), makeChatBox(model)]),
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
    }

    return Scaffold(
      backgroundColor: Colors.white, // Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar(context, this, null),
      body: isProcessing ? processing : body(modelX),
    );

//    return ChangeNotifierProvider<HomeScreenModel>(
//      create: (context) => Provider.of<HomeScreenModel>(context), //modelX,
//      child: Consumer<HomeScreenModel>(
//        builder: (context, model, child) => Scaffold(
//          backgroundColor: Colors.white, // Color.fromRGBO(58, 66, 86, 1.0),
//          appBar: topAppBar(context, this, null),
//          body: isProcessing ? processing : body(model),
//        ),
//      ),
//    );
  }

//  Widget body = Container(
//    color: Color.fromARGB(1, 123, 234, 90),
//  );
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
