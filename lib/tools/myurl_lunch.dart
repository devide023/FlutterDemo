import 'package:url_launcher/url_launcher.dart';

class myurl_launch {
  static launch_tel(String telno) async {
    String url = "tel:" + telno;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
