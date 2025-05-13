import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../res/app_function.dart';

class SelectImageRepository {
  final ImagePicker _imagePicker = ImagePicker();

  Future<File> captureImageSingle({required ImageSource imageSource}) async {
    try {
      XFile? captureImage = await _imagePicker.pickImage(source: imageSource);
      return File(captureImage!.path);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }
}
