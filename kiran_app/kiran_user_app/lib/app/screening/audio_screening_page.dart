import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/services/aws_lex_bot_service.dart';
import 'package:rive/rive.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

class AudioScreeningPage extends StatefulWidget {
  const AudioScreeningPage({Key? key, required this.animationCharacter})
      : super(key: key);
  final String animationCharacter;

  @override
  State<AudioScreeningPage> createState() => _AudioScreeningPageState();
}

class _AudioScreeningPageState extends State<AudioScreeningPage> {
  // speech to text
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String textOnScreen = "";
  double _confidence = 1.0;

  // text to speech
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> _speakText(String? text) async {
    if (text != null) {
      print("%%%$text");
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setPitch(1);
      await _flutterTts.speak(text);
    }
  }

  Future<void> _getMicPermissions() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
    }
  }

  Future<void> _listenToAudio() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (val.compareTo('notListening') == 0 ||
              val.compareTo("done") == 0) {
            setState(() {
              _isListening = false;
              messages.insert(0, userMessageReply(textOnScreen));
              _sendMessageToBot(textOnScreen);
            });
          }
        },
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
            onResult: (val) => setState(() {
                  textOnScreen = val.recognizedWords;
                  if (val.hasConfidenceRating && val.confidence > 0) {
                    _confidence = val.confidence;
                    print('Confidence: $_confidence');
                  }
                }));
      }
    } else {
      setState(() => _isListening = false);
      print("not listening");
      _speech.stop();
    }
  }

  List<types.Message> messages = [];
  final _user = const types.User(id: '1234556');
  final _bot = const types.User(id: "123");
  AWSLexBotService _botService = AWSLexBotService();

  types.Message botMessageReply(String message) {
    return types.TextMessage(
      author: _bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message,
    );
  }

  types.Message userMessageReply(String message) {
    return types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message,
    );
  }

  void _sendMessageToBot(String text) async {
    final _text = types.PartialText(text: text);
    final _message = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: _text.text,
    );
    print("*****${_message.toJson()["text"]}");
    // response from bot
    List<String> _botRes =
        await _botService.callBot(_message.toJson()["text"], 'userTwo');
    setState(() {
      _micDisabled = false;
    });
    for (var m in _botRes) {
      print("#####$m");
      setState(() {
        messages.insert(0, botMessageReply(m));
        textOnScreen = m;
      });
      await _speakText(m);
      await _flutterTts.awaitSpeakCompletion(true);
    }
  }

  @override
  void initState() {
    super.initState();
    _getMicPermissions();
    _speech = stt.SpeechToText();
    _sendMessageToBot("hello");
  }

  @override
  void dispose() {
    _speech.stop();
    _speech.cancel();
    super.dispose();
  }

  bool _micDisabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: RiveAnimation.asset(widget.animationCharacter)),
                  Positioned(
                    left: 8.0,
                    child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.close,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _micDisabled
                          ? LinearProgressIndicator(
                              color: kSecondaryColor,
                              backgroundColor: kPrimaryColor,
                            )
                          : Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text(
                                " " + textOnScreen + " ",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor:
                                        Colors.black.withOpacity(0.7)),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: kPrimaryColor,
        endRadius: 55.0,
        duration: const Duration(milliseconds: 300),
        repeat: true,
        repeatPauseDuration: const Duration(milliseconds: 300),
        child: FloatingActionButton(
          onPressed: _micDisabled ? null : _listenToAudio,
          child: _isListening ? Icon(Icons.mic) : Icon(Icons.mic_none),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
