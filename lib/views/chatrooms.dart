import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/helper/helperfunctions.dart';
import 'package:chat_app/helper/theme.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/chat.dart';
import 'package:chat_app/views/search.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data.documents[index].data['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myName, ""),
                    chatRoomId:
                        snapshot.data.documents[index].data["chatRoomId"],
                  );
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Chat App"),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Search()));
              },
              child: Icon(Icons.search)),
          GestureDetector(
            onTap: () {
              AuthService().signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: Container(
        child: chatRoomsList(),
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName, @required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(
                      chatRoomId: chatRoomId,
                    )));
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
            child: Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: CustomTheme.colorAccent,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(userName.substring(0, 1),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'OverpassRegular',
                          fontWeight: FontWeight.w300)),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(userName,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'OverpassRegular',
                        fontWeight: FontWeight.w300)),
                      
              ],
            ),
          ),
          Divider(color: Colors.grey,)
        ],
      ),
    );
  }
}
