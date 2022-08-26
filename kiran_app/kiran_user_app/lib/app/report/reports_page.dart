import 'package:flutter/material.dart';
import 'package:kiran_user_app/app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  bool isDownloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
      ),
      body: Center(
        child: isDownloading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isDownloading = true;
                  });
                  await Future.delayed(Duration(seconds: 2));
                  setState(() {
                    isDownloading = false;
                  });
                  await showReportDownloadedDialog(
                    context,
                    title: "Report",
                    content: "Report has been downloaded",
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: Text("Downlaod Report")),
      ),
    );
  }

  Future<void> _launchUrl() async {
    final _url = Uri.parse(
        "https://sihhealthbucket.s3.ap-south-1.amazonaws.com/neutralpatient.pdf?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEFoaCmFwLXNvdXRoLTEiRjBEAiBlJgCGU8lwg7kwQDabpYfmgVsoMDGBx%2BW47v4YMvty%2BwIgYyT0ppMoKAZEwSZzU1uYXHAEI9C8WPhRblix3yjOqSwq7QII0%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARABGgwzMDc2ODI3NzM4NTQiDO5FLwPBziTsQ0uzkirBAoQsC8%2B3KNiHaTgnXb1Pu3LP7FChji%2BLusP74uFGMDBog759eHQN1ixiB47nWuk5wk%2FOdv0iZtm8wHt8vRGH7KV4p9AV107OExeG0h1H%2B7AJ6noOrSRrIzXfFHXjhSrV0f6R%2Fws%2FuU7lp%2B8sleTe1g5HB8G3GhfVvmWnBfNncZ9AZ09LKX14GfGTeM3SjxeIJv7hrbgzXv%2BOizZAoMKaWnqJgfRvPLmtgioK0Y09IYUKUC2bgADFSrzWcIQXs1qGbUU3KHw0IDfnw8l1%2FIsl9CaVUKKaGe1UIVTkvtcFLNUasAAcNcuUyZ9BiWh1E9G%2BqX2kYyyL5OgEANBvjoembaF4P8GiFEoN4iVo6hIh9t2sLQhgF1yYQuHyppguITNiV4FteSNwZjdneWLmLbRalbZOAIf9NjE%2FiWaRxOOUDyZNpTDC8KGYBjq0AroV03OFKT3tFw5u8XDPkHN32WmbWKKzNs%2F2iN%2Fe7iyWxc1OxBrr2FyIiFFhLtvrcH5GFOyeReWD%2BwQIKS2VIAFvApV%2BXjFVwC%2Born9hvPvbYCcLFhl3TCEkOVkOm7QPbkt2Nt9%2FjZcOlTE2V7SlJR0WwjdWIlBG2ElB4mtRFsqIUVI8eMY3gqqXGChCAlBe3J5rFic7xQKkNPfk9ZJuBrbeWckBhhSTAauLwjbhBCgnOPfzuxlvpMwQl0OCTo4Fgphe%2FTuyGlSCUVqkRMO%2BuenUxaJpzAfVwOMk4TAbU8YnZl7dJzG%2FfbiRD045J6k6Csigbwkx1b1nNHqrnzjvzL%2BO46zcXHK9ztrPSM2jkVGjw2Q7%2BbyHWVXDKwV2vMsFARmWtNtklAUJ3mLtPMWmu%2B6JJYNy&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20220826T100738Z&X-Amz-SignedHeaders=host&X-Amz-Expires=43200&X-Amz-Credential=ASIAUPI2SRNPI4GVA7SX%2F20220826%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Signature=5e15b1d5acb379172a9b1a7f94029c879f18cbbf83e9583608f4fcad8dca6753");
    try {
      await launchUrl(_url);
    } catch (e) {
      print(e);
      throw 'Could not launch $_url';
    }
  }

  Future showReportDownloadedDialog(
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
                height: 100.0,
                child: Image.asset("assets/images/icon-tick.png")),
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
}
