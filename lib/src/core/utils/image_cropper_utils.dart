import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:un4seen/src/core/theme/app_colors.dart';

class ImageCropperUtils {
  static Future<File?> cropImage(
    String sourcePath, {
    bool isProfile = false,
    bool is16x9 = false,
  }) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: sourcePath,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppColors.kPrimaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: is16x9
              ? CropAspectRatioPreset.ratio16x9
              : (isProfile
                  ? CropAspectRatioPreset.square
                  : CropAspectRatioPreset.original),
          lockAspectRatio: is16x9 || isProfile,
          aspectRatioPresets: is16x9
              ? [CropAspectRatioPreset.ratio16x9]
              : (isProfile
                  ? [CropAspectRatioPreset.square]
                  : [
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio16x9,
                    ]),
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioLockEnabled: is16x9 || isProfile,
          resetAspectRatioEnabled: !(is16x9 || isProfile),
          aspectRatioPresets: is16x9
              ? [CropAspectRatioPreset.ratio16x9]
              : (isProfile
                  ? [CropAspectRatioPreset.square]
                  : [
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio16x9,
                    ]),
        ),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }
}
