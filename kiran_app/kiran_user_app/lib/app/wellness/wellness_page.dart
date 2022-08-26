import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/app/other_services/service_page.dart';
import 'package:kiran_user_app/app/wellness/relaxation_music/relaxation_music_page.dart';
import 'package:kiran_user_app/app/wellness/relaxation_video/relaxation_video_page.dart';
import 'package:kiran_user_app/app/wellness/wellness_goals/wellness_goals_page.dart';
import 'package:kiran_user_app/app/wellness/yoga/yoga_page.dart';

class WellnessPage extends StatelessWidget {
  WellnessPage({Key? key}) : super(key: key);

  final List<String> _listItems = [
    "Wellness Goals",
    "Relaxation Music",
    "Relaxation Videos",
    "Yoga"
  ];

  final List<Widget> _listItemPages = [
    WellnessGoalsPage(),
    RelaxationMusicPage(),
    RelaxationVideoPage(),
    YogaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Wellness")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kPrimaryColor.withOpacity(0.5),
            ),
            child: ListView.separated(
              //shrinkWrap: true,
              itemCount: _listItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _listItems[index],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => _listItemPages[index]));
                  },
                );
              },
              separatorBuilder: ((context, index) {
                return Divider();
              }),
            ),
          ),
        ),
      ),
    );
  }
}
