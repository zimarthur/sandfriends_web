import 'package:flutter/material.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sandfriends_web/Features/Menu/View/Drawer/SFDrawerUserWidget.dart';
import 'package:sandfriends_web/Features/Menu/View/Drawer/SFDrawerListTile.dart';

import '../../../../Utils/Responsive.dart';
import '../../ViewModel/MenuProvider.dart';
import 'SFDrawerDivider.dart';

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool fullSize =
        !Responsive.isMobile(context) && widget.viewModel.isDrawerExpanded ||
            Responsive.isMobile(context);
    return Responsive.isMobile(context) &&
            widget.viewModel.isDrawerOpened == false
        ? Container()
        : Container(
            decoration: const BoxDecoration(
              color: primaryBlue,
              border: Border(
                right: BorderSide(
                  color: primaryDarkBlue,
                  width: 1,
                ),
              ),
            ),
            width: fullSize ? 250 : 82,
            height: height,
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Responsive.isMobile(context) == false
                    ? InkWell(
                        onTap: () => widget.viewModel.isDrawerExpanded =
                            !widget.viewModel.isDrawerExpanded,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: double.infinity,
                          alignment: fullSize
                              ? Alignment.centerRight
                              : Alignment.center,
                          child: SvgPicture.asset(
                            fullSize
                                ? r'assets/icon/double_arrow_left.svg'
                                : r'assets/icon/double_arrow_right.svg',
                            height: 25,
                            width: 25,
                            color: secondaryPaper,
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: defaultPadding,
                ),
                Image.asset(
                  fullSize
                      ? r'assets/full_logo_negative_284.png'
                      : r'assets/logo_64.png',
                ),
                const SFDrawerDivider(),
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
                          fullSize: fullSize,
                          isHovered: widget.viewModel.hoveredDrawerTitle ==
                              widget.viewModel.mainDrawer[index].title,
                        ),
                      );
                    },
                  ),
                ),
                const SFDrawerDivider(),
                SFDrawerUserWidget(
                  fullSize: fullSize,
                  menuProvider: widget.viewModel,
                )
              ],
            ),
          );
  }
}
