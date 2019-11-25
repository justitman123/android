import "dart:io";

import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:scoped_model/scoped_model.dart';

class ChatModel extends Model {
  bool conversationalistFemaleGenderOn = false;

  bool conversationalistMaleGenderOn = false;

  bool myFemaleGenderOn = false;

  bool myMaleGenderOn = false;

  void setConversationalistFemaleGenderOn(final bool inEnabled) {
    conversationalistFemaleGenderOn = inEnabled;
    notifyListeners();
  }

  void setConversationalistMaleGenderOn(final bool inEnabled) {
    conversationalistMaleGenderOn = inEnabled;
    notifyListeners();
  }

  void setMyMaleGenderOn(final bool inEnabled) {
    myMaleGenderOn = inEnabled;
    notifyListeners();
  }

  void setMyFemaleGenderOn(final bool inEnabled) {
    myFemaleGenderOn = inEnabled;
    notifyListeners();
  }

















  bool myBelow16 = false;

  bool myFrom17To19 = false;

  bool myFrom20To24 = false;

  bool myFrom25To29 = false;

  bool myFrom30To36 = false;

  bool myMoreThen37 = false;

  void setMyBelow16(final bool inEnabled) {
    myBelow16 = inEnabled;
    notifyListeners();
  }

  void setMyFrom17To19(final bool inEnabled) {
    myFrom17To19 = inEnabled;
    notifyListeners();
  }

  void setMyFrom20To24(final bool inEnabled) {
    myFrom20To24 = inEnabled;
    notifyListeners();
  }

  void setMyFrom25To29(final bool inEnabled) {
    myFrom25To29 = inEnabled;
    notifyListeners();
  }

  void setMyFrom30To36(final bool inEnabled) {
    myFrom30To36 = inEnabled;
    notifyListeners();
  }

  void setMyMoreThen37(final bool inEnabled) {
    myMoreThen37 = inEnabled;
    notifyListeners();
  }





  bool conversationalistBelow16 = false;

  bool conversationalistFrom17To19 = false;

  bool conversationalistFrom20To24 = false;

  bool conversationalistFrom25To29 = false;

  bool conversationalistFrom30To36 = false;

  bool conversationalistMoreThen37 = false;

  void setConversationalistBelow16(final bool inEnabled) {
    conversationalistBelow16= inEnabled;
    notifyListeners();
  }

  void setConversationalistFrom17To19(final bool inEnabled) {
    conversationalistFrom17To19 = inEnabled;
    notifyListeners();
  }

  void setConversationalistFrom20To24(final bool inEnabled) {
    conversationalistFrom20To24 = inEnabled;
    notifyListeners();
  }

  void setConversationalistFrom25To29(final bool inEnabled) {
    conversationalistFrom25To29 = inEnabled;
    notifyListeners();
  }

  void setConversationalistFrom30To36(final bool inEnabled) {
    conversationalistFrom30To36 = inEnabled;
    notifyListeners();
  }

  void setConversationalistMoreThen37(final bool inEnabled) {
    conversationalistMoreThen37 = inEnabled;
    notifyListeners();
  }






  String name;

  String photoUrl;

  bool isLoggedIn;

  String accessToken;

  void setName (String name) {
    this.name = name;
    notifyListeners();
  }

  void setPhotoUrl(String photoUrl) {
    this.photoUrl = photoUrl;
    notifyListeners();
  }

  void setLoggedIn(final bool isLoggedIn) {
    this.isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  void setAccessToken(final String accessToken) {
    this.accessToken = accessToken;
    notifyListeners();
  }















  /// The app's root widget build context.    Needed in a number of spots, so makes sense for it to be "global" even
  /// though it's not "state" per se (that's why we use the default setter: no need to call notifyListeners(), so
  /// no need for a explicit setter.
  BuildContext rootBuildContext;

  /// The app's documents directory.  Needed in a number of spots, so makes sense for it to be "global" even
  /// though it's not "state" per se (that's why we use the default setter: no need to call notifyListeners(), so
  /// no need for a explicit setter.
  Directory docsDir;

  /// The greeting to show on the home screen.
  String greeting = "";

  /// The userName of the logged in user.
  String userName = "";

  // The default text to show when not in a room.
  // ignore: non_constant_identifier_names
  static final String DEFAULT_ROOM_NAME = "Not currently in a room";

  /// The name of the room the user is currently in, if any.
  String currentRoomName = DEFAULT_ROOM_NAME;

  /// The list of users in the current room.
  List currentRoomUserList = [];

  /// Is the Current Room option in the drawer enabled? (only when in a room)
  bool currentRoomEnabled = false;

  /// The list of messages in the current room (not a complete list, just since the user joined it).  Each element
  /// is an Map in the form { userName : "", message : "" }.
  List currentRoomMessages = [];

  /// The list of rooms currently on the server.
  List roomList = [];

  /// The list of users currently on the server.
  List userList = [];

  /// Whether the creator functions on the room screen are enabled.
  bool creatorFunctionsEnabled = false;

  /// A map of rooms the user has been invited to.  Simple map of room names to boolean true.
  Map roomInvites = {};

  /// Set the greeting to show on the home screen.
  ///
  /// @param inGreeting The greeting.  Cannot be null.
  void setGreeting(final String inGreeting) {
    print("## FlutterChatModel.setGreeting(): inGreeting = $inGreeting");

    greeting = inGreeting;
    notifyListeners();
  }

  /* End setGreeting(). */

  /// Set the userName of the logged in user.
  ///
  /// @param inUserName The userName.  Cannot be null.
  void setUserName(final String inUserName) {
    print("## FlutterChatModel.setUserName(): inUserName = $inUserName");

    userName = inUserName;
    notifyListeners();
  }

  /* End setUserName(). */

  /// Set the name of the room the user is currently in.
  ///
  /// @param inRoomName The name of the room (blank string if no current room).  Cannot be null.
  void setCurrentRoomName(final String inRoomName) {
    print("## FlutterChatModel.setCurrentRoomName(): inRoomName = $inRoomName");

    currentRoomName = inRoomName;
    notifyListeners();
  }

  /* End setCurrentRoomName(). */

  /// Set the enabled status of the creator functions on the room screen.
  ///
  /// @param inRoomName The name of the room (blank string if no current room).  Cannot be null.
  void setCreatorFunctionsEnabled(final bool inEnabled) {
    print(
        "## FlutterChatModel.setCreatorFunctionsEnabled(): inEnabled = $inEnabled");

    creatorFunctionsEnabled = inEnabled;
    notifyListeners();
  }

  /* End setCreatorFunctionsEnabled(). */

  /// Set the enabled status of the Current Room drawer option.
  ///
  /// @param inRoomName The name of the room (blank string if no current room).  Cannot be null.
  void setCurrentRoomEnabled(final bool inEnabled) {
    print(
        "## FlutterChatModel.setCurrentRoomEnabled(): inEnabled = $inEnabled");

    currentRoomEnabled = inEnabled;
    notifyListeners();
  }

  /* End setCurrentRoomEnabled(). */

  /// Add a message to the list of messages in the room.
  ///
  /// @param inUsername The name of the user that posted the message.
  /// @param inMessage  The message.
  void addMessage(final String inUserName, final String inMessage) {
    print(
        "## FlutterChatModel.addMessage(): inUserName = $inUserName, inMessage = $inMessage");

    currentRoomMessages.add({"userName": inUserName, "message": inMessage});
    notifyListeners();
  }

  /* End addMessage(). */

  /// Set the list of rooms currently on the server.
  ///
  /// @param inRooms The map of room descriptor objects from the server.
  void setRoomList(final Map inRoomList) {
    print("## FlutterChatModel.setRoomList(): inRoomList = $inRoomList");

    List rooms = [];
    for (String roomName in inRoomList.keys) {
      Map room = inRoomList[roomName];
      rooms.add(room);
    }
    roomList = rooms;
    notifyListeners();
  }

  /* End setRoomList(). */

  /// Set the list of users currently on the server.
  ///
  /// @param inUsers The map of user descriptor objects from the server.
  void setUserList(final Map inUserList) {
    print("## FlutterChatModel.setUserList(): inUserList = $inUserList");

    List users = [];
    for (String userName in inUserList.keys) {
      Map user = inUserList[userName];
      users.add(user);
    }
    userList = users;
    notifyListeners();
  }

  /* End setUserList(). */

  /// Set the list of users in the room the user is currently in.
  ///
  /// @param inUserList The list of users currently in the room.
  void setCurrentRoomUserList(final Map inUserList) {
    print(
        "## FlutterChatModel.setCurrentRoomUserList(): inUserList = $inUserList");

    List users = [];
    for (String userName in inUserList.keys) {
      Map user = inUserList[userName];
      users.add(user);
    }
    currentRoomUserList = users;
    notifyListeners();
  }

  /* End setCurrentRoomUserList(). */

  /// Add an invite for a room.
  ///
  /// @param inRoomName The name of the room to add an invite for.
  void addRoomInvite(final String inRoomName) {
    print("## FlutterChatModel.addRoomInvite(): inRoomName = $inRoomName");

    roomInvites[inRoomName] = true;
  }

  /* End addRoomInvite(). */

  /// Remove an invite for a room.
  ///
  /// @param inRoomName The name of the room to remove an invite for.
  void removeRoomInvite(final String inRoomName) {
    print("## FlutterChatModel.removeRoomInvite(): inRoomName = $inRoomName");

    roomInvites.remove(inRoomName);
  }

  /* End removeRoomInvite(). */

  /// Clear all the messages for the current room.
  void clearCurrentRoomMessages() {
    print("## FlutterChatModel.clearCurrentRoomMessages()");

    currentRoomMessages = [];
  }
/* End clearCurrentRoomMessages(). */

} /* End class. */

// The one and only instance of this model.
ChatModel model = ChatModel();
