import 'package:flutter/material.dart';

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Mental health includes our emotional, psychological, and social well-being. It affects how we think, feel, and act. It also helps determine how we handle stress, relate to others, and make healthy choices. Mental health is important at every stage of life, from childhood and adolescence through adulthood.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "KIRAN application aims to provide early screening, first-aid, psychological support, distress management, mental well-being, and psychological crisis management.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Mental health needs to be a priority, from immediate crisis intervention and helplines to focusing on preventive mental health and reducing the stigma around help-seeking. Nurturing mental health doesn’t just improve our daily functioning, but it can also help us control — or at least combat — some of the physical health problems directly linked to mental health conditions.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "By making a concerted effort to spread mental health awareness, we can work to de-stigmatize how we think about, approach, and identify mental health issues in our society.  Having those tough conversations and admitting there’s a problem means we can come up with a solution. We can start removing the shame and fear that’s often associated with topics surrounding mental health. Doing so can increase the likelihood of someone reaching out when they need help.  Asking for help is a sign of strength. Working together allows us to begin building a foundation that respects and honors the importance of good mental health.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
