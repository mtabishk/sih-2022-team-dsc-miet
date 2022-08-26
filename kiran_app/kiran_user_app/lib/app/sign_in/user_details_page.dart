import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/common_widgets/custom_text_form_field.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/models/user_details_model.dart';
import 'package:kiran_user_app/services/firestore_service.dart';
import 'package:kiran_user_app/services/user_details_provider.dart';
import 'package:provider/provider.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final _userDetailsFormKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _gender = 'Male';
  List<String> _genderTypes = ["Male", "Female", "Prefer not to say"];
  int _age = 0;
  String _contactNumber = '';
  String _contactName = '';
  bool _ageUnder18 = false;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    final _showUserDetails =
        Provider.of<UserDetailsProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child:
                    Center(child: Image.asset("assets/icons/kiran-logo.png")),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.0,
                          child: DefaultTextStyle(
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            child: AnimatedTextKit(
                              pause: Duration(milliseconds: 100),
                              repeatForever: true,
                              animatedTexts: [
                                ScaleAnimatedText('GET'),
                                ScaleAnimatedText('STARTED'),
                              ],
                              onTap: () {
                                print("Tap Event");
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                            key: _userDetailsFormKey,
                            child: Column(
                              children: [
                                CustomTextField(
                                    labelText: "First Name",
                                    hintText: "Enter your first name",
                                    onSaved: (value) {
                                      if (value != null) {
                                        _firstName = value;
                                      }
                                    }),
                                SizedBox(height: 10),
                                CustomTextField(
                                    labelText: "Last Name",
                                    hintText: "Enter your last name",
                                    onSaved: (value) {
                                      if (value != null) {
                                        _lastName = value;
                                      }
                                    }),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 20.0, 0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Gender:",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          )),
                                      SizedBox(
                                        width: 150,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          child: DropdownButton<String>(
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.white,
                                            ),
                                            value: _gender,
                                            items: _genderTypes
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0),
                                                  child: Text(
                                                    items,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                _gender = value!;
                                              });
                                            },
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            isExpanded: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CustomTextField(
                                    labelText: "Age",
                                    hintText: "Enter your age",
                                    onChanged: (value) {
                                      if (value != null) {
                                        _age = int.parse(value);
                                        if (_age < 18) {
                                          setState(() {
                                            _ageUnder18 = true;
                                          });
                                        } else {
                                          setState(() {
                                            print(_age);
                                            _ageUnder18 = false;
                                          });
                                        }
                                      }
                                    }),
                                SizedBox(height: 20),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomTextField(
                                        labelText: "Emergency Contact Name",
                                        hintText:
                                            "Enter your Emergency Contact name",
                                        onSaved: (value) {
                                          if (value != null) {
                                            _contactName = value;
                                          }
                                        }),
                                    SizedBox(height: 10),
                                    CustomTextField(
                                        labelText: "Emergency Contact",
                                        hintText:
                                            "Enter your Emergency Contact number",
                                        onSaved: (value) {
                                          if (value != null) {
                                            _contactNumber = value;
                                          }
                                        }),
                                  ],
                                ),
                                SizedBox(height: 80),
                                InkWell(
                                  onTap: () async {
                                    print(_userDetailsFormKey.currentState);
                                    if (_userDetailsFormKey.currentState !=
                                        null) {
                                      _userDetailsFormKey.currentState?.save();

                                      await database.updateUserDetails(
                                          data: UserDetailsModel(
                                        displayName:
                                            _firstName + " " + _lastName,
                                        gender: _gender,
                                        age: _age.toString(),
                                        emergencyContact: _contactNumber,
                                        emergencyContactName: _contactName,
                                      ));
                                    }

                                    _showUserDetails
                                        .changeGetUserDetailsValue();
                                  },
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                16.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              "Next",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.arrow_forward,
                                              color: Color(0xFF0ACDCF),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
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
