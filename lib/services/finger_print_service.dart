

import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../database/users_db.dart';
import '../models/user_model.dart';

class FingerprintService {
  static final ImagePicker _picker = ImagePicker();


  static Future<File?> captureFingerprint() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      requestFullMetadata: true,
      imageQuality: 100,
    );
    if (image == null) return null;
    return File(image.path);
  }
}


// MOCK MATCHING (ONLY FOR DEMO)
User? mockMatch(File scan) {
  for (final user in registeredUsers) {
    if (user.fingerprint.lengthSync() == scan.lengthSync()) {
      return user;
    }
  }
  return null;
}