import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:un4seen/src/core/theme/app_colors.dart';

class ImageCropperUtils {
  static Future<File?> cropImage(String sourcePath, {bool isProfile = false}) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: sourcePath,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: AppColors.kPrimaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: isProfile ? CropAspectRatioPreset.square : CropAspectRatioPreset.original,
            lockAspectRatio: isProfile,
            aspectRatioPresets: isProfile 
                ? [CropAspectRatioPreset.square]
                : [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ],
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioLockEnabled: isProfile,
          resetAspectRatioEnabled: !isProfile,
          aspectRatioPresets: isProfile 
              ? [CropAspectRatioPreset.square]
              : [
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio16x9
                ],
        ),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }
}
