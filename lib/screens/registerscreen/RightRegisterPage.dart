import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:flutter/material.dart';

class RightRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: SizeConfig.safeBlockVertical * 10,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.05), BlendMode.dstATop),
          image: AssetImage('assets/images/mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 10),
            child: Center(
              child: Icon(
                Icons.headset_mic,
                color: Colors.redAccent,
                size: SizeConfig.safeBlockVertical * 7,
              ),
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: SizeConfig.safeBlockHorizontal * 3,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: SizeConfig.safeBlockHorizontal * 90,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.redAccent,
                    width: SizeConfig.safeBlockVertical * 0.1,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Card(
              child: TextField(
                obscureText: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          Divider(
            height: SizeConfig.safeBlockVertical * 1,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "EMAIL",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: SizeConfig.safeBlockHorizontal * 3,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            width: SizeConfig.safeBlockHorizontal * 100,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.redAccent,
                    width: SizeConfig.safeBlockVertical * 0.1,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Card(
              child: TextField(
                obscureText: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'samarthagarwal@live.com',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          Divider(
            height: SizeConfig.safeBlockVertical * 1,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "PASSWORD",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: SizeConfig.safeBlockHorizontal * 3,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.redAccent,
                    width: SizeConfig.safeBlockVertical * 0.1,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Card(
              child: TextField(
                obscureText: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '*********',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          Divider(
            height: SizeConfig.safeBlockVertical * 1,
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    "CONFIRM PASSWORD",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: SizeConfig.safeBlockHorizontal * 3,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.redAccent, style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: Card(
              child: TextField(
                obscureText: true,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '*********',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          Divider(
            height: SizeConfig.safeBlockVertical * 1,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: new FlatButton(
                  child: new Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                      fontSize: SizeConfig.safeBlockHorizontal * 3,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  onPressed: () => {},
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(
                          SizeConfig.safeBlockVertical * 10),
                    ),
                    color: Colors.redAccent,
                    onPressed: () => {},
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
