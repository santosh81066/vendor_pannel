import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageModal {
  final XFile? profilePic;
  final XFile? coverPage;
  
  // Constructor with an optional profilePic parameter
  ImageModal(
      {this.profilePic,
      this.coverPage
      });

  // The copyWith method allows you to create a copy of the instance
  // with an updated profilePic if provided
  ImageModal copyWith(
      {XFile? profilePic,
      XFile? coverPage,
      }) {
    return ImageModal(
        profilePic: profilePic ?? this.profilePic,
        coverPage: coverPage??this.coverPage
        );
  }
}
