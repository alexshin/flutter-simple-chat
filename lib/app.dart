import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';

class FriendlyChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Friendly Chat',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen()
    );
  }

}