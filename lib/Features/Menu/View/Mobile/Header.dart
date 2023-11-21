import 'package:flutter/material.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/DataProvider.dart';
import 'package:sandfriends_web/Features/Menu/ViewModel/MenuProvider.dart';
import 'package:sandfriends_web/SharedComponents/View/SFAvatar.dart';
import 'package:sandfriends_web/Utils/Constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import '../../../../SharedComponents/ViewModel/EnvironmentProvider.dart';

class MobileHeader extends StatefulWidget {
  MenuProvider viewModel;
  MobileHeader({required this.viewModel, super.key});

  @override
  State<MobileHeader> createState() => _MobileHeaderState();
}

class _MobileHeaderState extends State<MobileHeader> {
  double imageSize = 100.0;
  late PaletteGenerator paletteGenerator;
  Color dominantColor = secondaryBack;
  Color secondColor = secondaryBack;

  double buttonSize = 20;
  @override
  void initState() {
    _updatePaletteGenerator();
    super.initState();
  }

  Future<void> _updatePaletteGenerator() async {
    if (Provider.of<DataProvider>(context, listen: false).store != null &&
        Provider.of<DataProvider>(context, listen: false).store!.logo != null) {
      paletteGenerator = await PaletteGenerator.fromImageProvider(
        Image.network(
          Provider.of<EnvironmentProvider>(context, listen: false).urlBuilder(
            Provider.of<DataProvider>(context, listen: false).store!.logo,
            isImage: true,
          ),
        ).image,
      );
      if (paletteGenerator.dominantColor != null) {
        setState(() {
          dominantColor = paletteGenerator.dominantColor!.color;
          if (paletteGenerator.vibrantColor != null) {
            secondColor = paletteGenerator.vibrantColor!.color;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryBack,
      child: Column(
        children: [
          Container(
            color: primaryBlue,
            padding: EdgeInsets.all(
              defaultPadding,
            ),
            child: Row(
              children: [
                widget.viewModel.isOnHome
                    ? Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              width: defaultPadding,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Olá, ${Provider.of<DataProvider>(context, listen: false).loggedEmployee.firstName}!",
                                    style: TextStyle(
                                        color: textWhite, fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: defaultPadding / 6,
                                  ),
                                  Text(
                                    Provider.of<DataProvider>(context,
                                            listen: false)
                                        .store!
                                        .name,
                                    style: TextStyle(
                                        color: textLightGrey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.pushNamed(
                                context,
                                "/notifications",
                              ),
                              child: SvgPicture.asset(
                                Provider.of<DataProvider>(
                                  context,
                                ).hasUnseenNotifications
                                    ? r"assets/icon/notification_on.svg"
                                    : r"assets/icon/notification_off.svg",
                                height: buttonSize,
                              ),
                            ),
                            SizedBox(
                              width: 2 * defaultPadding,
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: Row(
                        children: [
                          SizedBox(
                            width: buttonSize,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                widget.viewModel.selectedDrawerItem.title,
                                style: TextStyle(
                                  color: textWhite,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                InkWell(
                  onTap: () => Scaffold.of(context).openEndDrawer(),
                  child: SvgPicture.asset(
                    r"assets/icon/menu_burger.svg",
                    color: textWhite,
                    height: buttonSize,
                  ),
                ),
              ],
            ),
          ),
          if (widget.viewModel.isOnHome)
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: imageSize / 2.5,
                      color: primaryBlue,
                    ),
                    Container(
                      height: imageSize / 8,
                      decoration: BoxDecoration(
                        color: dominantColor,
                        boxShadow: [
                          BoxShadow(
                            color: secondColor,
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: imageSize,
                  margin: EdgeInsets.only(
                    left: 2 * defaultPadding,
                  ),
                  child: SFAvatar(
                      height: imageSize,
                      image: Provider.of<DataProvider>(context, listen: false)
                                  .store ==
                              null
                          ? null
                          : Provider.of<DataProvider>(context, listen: false)
                              .store!
                              .logo,
                      storeName:
                          Provider.of<DataProvider>(context, listen: false)
                              .store!
                              .name),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
