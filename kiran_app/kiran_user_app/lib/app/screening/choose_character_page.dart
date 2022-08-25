import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/screening/screening_page.dart';
import 'package:kiran_user_app/models/user_animation_character.dart';
import 'package:kiran_user_app/services/animation_character_provider.dart';
import 'package:kiran_user_app/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class ChooseCharacterPage extends StatelessWidget {
  const ChooseCharacterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    final _showAnimationCharacter =
        Provider.of<AnimationCharacterProvider>(context, listen: false);
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
          top: _height / 2,
          left: _width / 10,
          right: _width / 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choose your character",
                style: TextStyle(fontSize: 22.0),
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: 100.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ScreeningPage(
                                animationCharacter: 'assets/animations/cat.riv',
                              ),
                            ));
                        await database.updateUserAnimationCharacter(
                          data: UserAnimationCharacterModel(
                              animationCharacter: 'assets/animations/cat.riv'),
                        );
                      },
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 3,
                            color: Color(0xFFC3FDFD),
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: RiveAnimation.asset('assets/animations/cat.riv'),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ScreeningPage(
                                animationCharacter:
                                    'assets/animations/hi_yall_lau.riv',
                              ),
                            ));
                        await database.updateUserAnimationCharacter(
                          data: UserAnimationCharacterModel(
                              animationCharacter:
                                  'assets/animations/hi_yall_lau.riv'),
                        );
                      },
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 3,
                            color: Color(0xFFC3FDFD),
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: RiveAnimation.asset(
                            'assets/animations/hi_yall_lau.riv'),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ScreeningPage(
                                animationCharacter:
                                    'assets/animations/travie.riv',
                              ),
                            ));
                        await database.updateUserAnimationCharacter(
                            data: UserAnimationCharacterModel(
                                animationCharacter:
                                    'assets/animations/travie.riv'));
                      },
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 3,
                            color: Color(0xFFC3FDFD),
                            style: BorderStyle.solid,
                          ),
                        ),
                        child:
                            RiveAnimation.asset('assets/animations/travie.riv'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
