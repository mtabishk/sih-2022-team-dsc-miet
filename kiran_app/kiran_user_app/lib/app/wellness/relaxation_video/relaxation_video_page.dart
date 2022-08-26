import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/common_widgets/custom_video_player.dart';
import 'package:kiran_user_app/app/constants.dart';

class RelaxationVideoPage extends StatelessWidget {
  RelaxationVideoPage({Key? key}) : super(key: key);
  final List<String> _listItems = [
    "Stress Relief",
    "Fall into deep sleep",
    "Use this video to stop a panic attack",
    "Meditation and relaxation",
  ];
  final List<String> _itemUrls = [
    "https://youtu.be/lFcSrYw-ARY",
    "https://youtu.be/IvdahN23rQ0",
    "https://youtu.be/vXZ5l7G6T2I",
    "https://youtu.be/tEmt1Znux58",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Relaxation Videos"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: kPrimaryColor.withOpacity(0.5),
          ),
          child: ListView.builder(
              // shrinkWrap: true,
              itemCount: _listItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_listItems[index]),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomVideoPlayer(
                          videoUrl: _itemUrls[index],
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
