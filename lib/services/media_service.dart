import 'package:file_picker/file_picker.dart';
import 'dart:io';

class MediaService {
  MediaService() {}

  Future<File?> pickImageFromLibray() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }

    return null;
  }
}
