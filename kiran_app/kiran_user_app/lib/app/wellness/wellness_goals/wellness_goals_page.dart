import 'package:flutter/material.dart';

class WellnessGoalsPage extends StatelessWidget {
  const WellnessGoalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Wellness Goals"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: _height / 4,
                    child: Image.asset("assets/images/meditation.png")),
                SizedBox(
                    height: _height / 4,
                    child: Image.asset("assets/images/exercise.png")),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: _height / 4,
                    child: Image.asset("assets/images/glasses.png")),
                SizedBox(
                    height: _height / 4,
                    child: Image.asset("assets/images/calorie_count.png")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
