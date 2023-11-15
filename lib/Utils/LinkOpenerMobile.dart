import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void openLink(BuildContext context, String link) {
  launchUrl(Uri.parse(link));
}
