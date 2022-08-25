import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/common_widgets/custom_exception_alert_dialog.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/models/user_info_model.dart';
import 'package:kiran_user_app/services/auth_service.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'dart:async';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class PhoneSignInPage extends StatefulWidget {
  const PhoneSignInPage({Key? key}) : super(key: key);
  @override
  _PhoneSignInPageState createState() => _PhoneSignInPageState();
}

class _PhoneSignInPageState extends State<PhoneSignInPage> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

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

  Future<void> _signInWithPhoneNumber(
      BuildContext context, String contactNumber) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);

      await auth.signInwithPhoneNumber(verificationId, otp, context);
      print(auth.currentuser?.uid);
      bool docExists = await checkIfDocExists(auth.currentuser?.uid as String);
      if (!docExists) {
        String uid = auth.currentuser?.uid as String;
        final reference = FirebaseFirestore.instance.doc('users/$uid');
        await reference.set(UserInfoModel(
          email: '',
          displayName: '',
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

  int start = 30;
  bool wait = true;
  bool _loading = false;
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();
  String? phoneNumber;
  String otp = "";
  String verificationId = "";
  String contact = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
              ? PhoneNumberState()
              : OTPPage(),
        ),
      ),
    );
  }

  Widget PhoneNumberState() {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return _loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/kiran-logo.png'),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Enter your Mobile Number",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black54),
                    ),
                    SizedBox(height: 30),
                    Form(
                      key: _phoneFormKey,
                      child: TextFormField(
                        maxLength: 10,
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return "Phone is required";
                            }
                            if (value.length != 10) {
                              return "Enter a mobile number of 10 digits";
                            }
                            if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                              return 'Please enter a valid Mobile Number';
                            }
                            return null;
                          }
                        },
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.0,
                          color: Colors.black54,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 14,
                            height: 0.3,
                            letterSpacing: 0.0,
                          ),
                          hintText: "Enter the Phone Number",
                          hintStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.0,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 15),
                            child: Text(
                              " (+91) ",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        autocorrect: false,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: false, decimal: false),
                        autofocus: false,
                        onSaved: (value) => phoneNumber = value,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_phoneFormKey.currentState != null) {
                            if (_phoneFormKey.currentState!.validate()) {
                              _phoneFormKey.currentState?.save();
                              if (this.mounted) {
                                setState(() {
                                  _loading = true;
                                });
                              }
                              contact = "+91 " + phoneNumber.toString();
                              await auth.verifyPhoneNumber(
                                  contact, context, setData);
                              if (this.mounted) {
                                setState(() {
                                  currentState = MobileVerificationState
                                      .SHOW_OTP_FORM_STATE;
                                });
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                        ),
                        child: Text("SUBMIT"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
              ],
            ),
          );
  }

  Widget OTPPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons/kiran-logo.png"),
            ],
          ),
          SizedBox(height: 30),
          Text(
            "Phone Number Verification",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
          ),
          SizedBox(height: 40),
          Text(
            "Sending OTP to",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "   (+91) " + phoneNumber.toString(),
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  TextButton(
                    onPressed: () {
                      if (this.mounted) {
                        setState(() {
                          currentState =
                              MobileVerificationState.SHOW_MOBILE_FORM_STATE;
                        });
                      }
                    },
                    child: Text(
                      "Change",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Enter OTP",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 10),
          OTPTextField(
            length: 6,
            width: MediaQuery.of(context).size.width,
            fieldWidth: 40,
            style: TextStyle(fontSize: 18),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onCompleted: (pin) async {
              otp = pin;
              try {
                await _signInWithPhoneNumber(context, contact);
              } on FirebaseException catch (e) {
                showSnackBar(context, e.message.toString());
              } catch (e) {
                print(e.toString());
              }
            },
            onChanged: (pin) {},
          ),
          SizedBox(height: 40),
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                text: "Send OTP again in ",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              TextSpan(
                text: start >= 10 ? "00:$start" : "00:0$start",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: " sec ",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          )),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: wait
                  ? null
                  : () async {
                      print("resend called");
                      if (this.mounted) {
                        setState(() {
                          wait = true;
                          _loading = true;
                        });
                      }
                      // sign in with phone number
                      await _signInWithPhoneNumber(context, contact);
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 3;
                      });
                    },
              child: Text("RESEND OTP", style: TextStyle(color: kPrimaryColor)),
            ),
          ),
        ],
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (this.mounted) {
        if (start == 0) {
          setState(() {
            timer.cancel();
            wait = false;
          });
        } else {
          setState(() {
            start--;
          });
        }
      }
    });
  }

  void setData(String verificationID) {
    if (this.mounted) {
      setState(() {
        _loading = false;
        verificationId = verificationID;
      });
    }
    startTimer();
  }
}

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
