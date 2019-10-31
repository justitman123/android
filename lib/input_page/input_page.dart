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

  bool _isOpened = false;
  bool darkmode = false;

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
    if (_isOpened) {
      return showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return new AlertDialog(
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
                      _submitAnimationController.reverse(),
                      _isOpened = false
                    },
                    child: new Text('Yes'),
                  ),
                ],
              );
            },
          ) ??
          false;
    }
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
              drawer: Drawer(
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xFFB33771),
                      ),
//                      accountName: Text("${userName()}"),
//                      accountEmail: Text("${email()}"),
                      currentAccountPicture: GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
//                          child: Text("${photoUrl()}",
//                              style: TextStyle(
//                                fontSize: 35.0,
//                                color: Colors.white,
//                                fontWeight: FontWeight.bold,
//                              )),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: darkmode
                          ? Image.asset(
                        'images/moon.png',
                        height: 30.0,
                        width: 26.0,
                      )
                          : Image.asset(
                        'images/sunny.png',
                        height: 30.0,
                        width: 26.0,
                      ),
                      title: Text("DarkMode"),
                      trailing: Switch(
                        value: darkmode,
                        onChanged: (val) {
                          setState(() {
                            darkmode = val;
                          });
                          if (darkmode) {
//                            theme.setTheme(ThemeData.dark());
//                          } else {
//                            theme.setTheme(ThemeData.light());
                          }
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
//                        Navigator.of(context)
//                            .push(MaterialPageRoute(builder: (context) => MyAccount()));
                      },
                      child: _showList(
                        "My Account",
                        (Icons.account_box),
                      ),
                    ),
                    InkWell(
                      onTap: () {
//                        Navigator.of(context)
//                            .push(MaterialPageRoute(builder: (context) => MyOrders()));
                      },
                      child: _showList(
                        "My Orders",
                        (Icons.shopping_basket),
                      ),
                    ),
                    InkWell(
                      onTap: () {
//                        Navigator.of(context)
//                            .push(MaterialPageRoute(builder: (context) => Settings()));
                      },
                      child: _showList(
                        "Settings",
                        (Icons.settings),
                      ),
                    ),
                    InkWell(
                      onTap: () {
//                        Navigator.of(context)
//                            .push(MaterialPageRoute(builder: (context) => About()));
                      },
                      child: _showList(
                        "About",
                        (Icons.adjust),
                      ),
                    ),
                    InkWell(
                      onTap: () {
//                        Navigator.of(context)
//                            .push(MaterialPageRoute(builder: (context) => Contact()));
                      },
                      child: _showList(
                        "Contact",
                        (Icons.contact_phone),
                      ),
                    ),
                  ],
                ),
              ),
            appBar: AppBar(
              titleSpacing: 2.0,
              elevation: 0,
              backgroundColor: colorCurve,
              title: Text("e-Bazaar"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
//                    showSearch(context: context, delegate: ProductSearch());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
//                    Navigator.of(context)
//                        .push(MaterialPageRoute(builder: (context) => Cart()));
                  },
                ),
              ],
            ),
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

  Widget _showList(String s, IconData i) {
    return ListTile(
      leading: Icon(
        i,
        color: Colors.yellow[700],
      ),
      title: Text(s),
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
    _isOpened = true;
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
class GradientAppBar extends StatelessWidget {

  final String title;
  final double barHeight = 50.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: new Center(
        child: new Text(
          title,
          style: new TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [Colors.red, Colors.blue],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp
        ),
      ),
    );
  }
}