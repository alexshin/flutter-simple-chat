import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'screens/chat_screen.dart';
import 'themes_settings.dart';

class FriendlyChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Friendly Chat',
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme: kDefaultTheme,
      home: ChatScreen()
    );
  }

}