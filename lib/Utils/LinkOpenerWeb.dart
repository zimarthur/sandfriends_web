import 'dart:js' as js;

import 'package:flutter/material.dart';

void openLink(BuildContext context, String link) {
  js.context.callMethod('open', [link]);
}
