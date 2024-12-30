//package
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class RoundedImageNetwork extends StatelessWidget {
  final String imagePath;
  final double size;
  const RoundedImageNetwork({
    super.key,
    required this.imagePath,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imagePath),
          //image: NetworkImage(imagePath),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(size),
        ),
        color: Colors.black,
      ),
    );
  }
}

class RoundedImageFile extends StatelessWidget {
  final File image;
  final double size;
  const RoundedImageFile({
    super.key,
    required this.image,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(image),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(size),
        ),
        color: Colors.black,
      ),
    );
  }
}
