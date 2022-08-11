import 'package:flutter/material.dart';

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
      body: ListView.builder(
          itemCount: _mentalDisorders.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(_mentalDisorders[index]),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => YoutubePlayer(
                  //       controller: YoutubePlayerController(
                  //         initialVideoId: _urls[index],
                  //         flags: YoutubePlayerFlags(
                  //           autoPlay: true,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // );
                },
              ),
            );
          }),
    );
  }
}
