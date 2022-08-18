import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/services/aws_lex_bot_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:kiran_user_app/main.dart';
import 'package:rive/rive.dart';
import 'package:uuid/uuid.dart';

class VidScreen extends StatefulWidget {
  const VidScreen({Key? key, required this.animationCharacter})
      : super(key: key);
  final String animationCharacter;

  @override
  State<VidScreen> createState() => _VidScreenState();
}

class _VidScreenState extends State<VidScreen> {
  // camera and video
  late CameraController _cameraController;
  CameraImage? _cameraImage;

  // speech to text
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String textOnScreen = "";
  double _confidence = 1.0;

  // text to speech
  late FlutterTts _flutterTts;

  Future<void> _loadCameraStream() async {
    _cameraController = CameraController(cameras![1], ResolutionPreset.low);
    _cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        if (this.mounted) {
          setState(() {
            _cameraController.startImageStream((image) {
              _cameraImage = image;
              //TODO: call the api or run tflite model
              //_runEmotionDetectionModel();
            });
          });
        }
      }
    });
  }

  Future<void> _speakText(String? text) async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setPitch(1);
    if (text != null) {
      print("%%%$text");
      await _flutterTts.awaitSpeakCompletion(true);
      await _flutterTts.speak(text);
    }
  }

  Future<void> _getMicPermissions() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
    }
  }

  Future<void> _getEngines() async {
    var engines = await _flutterTts.getEngines;
    if (engines != null) {
      for (dynamic engine in engines) {
        print(engine);
      }
    }
  }

  Future<void> _initFlutterTTS() async {
    _flutterTts = FlutterTts();
    if (Platform.isAndroid) {
      _getEngines();
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
        await _botService.callBot(_message.toJson()["text"], 'userThree');
    setState(() {
      _micDisabled = false;
    });
    for (var m in _botRes) {
      print("#####$m");
      await _speakText(m);
      setState(() {
        messages.insert(0, botMessageReply(m));
        textOnScreen = m;
      });
    }
  }

  String _predictionText = '';
  double _predictionConfidence = 0.0;

  @override
  void initState() {
    super.initState();
    this._loadCameraStream();
    _getMicPermissions();
    _speech = stt.SpeechToText();
    _initFlutterTTS();
    _sendMessageToBot("hello");
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _speech.stop();
    _speech.cancel();
    _flutterTts.stop();
    super.dispose();
  }

  bool _micDisabled = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: SizedBox(
                  height: size.height * 0.35,
                  child: RiveAnimation.asset(widget.animationCharacter))),
          if (_micDisabled)
            LinearProgressIndicator(
              color: kSecondaryColor,
              backgroundColor: kPrimaryColor,
            ),
          Expanded(
            flex: 2,
            child: Container(
                padding: const EdgeInsets.all(18.0),
                child: _micDisabled
                    ? Text("")
                    : Text(
                        " " + textOnScreen + " ",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.black.withOpacity(0.7)),
                      )),
          ),
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: Builder(builder: (context) {
            if (!_cameraController.value.isInitialized) {
              return Container();
            }
            return SizedBox(
              height: size.width * 0.7,
              width: size.width * 0.4,
              child: AspectRatio(
                  aspectRatio: _cameraController.value.aspectRatio,
                  child: CameraPreview(_cameraController)),
            );
          }),
        ),
        SizedBox(
          height: 10,
        ),
        AvatarGlow(
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
      ]),
    );
  }
}
