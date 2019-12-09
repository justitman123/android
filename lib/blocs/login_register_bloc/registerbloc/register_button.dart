import 'package:bmi_calculator/input_page/size/SizeConfig.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  RegisterButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: SizeConfig.safeBlockVertical * 5,
          right: SizeConfig.safeBlockVertical * 5,
          top: SizeConfig.safeBlockVertical * 8),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius:
              new BorderRadius.circular(SizeConfig.safeBlockVertical * 10),
        ),
        color: Colors.redAccent,
        onPressed: () async {
          _onPressed;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20.0,
          ),
          child: Center(
            child: Text(
              "SIGN UP",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
