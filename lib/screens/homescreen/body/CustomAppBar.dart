import 'package:bmi_calculator/input_page/ChatModel.dart' show ChatModel, model;
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ChatModel>(
        model: model,
        child: ScopedModelDescendant<ChatModel>(builder:
            (BuildContext inContext, Widget inChild, ChatModel inModel) {
          return Container();
        }));
  }
}
