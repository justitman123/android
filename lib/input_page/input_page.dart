import 'package:bmi_calculator/input_page/choose.dart';
import 'package:bmi_calculator/input_page/pacman_slider.dart';
import 'package:bmi_calculator/input_page/responsive_screen.dart';
import 'package:bmi_calculator/input_page/transition_dot.dart';
import 'package:bmi_calculator/input_page/utils.dart';
import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class InputPage extends StatefulWidget {
  @override
  InputPageState createState() {
    return new InputPageState();
  }
}

class InputPageState extends State<InputPage> with TickerProviderStateMixin {
  IOWebSocketChannel channel = new IOWebSocketChannel.connect(
      "ws://192.168.99.1:8085/ws/423/rmtbxzr4/websocket",
      headers: {
        'Connection': 'Connect',
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNTcyMjUyMjQ4LCJleHAiOjE1NzMxMTYyNDh9.UoRRp_pWWAgCKiRUhh8DMVOhbHH8lDyaMgFanEiPBD3PpHzHyvkkIQr6wK8wA3A8rWuIVIIhd7nDmfkwMNbXrw',
      });
  int i = 0;

//  final WebSocketChannel channel = IOWebSocketChannel.connect(
//    Uri(scheme: "ws", host: "192.168.99.100", port: 8080, path: "/socket"),
//  );
  Screen size;
  AnimationController _submitAnimationController;
  int height = 180;
  int weight = 70;
  static const String API_DMS_WEB_SOCKET_HOST = '192.168.99.1';

  @override
  void initState() {
    super.initState();
    channel.stream.listen((message) {
      hartbeating(message);
      // handling of the incoming messages
    }, onError: (error, StackTrace stackTrace) {
      print(error);
      // error handling
    }, onDone: () {
      print("fsdfds");
      // communication has been closed
    });
//    "[\"\\n\"]"
    channel.sink.add(
        "[\"CONNECT\\nchatRoomId:61050d46-5d90-4ecb-a1aa-c967434adc63\\naccept-version:1.1,1.0\\nheart-beat:10000,10000\\n\\n\\u0000\"]");
    channel.sink.add(
        "[\"SUBSCRIBE\\nid:sub-0\\ndestination:/chatroom/connected.users\\n\\n\\u0000\"]");

//    channel.sink.add(["SUBSCRIBE\nid:sub-0\ndestination:/chatroom/connected.users"]);
    ws: //localhost:8080/ws/388/ihwkcezr/websocket
//    "[\"CONNECT\\nchatRoomId:61050d46-5d90-4ecb-a1aa-c967434adc63\\naccept-version:1.1,1.0\\nheart-beat:10000,10000\\n\\n\\u0000\"]"
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
    double height = screenAwareSize(180, context);
    return Stack(
      children: <Widget>[
        WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
              body: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: CustomScrollView(slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SearchPage(),
                        ],
                      ),
                    ),
                  ]),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    _buildBottom(context),
                  ],
                )
              ],
            ),
          )

//            Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                SearchPage(),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.end,
//                  children: <Widget>[
//                    _buildBottom(context),
//                  ],
//                )
//              ],
//            ),
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

  void hartbeating(String message) async {
    print(message);
    if ("a[\"\\n\"]" == message) {
      i++;
      if (i == 2) {
        channel.sink.add("[\"\\n\"]");
        i = 0;
      }
    }
  }
}
