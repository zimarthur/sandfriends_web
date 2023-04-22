import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as IMG;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../../Utils/SFImage.dart';
import '../../../../ViewModel/DataProvider.dart';

class BrandInfoViewModel extends ChangeNotifier {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController instagramController = TextEditingController();

  Uint8List? storeAvatarRef;

  Uint8List? _storeAvatar;
  Uint8List? get storeAvatar => _storeAvatar;
  set storeAvatar(Uint8List? newFile) {
    _storeAvatar = newFile;
    notifyListeners();
  }

  List<Uint8List> storePhotosRef = [];
  final List<Uint8List> _storePhotos = [];
  List<Uint8List> get storePhotos => _storePhotos;

  int _decriptionLength = 0;
  int get descriptionLength => _decriptionLength;
  set descriptionLength(int value) {
    _decriptionLength = value;
    notifyListeners();
  }

  void setBrandInfoFields(BuildContext context) {
    descriptionController.text =
        Provider.of<DataProvider>(context, listen: false).store!.description ??
            "";
    instagramController.text =
        Provider.of<DataProvider>(context, listen: false).store!.instagram ??
            "";
    storeAvatarRef = storeAvatar;
    storePhotosRef = List.from(storePhotos);
  }

  bool brandInfoChanged(BuildContext context) {
    return descriptionController.text !=
            Provider.of<DataProvider>(context, listen: false)
                .store!
                .description ||
        instagramController.text !=
            Provider.of<DataProvider>(context, listen: false)
                .store!
                .instagram ||
        storeAvatar != storeAvatarRef ||
        listEquals(storePhotos, storePhotosRef) == false;
  }

  void onDescriptionTextChanged() {
    descriptionLength = descriptionController.text.length;
  }

  Future setStoreAvatar(BuildContext context) async {
    XFile? pickedImage = await pickImage();
    if (pickedImage == null) return;

    IMG.Image? decodedImage = IMG.decodeImage(await pickedImage.readAsBytes());

    double aspectRatio = decodedImage!.data!.height / decodedImage.data!.width;
    IMG.Image? resizedImage;
    if (aspectRatio > 1.0) {
      resizedImage =
          await resizeImage(decodedImage, 400, 400 ~/ aspectRatio);
    } else {
      resizedImage =
          await resizeImage(decodedImage, (400 * aspectRatio).toInt(), 400);
    }

    Uint8List? croppedImage = await cropImage(
      context,
      pickedImage,
      'circle',
      resizedImage!.height > resizedImage.width
          ? resizedImage.width
          : resizedImage.height,
      resizedImage.height > resizedImage.width
          ? resizedImage.width
          : resizedImage.height,
      resizedImage.height,
      resizedImage.width,
    );
    if (croppedImage == null) return;
    storeAvatar = croppedImage;
  }

  Future addStorePhoto(BuildContext context) async {
    XFile? pickedImage = await pickImage();
    if (pickedImage == null) return;

    IMG.Image? decodedImage = IMG.decodeImage(await pickedImage.readAsBytes());

    IMG.Image? resizedImage = await resizeImage(
      decodedImage!,
      null,
      300,
    );

    Uint8List? croppedImage = await cropImage(
      context,
      pickedImage,
      null,
      170,
      300,
      resizedImage!.height,
      resizedImage.width,
    );
    if (croppedImage == null) return;
    _storePhotos.add(croppedImage);
    notifyListeners();
  }

  void deleteStorePhoto(BuildContext context, int index) {
    _storePhotos.removeAt(index);

    notifyListeners();
  }
}
