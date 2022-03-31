import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/common_widgets/custom_user_header.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/app/services/service_page.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({
    Key? key,
    required this.navigationDrawerKey,
  }) : super(key: key);
  final navigationDrawerKey;

  void onClickedDrawerItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        navigationDrawerKey.currentState!.closeDrawer();
        break;
      case 1:
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (context) => ServicePage()));
        break;
      case 2:
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (context) => ServicePage()));
        break;
      case 3:
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (context) => ServicePage()));
        break;
      case 4:
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (context) => ServicePage()));
        break;
      case 5:
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (context) => ServicePage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _name = 'Muhammad Tabish';
    final _email = 'mtabishkhanday@gmail.com';
    final _picUrl = 'assets/images/tabish-picture.png';
    return Drawer(
      child: Material(
        color: kPrimaryColor,
        child: ListView(
          children: <Widget>[
            CustomUserHeader(
              name: _name,
              email: _email,
              imageUrl: _picUrl,
              onClicked: () => print("clicked on user header"),
            ),
            _buildDrawerItem(context, "Home", 0),
            _buildDrawerItem(context, "Services", 1),
            _buildDrawerItem(context, "Profile", 2),
            _buildDrawerItem(context, "Wellness Goals", 3),
            _buildDrawerItem(context, "Appointments", 4),
            _buildDrawerItem(context, "Meditation", 5),
            SizedBox(height: 40.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )),
                  onPressed: () => print("logout"),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Log out",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, int index) {
    return ListTile(
      hoverColor: Colors.white70,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      onTap: () => onClickedDrawerItem(context, index),
    );
  }
}
