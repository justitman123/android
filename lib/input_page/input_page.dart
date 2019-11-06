import 'package:bmi_calculator/input_page/chooseChatScreen/choose.dart';
import 'package:bmi_calculator/input_page/googleSignIn.dart';
import 'package:bmi_calculator/input_page/loginScreen/LoginScreen3.dart';
import 'package:bmi_calculator/input_page/pacman_slider.dart';
import 'package:bmi_calculator/input_page/responsive_screen.dart';
import 'package:bmi_calculator/input_page/transition_dot.dart';
import 'package:bmi_calculator/input_page/utils.dart';
import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

class InputPage extends StatefulWidget {
  @override
  InputPageState createState() {
    return new InputPageState();
  }
}

class InputPageState extends State<InputPage> with TickerProviderStateMixin {
  Auth auth = Auth();
  bool _isOpened = false;
  bool darkmode = false;
  IOWebSocketChannel channel = new IOWebSocketChannel.connect(
      "ws://192.168.99.1:8085/ws/423/rmtbxzr4/websocket",
      headers: {
        'Connection': 'Connect',
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNTcyMjUyMjQ4LCJleHAiOjE1NzMxMTYyNDh9.UoRRp_pWWAgCKiRUhh8DMVOhbHH8lDyaMgFanEiPBD3PpHzHyvkkIQr6wK8wA3A8rWuIVIIhd7nDmfkwMNbXrw',
      });
  int i = 0;
  Screen size;
  AnimationController _submitAnimationController;

  Future<String> fetchPost() async {
    try {
      http
          .get(
              'https://accounts.google.com/signin/oauth?client_id=859776580367-hnsq8rt5gqvq62b8efqimi19a4njoadn.apps.googleusercontent.com&as=vnbl6uhVs7bAUqfnFvC88w&destination=http://localhost:8080&approval_state=!ChRMLXYwckVlOWNOTk5MVzg4d0ZSQRIfOHlnV0ZoclBTTkVhOERFdWhZOThQY19GWDhobTRoWQ%E2%88%99AJDr988AAAAAXb1UtM_kaYJw1H61YPl8T-NVLo3XDXcR&oauthgdpr=1&xsrfsig=ChkAeAh8T8p03bS9QECUk0GPP27TljO7CU_gEg5hcHByb3ZhbF9zdGF0ZRILZGVzdGluYXRpb24SBXNvYWN1Eg9vYXV0aHJpc2t5c2NvcGU')
          .then((response) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
      }).catchError((error) {
        print("Error: $error");
      });
    } catch (error) {
      print(error);
    }
    return "Начать чат";
  }

  @override
  Future initState() {
    super.initState();
    channel.stream.listen((message) {
      hartbeating(message);
      // handling of the incoming messages
    }, onError: (error, StackTrace stackTrace) {
      print(error);
      // error handling
    }, onDone: () {
      print("Сокет закрыт");
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
            drawer: drawerWidget(),
            appBar: appBar(),
            body: body()
          ),
        ),
        TransitionDot(animation: _submitAnimationController),
      ],
    );
  }

  Drawer drawerWidget() {
    return Drawer(
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
//              fetchPost();
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => LoginScreen3()));
            },
            child: _showList(
              "My Account",
              (Icons.account_box),
            ),
          ),
          InkWell(
            onTap: () {
              openAlertBox();
//                        Navigator.of(context)
//                            .push(MaterialPageRoute(builder: (context) => MyOrders()));
            },
            child: _showList(
              "My Orders",
              (Icons.shopping_basket),
            ),
          ),
          InkWell(
            onTap: () async {
              await auth.googleSignIn();
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
    );
  }

  AppBar appBar() {
    return AppBar(
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
    );
  }

  Container body() {
    return Container(
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

  openAlertBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Add Review",
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: Text(
                        "Rate Product",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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