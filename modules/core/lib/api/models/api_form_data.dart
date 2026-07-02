class ApiFormData {
  final Map<String, Object?> fields;
  final Map<String, ApiMultipartFile> files;

  const ApiFormData({this.fields = const {}, this.files = const {}});

  Map<String, Object?> toMap() => {...fields, ...files};
}

class ApiMultipartFile {
  final List<int> bytes;
  final String filename;
  final String? contentType;

  const ApiMultipartFile({
    required this.bytes,
    required this.filename,
    this.contentType,
  });
}
