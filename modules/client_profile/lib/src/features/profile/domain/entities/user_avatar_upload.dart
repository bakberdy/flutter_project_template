import 'package:equatable/equatable.dart';

class UserAvatarUpload extends Equatable {

  const UserAvatarUpload({
    required this.bytes,
    required this.filename,
    this.sourcePath,
    this.contentType,
  });
  final List<int> bytes;
  final String filename;
  final String? sourcePath;
  final String? contentType;

  @override
  List<Object?> get props => [bytes, filename, sourcePath, contentType];
}
