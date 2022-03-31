import 'package:avatar_glow/avatar_glow.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/main.dart';
import 'package:rive/rive.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;

class VideoScreeningPage extends StatefulWidget {
  const VideoScreeningPage({Key? key}) : super(key: key);

  @override
  State<VideoScreeningPage> createState() => _VideoScreeningPageState();
}

class _VideoScreeningPageState extends State<VideoScreeningPage> {
  late CameraController controller;

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "Press the button and start speaking ";
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    controller = CameraController(cameras![1], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _listenToAudio() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
            onResult: (val) => setState(() {
                  _text = val.recognizedWords;
                  if (val.hasConfidenceRating && val.confidence > 0) {
                    _confidence = val.confidence;
                    print('Confidence: $_confidence');
                  }
                }));
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TODO: show Doctor animation here
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: RiveAnimation.asset(
                          'assets/animations/flutter-puzzle.riv')),
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
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: size.width * 0.8,
                    width: size.width,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      child: Builder(builder: (context) {
                        if (!controller.value.isInitialized) {
                          return Container();
                        }
                        return SizedBox(
                          height: size.width * 0.8,
                          width: size.width * 0.45,
                          child: AspectRatio(
                              aspectRatio: controller.value.aspectRatio,
                              child: CameraPreview(controller)),
                        );
                      }),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    child: Container(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          " " + _text + " ",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.black.withOpacity(0.7)),
                        )),
                  ),
                ],
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
          onPressed: _listenToAudio,
          child: _isListening ? Icon(Icons.mic) : Icon(Icons.mic_none),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
