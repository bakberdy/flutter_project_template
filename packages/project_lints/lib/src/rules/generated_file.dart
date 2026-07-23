import 'package:path/path.dart' as p;

bool isGeneratedCodeFile(String filePath) {
  final fileName = p.basename(filePath);
  return fileName.contains('.g.') || fileName.contains('.freezed.');
}
