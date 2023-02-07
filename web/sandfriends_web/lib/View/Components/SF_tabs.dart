import 'package:flutter/material.dart';
import 'package:sandfriends_web/constants.dart';

class SFTabs extends StatefulWidget {
  List<String> tabs;

  SFTabs({required this.tabs});

  @override
  State<SFTabs> createState() => _SFTabsState();
}

class _SFTabsState extends State<SFTabs> {
  int selectedTab = 0;
  double tabWidth = 150;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: defaultPadding),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 40,
            child: ListView.builder(
              itemCount: widget.tabs.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (() {
                    setState(() {
                      selectedTab = index;
                    });
                  }),
                  child: Container(
                    alignment: Alignment.center,
                    width: tabWidth,
                    child: Text(
                      widget.tabs[index],
                      style: TextStyle(
                          color: index == selectedTab ? textBlue : textDarkGrey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
          Stack(
            children: [
              Container(
                height: 2,
                width: double.infinity,
                color: divider,
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 100),
                left: tabWidth * selectedTab,
                child: Container(
                  height: 4,
                  width: tabWidth,
                  color: primaryBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}