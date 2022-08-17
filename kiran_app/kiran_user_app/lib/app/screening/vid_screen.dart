import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:kiran_user_app/main.dart';
import 'package:rive/rive.dart';

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

  bool _micDisabled = true;
  String textOnScreen = "Welcome" * 20;

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
              //_runEmotionDetectionModel();
            });
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this._loadCameraStream();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

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
          LinearProgressIndicator(),
          Expanded(
            flex: 2,
            child: Container(
                padding: const EdgeInsets.all(18.0),
                child: Text(
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
        FloatingActionButton(
          child: Icon(Icons.delete),
          onPressed: () {
            //...
          },
          heroTag: null,
        ),
      ]),
    );
  }
}
