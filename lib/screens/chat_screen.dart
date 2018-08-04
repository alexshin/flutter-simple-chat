import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new ChatScreenState();
  }
}


class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {

  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _chatMessages = <ChatMessage>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text('FriendlyChat App')),
      body: new Column(
        children: <Widget>[
          new Flexible(child: _buildMessagesList()),
          new Divider(height: 1.0,),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor
            ),
            child: _buildTextComposer(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (ChatMessage msg in _chatMessages) {
      msg.animationController.dispose();
    }
    super.dispose();
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child: new Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: new Row(
              children: <Widget>[
                new Flexible(
                    child: new TextField(
                      controller: _textController,
                      decoration: new InputDecoration.collapsed(hintText: 'Send a message'),
                    )
                ),

                new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 4.0),
                  child: new IconButton(
                      icon: new Icon(Icons.send),
                      onPressed: () => _handleSubmitted(_textController.text)
                  ),
                )
              ],
            )
        )
    );
  }

  Widget _buildMessagesList() {
    return new ListView.builder(
      padding: new EdgeInsets.all(8.0),
      reverse: true,
      itemBuilder: (_, int index) => _chatMessages[index],
      itemCount: _chatMessages.length,
    );
  }


  void _handleSubmitted(String text) {

    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
          vsync: this,
          duration: new Duration(milliseconds: 700)
      ),
    );

    setState(() {
      _chatMessages.insert(0, message);
    });

    message.animationController.forward();
    _textController.clear();
  }

}


class ChatMessage extends StatelessWidget {

  final String text;
  final String _name = 'My name';
  final AnimationController animationController;

  ChatMessage({this.text, this.animationController});

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: _buildMessageRow(context),
    );
  }

  Widget _buildMessageRow(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(child: new Text(_name[0]),),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_name, style: Theme.of(context).textTheme.subhead,),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(text),
              )
            ],
          )
        ],
      ),
    );
  }

}