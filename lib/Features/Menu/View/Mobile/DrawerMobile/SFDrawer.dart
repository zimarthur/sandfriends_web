import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../ViewModel/MenuProvider.dart';
import '../../Web/DrawerWeb/SFDrawerListTile.dart';

class SFDrawer extends StatefulWidget {
  MenuProvider viewModel;
  SFDrawer({
    required this.viewModel,
  });

  @override
  State<SFDrawer> createState() => _SFDrawerState();
}

class _SFDrawerState extends State<SFDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: textWhite,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: primaryBlue,
              padding: EdgeInsets.only(bottom: defaultBorderRadius),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(defaultBorderRadius),
                      bottomRight: Radius.circular(
                        defaultBorderRadius,
                      ),
                    ),
                    color: textWhite,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                      vertical: defaultPadding,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 90,
                              child: Image.asset(
                                r"assets/logo_64.png",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            SizedBox(
                              height: defaultPadding / 4,
                            ),
                            Text(
                              "BW Sports",
                              style: TextStyle(
                                color: textBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "Arthur Zim",
                              style: TextStyle(
                                color: textDarkGrey,
                              ),
                            )
                          ],
                        )),
                        SvgPicture.asset(
                          r"assets/icon/settings.svg",
                          height: 25,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: primaryBlue,
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding / 2,
                  vertical: defaultPadding,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.viewModel.mainDrawer.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              widget.viewModel.onTabClick(
                                  widget.viewModel.mainDrawer[index], context);
                            },
                            onHover: (value) {
                              widget.viewModel.setHoveredDrawerTitle(value
                                  ? widget.viewModel.mainDrawer[index].title
                                  : "");
                            },
                            child: SFDrawerListTile(
                              title: widget.viewModel.mainDrawer[index].title,
                              svgSrc: widget.viewModel.mainDrawer[index].icon,
                              isSelected: widget.viewModel.mainDrawer[index] ==
                                  widget.viewModel.selectedDrawerItem,
                              fullSize: true,
                              isHovered: widget.viewModel.hoveredDrawerTitle ==
                                  widget.viewModel.mainDrawer[index].title,
                            ),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        r"assets/full_logo_negative_284_courts.png",
                        height: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
