import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../Utils/Constants.dart';
import 'SFLoading.dart';

class SFAvatar extends StatefulWidget {
  final double height;
  final String? image;
  final Uint8List? editImage;
  final bool isPlayerAvatar;
  final String? playerFirstName;
  final String? playerLastName;
  final String? storeName;

  const SFAvatar(
      {super.key,
      required this.height,
      required this.image,
      this.editImage,
      this.isPlayerAvatar = false,
      this.playerFirstName,
      this.playerLastName,
      this.storeName});

  @override
  State<SFAvatar> createState() => _SFAvatarState();
}

class _SFAvatarState extends State<SFAvatar> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.height * 0.5,
      backgroundColor: secondaryPaper,
      child: CircleAvatar(
        radius: widget.height * 0.45,
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.height * 0.45),
              child: widget.editImage != null
                  ? Image.memory(
                      widget.editImage!,
                      fit: BoxFit.cover,
                    )
                  : widget.image != null
                      ? CachedNetworkImage(
                          imageUrl: widget.image!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Padding(
                                padding: EdgeInsets.all(widget.height * 0.3),
                                child: SFLoading(
                                  size: widget.height * 0.4,
                                ),
                              ),
                          errorWidget: (context, url, error) =>
                              widget.isPlayerAvatar
                                  ? Center(
                                      child: SizedBox(
                                        height: widget.height * 0.4,
                                        width: widget.height * 0.4,
                                        child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Text(
                                            "${widget.playerFirstName![0].toUpperCase()}${widget.playerLastName![0].toUpperCase()}",
                                            style: TextStyle(
                                              color: secondaryPaper,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: SizedBox(
                                        height: widget.height * 0.4,
                                        width: widget.height * 0.4,
                                        child: FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Text(
                                            widget.storeName![0].toUpperCase(),
                                            style: TextStyle(
                                              color: secondaryPaper,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                      : widget.isPlayerAvatar
                          ? Center(
                              child: SizedBox(
                                height: widget.height * 0.4,
                                width: widget.height * 0.4,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    "${widget.playerFirstName![0].toUpperCase()}${widget.playerLastName![0].toUpperCase()}",
                                    style: TextStyle(
                                      color: secondaryPaper,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: SizedBox(
                                height: widget.height * 0.4,
                                width: widget.height * 0.4,
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Text(
                                    widget.storeName![0].toUpperCase(),
                                    style: TextStyle(
                                      color: secondaryPaper,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            )),
        ),
      ),
    );
  }
}
