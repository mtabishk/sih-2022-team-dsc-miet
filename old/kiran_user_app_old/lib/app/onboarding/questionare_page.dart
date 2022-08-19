import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/constants.dart';

class QuestionarePage extends StatefulWidget {
  const QuestionarePage({Key? key}) : super(key: key);

  @override
  State<QuestionarePage> createState() => _QuestionarePageState();
}

class _QuestionarePageState extends State<QuestionarePage> {
  final _pageController = PageController();
  Map<String, int>? _questionareResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC3FDFD),
      body: Scrollbar(
        trackVisibility: true,
        showTrackOnHover: true,
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, position) {
            return _buildQuestionareBody(position: position);
          },
          itemCount: patientHealthQuestionare.length,
        ),
      ),
    );
  }

  Widget _buildQuestionareBody({required int position}) {
    // final _showOnBoarding =
    //     Provider.of<ShowOnboardingProvider>(context, listen: false);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Questionare",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          SizedBox(height: 32.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 3.0),
                      blurStyle: BlurStyle.outer,
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 64.0, 16.0, 64.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${position + 1}. ".toString() +
                              patientHealthQuestionare[position],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          )),
                      SizedBox(height: 32.0),
                      _buildOption(text: "a. Not at all", position: position),
                      SizedBox(height: 16.0),
                      _buildOption(text: "b. Several Days", position: position),
                      SizedBox(height: 16.0),
                      _buildOption(
                          text: "d. More than half the days",
                          position: position),
                      SizedBox(height: 16.0),
                      _buildOption(
                          text: "d. Nearly every day", position: position),
                    ]),
              ),
            ),
          ),
          SizedBox(height: 32.0),
          if (position < 8)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ImageIcon(AssetImage("assets/icons/swipe.png")),
                    SizedBox(height: 16.0),
                    Text("Swipe Up"),
                  ],
                ),
              ],
            ),
          if (position == 8)
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: SizedBox(
                width: double.infinity,
                height: 60.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    primary: Color(0xFF0ACDCF),
                  ),
                  onPressed: () {
                    //TODO: save the patientHealthQuestionare model to firebase database
                    print(_questionareResult);
                    // _showOnBoarding.changeQuestionareCompletedValue();
                    // int count = 0;
                    // Navigator.of(context).popUntil((_) => count++ >= 2);
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOption({required String text, required int position}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Material(
        child: InkWell(
          onTap: () {
            _pageController.nextPage(
                duration: Duration(milliseconds: 600),
                curve: Curves.easeInCubic);
            _questionareResult?[text] = position;
            print("tapped:" + position.toString());
          },
          child: Container(
            height: 44,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xFFC3FDFD).withOpacity(0.8),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(0.0, 1.0),
                    blurStyle: BlurStyle.outer,
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              child: Text(text,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
