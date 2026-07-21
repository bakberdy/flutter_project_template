class ApiFormData {
  const ApiFormData({this.fields = const {}, this.files = const {}});

  final Map<String, Object?> fields;
  final Map<String, ApiMultipartFile> files;

  Map<String, Object?> toMap() => {...fields, ...files};
}

class ApiMultipartFile {
  const ApiMultipartFile({
    required this.bytes,
    required this.filename,
    this.contentType,
  });

  final List<int> bytes;
  final String filename;
  final String? contentType;
}
