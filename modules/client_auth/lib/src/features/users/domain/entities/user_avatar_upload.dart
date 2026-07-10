import 'package:equatable/equatable.dart';

class UserAvatarUpload extends Equatable {
  final List<int> bytes;
  final String filename;
  final String? sourcePath;
  final String? contentType;

  const UserAvatarUpload({
    required this.bytes,
    required this.filename,
    this.sourcePath,
    this.contentType,
  });

  @override
  List<Object?> get props => [bytes, filename, sourcePath, contentType];
}
