import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "package:the_gorgeous_login/utils/Model.dart" show ChatModel, model;

class Home extends StatelessWidget {

  Widget build(final BuildContext inContext) {
    return ScopedModel<ChatModel>(model : model, child : ScopedModelDescendant<ChatModel>(
      builder : (BuildContext inContext, Widget inChild, ChatModel inModel) {
        return Scaffold(
          appBar : AppBar(title : Text("FlutterChat")),
//          drawer : AppDrawer(),
          body : Center(child : Text("sfdsfsdf"))
        );
      }
    ));
  } /* End build(). */
} /* End class. */