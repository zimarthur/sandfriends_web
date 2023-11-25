import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  String icon;
  Widget widget;
  bool mainDrawer;
  bool requiresAdmin;
  Color? color;
  bool logout;
  bool availableMobile;
  bool isNew;

  DrawerItem({
    required this.title,
    required this.icon,
    required this.requiresAdmin,
    required this.mainDrawer,
    required this.widget,
    this.color,
    this.logout = false,
    this.availableMobile = false,
    this.isNew = false,
  });
}
