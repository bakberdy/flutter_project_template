import 'package:core/shared/entities/app_picked_file.dart';
import 'package:image_picker/image_picker.dart';

abstract final class AppFilePicker {
  static Future<AppPickedFile?> pickFile({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
    );
    if (file == null) {
      return null;
    }

    return AppPickedFile(
      bytes: await file.readAsBytes(),
      filename: file.name,
      sourcePath: file.path,
      contentType:
          file.mimeType ??
          _contentTypeFromPath(file.path) ??
          _contentTypeFromPath(file.name),
    );
  }

  static String? _contentTypeFromPath(String path) {
    final segments = path.split('.');
    final extension = segments.length < 2 ? null : segments.last.toLowerCase();
    return switch (extension) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'webp' => 'image/webp',
      _ => null,
    };
  }
}
