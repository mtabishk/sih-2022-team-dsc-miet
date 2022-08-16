import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/services/aws_lex_bot_service.dart';
import 'package:uuid/uuid.dart';

class ChatScreeningPage extends StatefulWidget {
  const ChatScreeningPage({Key? key}) : super(key: key);

  @override
  _ChatScreeningPageState createState() => _ChatScreeningPageState();
}

class _ChatScreeningPageState extends State<ChatScreeningPage> {
  List<types.Message> messages = [];
  final _user = const types.User(id: '1234556');
  final _bot = const types.User(id: "123");
  //id of bot and user doesn't matter here as we have only pair interaction

  AWSLexBotService _botService = AWSLexBotService();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) async {
    setState(() {
      messages.insert(0, message);
    });
    log("${message.toJson()["text"]}");
    List<String> _botRes = await _botService.callBot(message.toJson()["text"]);
    for (var m in _botRes) {
      setState(() {
        messages.insert(0, botMessageReply(m));
      });
      log("#####$m}");
    }
  }

  void _sendInitialMessage(types.Message message) async {
    log("${message.toJson()["text"]}");
    List<String> _botRes = await _botService.callBot(message.toJson()["text"]);
    for (var m in _botRes) {
      setState(() {
        messages.insert(0, botMessageReply(m));
      });
      log("#####$m}");
    }
  }

  types.Message botMessageReply(String message) {
    return types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message,
    );
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    _addMessage(textMessage);
  }

  void _loadMessages() async {
    // List<types.Message> messagesList = [];
    final _initialText = types.PartialText(text: "hello");
    final _msg = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: _initialText.text,
    );
    _sendInitialMessage(_msg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Chat Screening"),
      ),
      body: Chat(
        messages: messages,
        showUserNames: true,
        onSendPressed: _handleSendPressed,
        user: _user,
        theme: DefaultChatTheme(
          primaryColor: kPrimaryColor,
        ),
      ),
    );
  }
}
