import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:kiran_user_app/services/show_onboarding_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FeaturesScreen extends StatefulWidget {
  const FeaturesScreen({Key? key}) : super(key: key);

  @override
  State<FeaturesScreen> createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {
  bool _agreedToTerms = false;
  @override
  Widget build(BuildContext context) {
    final _showOnBoarding =
        Provider.of<ShowOnboardingProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  pause: Duration(milliseconds: 300),
                  repeatForever: true,
                  animatedTexts: [
                    FlickerAnimatedText('ABOUT THE KIRAN APP'),
                    // TypewriterAnimatedText(
                    //     'Choose an option to start the screening'),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                await showDetailsDialog(
                    data:
                        "Mental health includes our emotional, psychological, and social well-being. It affects how we think, feel, and act. It also helps determine how we handle stress, relate to others, and make healthy choices. Mental health is important at every stage of life, from childhood and adolescence through adulthood");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: 60,
                      child: Image.asset("assets/icons/icon-1.png")),
                  Text(
                    "Mental Health",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Opacity(
                    opacity: 0.0,
                    child: SizedBox(
                        height: 60,
                        child: Image.asset("assets/icons/icon-1.png")),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                await showDetailsDialog(
                    data:
                        "KIRAN application aims to provide early screening, first-aid, psychological support, distress management, mental well-being, and psychological crisis management.");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: 60,
                      child: Image.asset("assets/icons/icon-2.png")),
                  Text(
                    "Aim                ",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Opacity(
                    opacity: 0.0,
                    child: SizedBox(
                        height: 60,
                        child: Image.asset("assets/icons/icon-2.png")),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                await showDetailsDialog(
                    data:
                        "Mental health needs to be a priority, from immediate crisis intervention and helplines to focusing on preventive mental health and reducing the stigma around help-seeking.Nurturing mental health doesn’t just improve our daily functioning, but it can also help us control — or at least combat — some of the physical health problems directly linked to mental health conditions. ");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: 60,
                      child: Image.asset("assets/icons/icon-3.png")),
                  Text(
                    "Needs            ",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Opacity(
                    opacity: 0.0,
                    child: SizedBox(
                        height: 60,
                        child: Image.asset("assets/icons/icon-3.png")),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                await showDetailsDialog(
                    data:
                        "By making a concerted effort to spread mental health awareness, we can work to de-stigmatize how we think about, approach, and identify mental health issues in our society.  Having those tough conversations and admitting there’s a problem means we can come up with a solution. We can start removing the shame and fear that’s often associated with topics surrounding mental health. Doing so can increase the likelihood of someone reaching out when they need help.  Asking for help is a sign of strength. Working together allows us to begin building a foundation that respects and honors the importance of good mental health.");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: 60,
                      child: Image.asset("assets/icons/icon-1.png")),
                  Text(
                    "Mission          ",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Opacity(
                    opacity: 0.0,
                    child: SizedBox(
                        height: 60,
                        child: Image.asset("assets/icons/icon-2.png")),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.white,
                  ),
                  child: Checkbox(
                      activeColor: kPrimaryColor,
                      value: _agreedToTerms,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _agreedToTerms = value;
                          });
                        }
                      }),
                ),
                TextButton(
                  onPressed: () async {
                    await showTermsAndConditionDialog(
                      heading: "KIRAN APP USER AGREEMENT",
                      disclaimerTitle: "Disclaimer",
                      disclaimer:
                          "Kiran application does not deal with medical or psychological emergencies. We are not designed to offer support in crisis situations - including when an individual is experiencing thoughts of self-harmor suicide, or is showing symptoms of severe clinical disorders such as schizophrenia and other psychotic conditions. In these cases, in-person medical intervention is the most appropriate form of help. If you feel you are experiencing any of these difficulties, or if you are considering or contemplating suicide or feel that you are a danger to yourself or to others, we would urge you to seek help at the nearest hospital or emergency room where you can connect with a psychiatrist, social worker, counsellor or therapist in person. The same applies in-case of any medical or psychological healthemergency. We recommend you to involve a close family member or a friend who can offer support.",
                      termsTitle: "Terms",
                      terms:
                          "The general terms and conditions in the User Agreement are applicable to all present and future contracts established between the user and Kiran. This User Agreement applies to all users of the platform, including without limitation users who are browsers, vendors, customers, merchants, and/or contributors of content. By availing any of our Services, the user irrevocably accepts all the obligations stipulated in the User Agreement, Terms of Services and Privacy Policy, other policies referenced herein; and agrees to abide by them. The User Agreement supersedes any previous oral or written terms and conditions that may have been communicated to you.",
                    );
                    // await _launchUrl(
                    //     "http://ec2-13-235-195-145.ap-south-1.compute.amazonaws.com/");
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'I agree to the ',
                      style: TextStyle(
                        color: _agreedToTerms ? kPrimaryColor : Colors.white,
                        fontSize: 16.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'terms and conditions',
                          style: TextStyle(
                            color:
                                _agreedToTerms ? kPrimaryColor : Colors.white,
                            fontSize: 16.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  if (_agreedToTerms) {
                    _showOnBoarding.changeQuestionareCompletedValue();
                    Navigator.of(context).pop();
                  }
                },
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
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
            ),
          ],
        ),
      )),
    );
  }

  Future<void> _launchUrl(String url) async {
    final _url = Uri.parse(url);
    try {
      await launchUrl(_url);
    } catch (e) {
      print(e);
      throw 'Could not launch $_url';
    }
  }

  Future<void> showDetailsDialog({
    required String data,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showTermsAndConditionDialog({
    required String heading,
    required String disclaimerTitle,
    required String termsTitle,
    required String disclaimer,
    required String terms,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  heading,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  disclaimerTitle,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  disclaimer,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  termsTitle,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  terms,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
