import 'package:bmi_calculator/input_page/choose.dart';
import 'package:bmi_calculator/input_page/pacman_slider.dart';
import 'package:bmi_calculator/input_page/responsive_screen.dart';
import 'package:bmi_calculator/input_page/transition_dot.dart';
import 'package:bmi_calculator/input_page/utils.dart';
import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:jstomp/jstomp.dart';
import "package:stomp/stomp.dart";
import "package:stomp/vm.dart" show connect;
import 'package:web_socket_channel/web_socket_channel.dart';

import 'JStomps.dart';

class InputPage extends StatefulWidget {
  @override
  InputPageState createState() {
    return new InputPageState();
  }
}

class InputPageState extends State<InputPage> with TickerProviderStateMixin {
  WebSocketChannel _channel;

//  final WebSocketChannel channel = IOWebSocketChannel.connect(
//    Uri(scheme: "ws", host: "192.168.99.100", port: 8080, path: "/socket"),
//  );
  Screen size;
  AnimationController _submitAnimationController;
  int height = 180;
  int weight = 70;
  static const String API_DMS_WEB_SOCKET_HOST = '192.168.99.1';
  JStomps stomp;

  Future _initStomp() async {
    if (stomp == null) {
      stomp = JStomps.instance;
    }
    String userId = "104435390701569";
    String url = "ws://192.168.99.1:8060/chat/ws/423/rmtbxzr4/websocket";
    bool b = await stomp.init(url: url, sendUrl: "");

    print(b ? 'Initialization Succesfull' : 'Initialization Failed');

    if (b) {
      ///打开连接
      await stomp.connection((open) {
        print("The connection is open ...$open");
      }, onError: (error) {
        print("Connection open error...$error");
      }, onClosed: (closed) {
        print("Connection open error...$closed");
      });
    }

//    ///订阅点对点通道
//    final String p2p = "/groupMessage/channel/" + userId;
//    await stomp.subscribP2P([p2p]);
//
//    ///订阅广播通道
//    await stomp.subscribBroadcast(["groupBroadcast/message"]);
    ;
  }

  @override
  void initState() {
    super.initState();
    _initStomp();
//    ws://localhost:8080/ws/388/ihwkcezr/websocket
//    0: "CONNECT↵chatRoomId:61050d46-5d90-4ecb-a1aa-c967434adc63↵accept-version:1.1,1.0↵heart-beat:10000,10000↵↵"
//    "CONNECT\nchatRoomId:61050d46-5d90-4ecb-a1aa-c967434adc63\naccept-version:1.1,1.0\nheart-beat:10000,10000\n\n\u0000"
    _submitAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1900),
    );
    _submitAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        (state) => print('$state');
//          goToRandomChat().then((_) => _submitAnimationController.reset());
        goToRandomChat().then((_) => {});
      }
    });
  }

  @override
  void dispose() {
    _submitAnimationController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => {},
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => {
                  Navigator.pop(context),
                  _submitAnimationController.reverse()
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);
    return Stack(
      children: <Widget>[
        WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SearchPage(),
//                _buildBottom(context),
              ],
            ),
          ),
        ),
        TransitionDot(animation: _submitAnimationController),
      ],
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenAwareSize(16.0, context),
        right: screenAwareSize(16.0, context),
        bottom: screenAwareSize(22.0, context),
        top: screenAwareSize(14.0, context),
      ),
      child: PacmanSlider(
        submitAnimationController: _submitAnimationController,
        onSubmit: onPacmanSubmit,
      ),
    );
  }

  void onPacmanSubmit() {
    _submitAnimationController.forward();
  }

  Future<void> goToRandomChat() async {
    print('fsdfsdflllllllllllllllllllllllllll');
  }
}
