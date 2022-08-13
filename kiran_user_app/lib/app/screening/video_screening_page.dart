import 'dart:collection';
import 'dart:typed_data';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/main.dart';
import 'package:rive/rive.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:tflite/tflite.dart';

class VideoScreeningPage extends StatefulWidget {
  const VideoScreeningPage({Key? key, required this.animationCharacter})
      : super(key: key);
  final String animationCharacter;

  @override
  State<VideoScreeningPage> createState() => _VideoScreeningPageState();
}

class _VideoScreeningPageState extends State<VideoScreeningPage> {
  late CameraController _cameraController;
  late stt.SpeechToText _speech;

  CameraImage? _cameraImage;
  String _predictionText = '';
  double _predictionConfidence = 0.0;

  bool _isListening = false;
  String _text = "Press the button and start speaking ";
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    this._loadModel();
    this._loadCameraStream();
  }

  @override
  void dispose() {
    _cameraController.dispose();
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
              // call the api or run tflite model
              _runEmotionDetectionModel();
            });
          });
        }
      }
    });
  }

  Future<void> _loadModel() async {
    await Tflite.loadModel(
      model: "assets/models/emotion_detection_model.tflite",
      labels: "assets/models/labels.txt",
    );
  }

  Future<void> _runEmotionDetectionModel() async {
    if (_cameraImage == null) {
      return;
    }
    try {
      var predictions = await Tflite.runModelOnFrame(
        bytesList: _cameraImage!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        numResults: 1,
        imageHeight: _cameraImage!.height,
        imageWidth: _cameraImage!.width,
      );
      predictions!.forEach((element) {
        if (this.mounted) {
          setState(() {
            _predictionText = element['label'];
            _predictionConfidence = element['confidence'];
          });
        }
      });
    } catch (e) {
      print(e.toString());
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
                      child: RiveAnimation.asset(widget.animationCharacter)),
                  Positioned(
                    left: 8.0,
                    child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.close,
                        )),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Result: $_predictionText",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Text(
                              "Confidence: $_predictionConfidence",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      )),
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
