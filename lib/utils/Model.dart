import "dart:io";

import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

class ChatModel extends Model {
  BuildContext rootBuildContext;

  Directory docsDir;

  String greeting = "";

  String userName = "";

  static final String DEFAULT_ROOM_NAME = "Not currently in a room";

  String currentRoomName = DEFAULT_ROOM_NAME;

  List currentRoomUserList = [];

  bool currentRoomEnabled = false;

  List currentRoomMessages = [];

  List roomList = [];

  List userList = [];

  bool creatorFunctionsEnabled = false;

  Map roomInvites = {};

  void setGreeting(final String inGreeting) {
    greeting = inGreeting;
    notifyListeners();
  }

  /* End setGreeting(). */

  void setUserName(final String inUserName) {
    userName = inUserName;
    notifyListeners();
  }

  /* End setUserName(). */

  void setCurrentRoomName(final String inRoomName) {
    currentRoomName = inRoomName;
    notifyListeners();
  }

  /* End setCurrentRoomName(). */

  void setCreatorFunctionsEnabled(final bool inEnabled) {
    creatorFunctionsEnabled = inEnabled;
    notifyListeners();
  }

  /* End setCreatorFunctionsEnabled(). */

  void setCurrentRoomEnabled(final bool inEnabled) {
    currentRoomEnabled = inEnabled;
    notifyListeners();
  }

  /* End setCurrentRoomEnabled(). */

  void addMessage(final String inUserName, final String inMessage) {
    currentRoomMessages.add({"userName": inUserName, "message": inMessage});
    notifyListeners();
  }

  /* End addMessage(). */

  void setRoomList(final Map inRoomList) {
    List rooms = [];
    for (String roomName in inRoomList.keys) {
      Map room = inRoomList[roomName];
      rooms.add(room);
    }
    roomList = rooms;
    notifyListeners();
  }

  /* End setRoomList(). */

  void setUserList(final Map inUserList) {
    List users = [];
    for (String userName in inUserList.keys) {
      Map user = inUserList[userName];
      users.add(user);
    }
    userList = users;
    notifyListeners();
  }

  /* End setUserList(). */

  void setCurrentRoomUserList(final Map inUserList) {
    List users = [];
    for (String userName in inUserList.keys) {
      Map user = inUserList[userName];
      users.add(user);
    }
    currentRoomUserList = users;
    notifyListeners();
  }

  /* End setCurrentRoomUserList(). */

  void addRoomInvite(final String inRoomName) {
    roomInvites[inRoomName] = true;
  }

  /* End addRoomInvite(). */

  void removeRoomInvite(final String inRoomName) {
    roomInvites.remove(inRoomName);
  }

  /* End removeRoomInvite(). */

  void clearCurrentRoomMessages() {
    currentRoomMessages = [];
  }
/* End clearCurrentRoomMessages(). */
} /* End class. */

ChatModel model = ChatModel();
