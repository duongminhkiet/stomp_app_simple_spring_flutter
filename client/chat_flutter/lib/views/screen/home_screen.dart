import 'dart:developer';

import 'package:chat_flutter/helper/common_helper.dart';
import 'package:chat_flutter/object/chanel_obj.dart';
import 'package:chat_flutter/services/service_locatior.dart';
import 'package:chat_flutter/services/stomp_service.dart';
import 'package:chat_flutter/views/screen/extension_mixin_all_screens.dart';
import 'package:chat_flutter/views/stateModel/home_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with ExtensionMixinAllScreen, StompService {
  HomeScreenModel modelX = serviceLocator
      .get<HomeScreenModel>(); //= serviceLocator<HomeScreenModel>();

  bool isProcessing = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  //HomeScreenModel _data;
  void _onRefresh() async {
    // monitor network fetch
    print('onRefresh...');
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());

    //initData(); //KIETDM@CPC.VN
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  createRoom() async {
    setState(() {
      isProcessing = !isProcessing;
    });
    CommonHelper.showDialog1Button(context, "Tieu de trong HomeScreenState",
        "noi dung body trong HomeScreenState");
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
    desTroyStomp();
  }

  @override
  void initState() {
    startStomp();

    modelX.initData();
//    String objStr = modelX.toString();
    var b1 = modelX.mArrChanel;
    log('ID MODEL AT HOME SCREEN: $b1');
//    log('ID MODEL AT HOME SCREEN: $modelX');
  }

  Widget createAvatar(ChanelObj chanelObj) {
    return Stack(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: chanelObj?.isRoom
                  ? Colors.lightBlue
                  : chanelObj.receiver?.status == 1
                      ? Colors.green
                      : chanelObj.receiver?.status == 2
                          ? Colors.orange
                          : Colors.grey,
              shape: BoxShape.circle),
          child: Text(
            chanelObj?.isRoom
                ? "*"
                : CommonHelper.getTheFirstCharacterInString(
                    chanelObj.chanelName),
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

  @override
  Widget build(BuildContext context) {
//    _data = Provider.of<HomeScreenModel>(context);
//    _data.initData();

    Expanded itemContent(
        BuildContext context, ChanelObj chanelObj, HomeScreenModel model) {
      return Expanded(
        flex: 1,
        child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(chanelObj?.chanelName,
                          style: new TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFFFF0000),
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
//                    child: itemx
                      child: Container(
                        child: Text(
                          chanelObj?.typing.toString().trim() != ""
                              ? chanelObj?.typing
                              : chanelObj?.getLastMessage(),
//                          _data.testContent,
                          style: new TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF064AF7),
                          ),
                          softWrap: true,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      );
    }

    Row makeRow(ChanelObj chanelObj, HomeScreenModel model) => Row(
          children: <Widget>[
            createAvatar(chanelObj),
            itemContent(context, chanelObj, model),
          ],
        );
    GestureDetector makeCard(ChanelObj chanelObj, HomeScreenModel model) =>
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          chanel: chanelObj,
                        )));
            /*
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChatScreen(
                chanel: chanelObj,
                callbackFunction: (editedItem) {
                  setState(() {
                    chanelObj = editedItem;
                  });
                },
              );
            }));
            */
          },
          child: Card(
            elevation: 8.0,
            child: Container(
              padding: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
              decoration: BoxDecoration(color: Colors.white),
              child: makeRow(chanelObj, model),
            ),
          ),
        );

    Widget makeBody1(HomeScreenModel model) {
      return Container(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: CustomHeader(
            builder: (BuildContext context, RefreshStatus mode) {
              Widget body;
              if (mode == RefreshStatus.idle) {
                body = Text("pull up load");
              } else if (mode == RefreshStatus.completed) {
                body = Text("completed");
              } else if (mode == RefreshStatus.failed) {
                body = Text("Load Failed!Click retry!");
              } else if (mode == RefreshStatus.refreshing) {
                body = Text("refreshing");
              } else {
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("pull up load");
              } else if (mode == LoadStatus.loading) {
                body = Text("loading");
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("release to load more");
              } else {
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: (model.mArrChanel != null) ? model.mArrChanel.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return makeCard(model.mArrChanel[index], model);
            },
          ),
        ),
      );
    }

    final makeBodyAll = Consumer<HomeScreenModel>(
        builder: (context, model, child) => makeBody1(modelX));
    return Scaffold(
      backgroundColor: Colors.white, // Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar(context, this, null),
      body: isProcessing ? processing : makeBodyAll,
    );

//    Widget makeBodyAll2(HomeScreenModel model) {
//      return Consumer<HomeScreenModel>(
//          builder: (context, model, child) => makeBody1(model));
//    }
//
//    return ChangeNotifierProvider<HomeScreenModel>(
//      create: (context) => modelX,
//      child: Consumer<HomeScreenModel>(
//        builder: (context, model, child) => Scaffold(
//          backgroundColor: Colors.white, // Color.fromRGBO(58, 66, 86, 1.0),
//          appBar: topAppBar(context, this, null),
//          body: isProcessing ? processing : makeBodyAll2(model),
//        ),
//      ),
//    );
  }

  Widget body = Container(
    color: Color.fromARGB(1, 123, 234, 90),
  );

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
