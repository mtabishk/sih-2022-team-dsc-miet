import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/common_widgets/custom_user_header.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/app/other_services/service_page.dart';
import 'package:kiran_user_app/app/wellness/wellness_page.dart';
import 'package:kiran_user_app/services/auth_service.dart';
import 'package:provider/provider.dart';

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
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => ServicePage(
                  title: "Appointments",
                )));
        break;
      case 2:
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (context) => WellnessPage()));
        break;
      case 3:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => ServicePage(
                  title: "Report",
                )));
        break;
      case 4:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => ServicePage(
                  title: "Other Services",
                )));

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

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
            _buildDrawerItem(context, "Appointments", 1),
            _buildDrawerItem(context, "Wellness", 2),
            _buildDrawerItem(context, "Report", 3),
            _buildDrawerItem(context, "Other Services", 4),
            SizedBox(height: 80.0),
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
                  onPressed: () {
                    auth.signOut();
                  },
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
