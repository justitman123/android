import 'package:bmi_calculator/input_page/choose.dart';
import 'package:bmi_calculator/input_page/pacman_slider.dart';
import 'package:bmi_calculator/input_page/responsive_screen.dart';
import 'package:bmi_calculator/input_page/transition_dot.dart';
import 'package:bmi_calculator/input_page/utils.dart';
import 'package:bmi_calculator/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class InputPage extends StatefulWidget {
  @override
  InputPageState createState() {
    return new InputPageState();
  }
}

class InputPageState extends State<InputPage> with TickerProviderStateMixin {
  final WebSocketChannel channel = IOWebSocketChannel.connect(
    Uri(scheme: "ws", host: "192.168.99.100", port: 8080, path: "/socket"),
  );
  Screen size;
  AnimationController _submitAnimationController;
  int height = 180;
  int weight = 70;

  @override
  void initState() {
    super.initState();
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
                _buildBottom(context),
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
