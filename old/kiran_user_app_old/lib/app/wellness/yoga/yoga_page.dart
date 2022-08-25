import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/common_widgets/custom_video_player.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:pod_player/pod_player.dart';

class YogaPage extends StatelessWidget {
  YogaPage({Key? key}) : super(key: key);
  final List<String> _mentalDisorders = [
    "Stress",
    "Pranayama",
    "Eating disorder",
    "PCOD",
    "Depression and anxiety",
    "Panic Attack",
    "Bipolar",
  ];
  final List<String> _urls = [
    "https://youtu.be/l3zFJzV8O6o",
    "https://youtu.be/N2wR1OWhD4s",
    "https://youtu.be/zAJgsUl5tFQ",
    "https://youtu.be/H5WcAVifbZo",
    "https://youtu.be/Sxddnugwu-8",
    "https://youtu.be/QtG_bGD9DM4",
    "https://youtu.be/cSYK9uupvf4",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yoga"),
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
              itemCount: _mentalDisorders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_mentalDisorders[index]),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomVideoPlayer(
                          videoUrl: _urls[index],
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
