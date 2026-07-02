import 'package:equatable/equatable.dart';

class AppPickedFile extends Equatable {
  const AppPickedFile({
    required this.bytes,
    required this.filename,
    required this.sourcePath,
    this.contentType,
  });

  final List<int> bytes;
  final String filename;
  final String sourcePath;
  final String? contentType;

  @override
  List<Object?> get props => [bytes, filename, sourcePath, contentType];
}
