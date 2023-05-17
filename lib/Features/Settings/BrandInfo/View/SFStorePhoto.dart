import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sandfriends_web/SharedComponents/Model/StorePhoto.dart';
import 'package:sandfriends_web/Utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../SharedComponents/View/SFLoading.dart';

class StorePhotoCard extends StatefulWidget {
  StorePhoto storePhoto;
  VoidCallback delete;

  StorePhotoCard({
    super.key,
    required this.storePhoto,
    required this.delete,
  });

  @override
  State<StorePhotoCard> createState() => _StorePhotoCardState();
}

class _StorePhotoCardState extends State<StorePhotoCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 190,
          width: 320,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(defaultBorderRadius),
                child: widget.storePhoto.isNewPhoto
                    ? Image.memory(
                        widget.storePhoto.newPhoto!,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: widget.storePhoto.photo,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: SFLoading(
                            size: 50,
                          ),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(Icons.error),
                        ),
                      ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: widget.delete,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryBlue,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      r'assets/icon/x.svg',
                      color: secondaryPaper,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 2 * defaultPadding,
        )
      ],
    );
  }
}
