import 'package:flutter/material.dart';

class CustomUserHeader extends StatelessWidget {
  const CustomUserHeader({
    Key? key,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.onClicked,
  }) : super(key: key);
  final String name;
  final String email;
  final String imageUrl;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.grey[300],
                backgroundImage: AssetImage(imageUrl),
              ),
            ),
            SizedBox(width: 20.0),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                Text(
                  email,
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
