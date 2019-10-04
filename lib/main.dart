import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import 'package:the_gorgeous_login/ui/Home.dart';
import "package:the_gorgeous_login/utils/Model.dart" show ChatModel, model;

void main() {
  final storage = new FlutterSecureStorage();

  startApp() async {
    var read = await storage.read(key: "token");
    print(read);

    runApp(Chat());
  }

  startApp();
}

class Chat extends StatelessWidget {

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(home : Scaffold(body : ChatMain()));
  }
}/* End class. */

class ChatMain extends StatelessWidget {

  @override
  Widget build(final BuildContext inContext) {

    model.rootBuildContext = inContext;

    return ScopedModel<ChatModel>(model : model, child : ScopedModelDescendant<ChatModel>(
        builder : (BuildContext inContext, Widget inChild, ChatModel inModel) {
          return MaterialApp(initialRoute : "/",
              routes : {
//                "/Lobby" : (screenContext) => Lobby(),
//                "/Room" : (screenContext) => Room(),
//                "/UserList" : (screenContext) => UserList(),
//                "/CreateRoom" : (screenContext) => CreateRoom()
              },
              home : Home()
          );
        }
    ));
  } /* End build(). */
} /* End class. */