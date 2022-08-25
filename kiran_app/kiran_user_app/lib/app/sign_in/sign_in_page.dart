import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/common_widgets/custom_exception_alert_dialog.dart';
import 'package:kiran_user_app/app/home/home_page.dart';
import 'package:kiran_user_app/app/screening/choose_character_page.dart';
import 'package:kiran_user_app/models/user_info_model.dart';
import 'package:kiran_user_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  /// Check If Document Exists
  Future<bool> checkIfDocExists(String docId) async {
    try {
      //Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection('users');
      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  Future<void> _signInWithGoogle(BuildContext context, AuthBase auth) async {
    try {
      await auth.signInWithGoogle();
      bool docExists = await checkIfDocExists(auth.currentuser?.uid as String);
      if (!docExists) {
        String uid = auth.currentuser?.uid as String;
        final reference = FirebaseFirestore.instance.doc('users/$uid');
        await reference.set(UserInfoModel(
          email: auth.currentuser?.email as String,
          displayName: auth.currentuser?.displayName ?? '',
          age: '',
          gender: '',
          emergencyContact: '',
          animationCharacter: '',
          locationLat: '',
          locationLng: '',
        ).toMap());
      }
    } on Exception catch (e) {
      if (this.mounted) {
        _showSignInError(context, e);
      }

      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Stack(children: [
        Container(
          height: _height * 0.8,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              )),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(-_width * 0.1, -_width * 1.1),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFC3FDFD).withOpacity(0.8),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(
              _width * 0.6,
              -_width * 0.7,
            ),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFC3FDFD).withOpacity(0.8),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: _height / 2.3,
          left: _width / 8,
          right: _width / 8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: _width * 0.9,
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF0ACDCF),
                  ),
                  onPressed: () async {
                    await _signInWithGoogle(context, auth);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          height: 28.0,
                          width: 28.0,
                          child: Image.asset("assets/icons/google.png")),
                      Text(
                        "Sign in with Google",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Opacity(
                          opacity: 0.0,
                          child:
                              ImageIcon(AssetImage("assets/icons/email.png"))),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              SizedBox(
                width: _width * 0.9,
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF0ACDCF),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => HomePage(),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ImageIcon(AssetImage("assets/icons/email.png")),
                      Text(
                        "Sign in with Email",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Opacity(
                          opacity: 0.0,
                          child:
                              ImageIcon(AssetImage("assets/icons/email.png"))),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              SizedBox(
                width: _width * 0.9,
                height: 50.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF0ACDCF),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => HomePage(),
                        ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ImageIcon(AssetImage("assets/icons/phone-icon.png")),
                      Text(
                        "Sign in with Phone",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Opacity(
                          opacity: 0.0,
                          child:
                              ImageIcon(AssetImage("assets/icons/email.png"))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(
      context,
      title: 'Sign In Failed',
      exception: exception,
    );
  }
}
