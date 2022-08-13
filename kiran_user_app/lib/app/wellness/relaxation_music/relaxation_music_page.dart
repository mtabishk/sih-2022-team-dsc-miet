import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/common_widgets/custom_video_player.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:pod_player/pod_player.dart';

class RelaxationMusicPage extends StatelessWidget {
  RelaxationMusicPage({Key? key}) : super(key: key);
  final List<String> _listItems = [
    "Autism Calming Music",
    "Stress Anxiety Calming Music",
    "Concentration Music",
    "Sleep Music",
    "Calming Music",
  ];
  final List<String> _itemUrls = [
    "https://youtu.be/DlnYANIVslc",
    "https://youtu.be/lFcSrYw-ARY",
    "https://youtu.be/KaSFoOF6Yw0",
    "https://youtu.be/o8GrqUSdzi0",
    "https://youtu.be/nDqP7kcr-sc",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yoga"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
