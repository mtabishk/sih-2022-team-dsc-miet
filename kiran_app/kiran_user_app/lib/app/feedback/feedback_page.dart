import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/models/feedback_model.dart';
import 'package:kiran_user_app/services/auth_service.dart';
import 'package:kiran_user_app/services/firestore_service.dart';
import 'package:provider/provider.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({
    Key? key,
    required this.database,
  }) : super(key: key);
  final Database database;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final _feedbackController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: _feedbackController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Feedback',
                labelStyle: TextStyle(color: kPrimaryColor),
                focusColor: kPrimaryColor,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
              maxLength: 200,
              maxLines: 10,
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                final uid = auth.currentuser?.uid.toString();
                if (uid != null) {
                  final feedback = FeedbackModel(
                    uid: uid,
                    data: _feedbackController.text,
                  );
                  await database.submitFeedbackData(feedback);
                  _feedbackController.clear();
                  await showFeedbackDialog(
                    context,
                    title: "Feedback",
                    content: "Thank you for your feedback",
                  );
                  Navigator.of(context).pop();
                } else {
                  await showFeedbackDialog(
                    context,
                    title: "Feedback",
                    content:
                        "Sorry your feedback is not submitted. Try again later",
                  );
                }
              },
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[700],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 10.0),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future showFeedbackDialog(
  BuildContext context, {
  required String title,
  required String content,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10.0),
          SizedBox(
              height: 100.0, child: Image.asset("assets/images/icon-tick.png")),
          SizedBox(height: 20.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 10.0),
          Text(content),
        ],
      ),
    ),
  );
}
