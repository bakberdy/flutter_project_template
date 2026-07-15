import 'dart:io';

final _uiLiteralPatterns = <RegExp>[
  RegExp(r'''(?:const\s+)?Text\s*\(\s*(['"])(.*?)\1''', dotAll: true),
  RegExp(
    r'''\b(?:title|message|description|label|hintText|helperText|errorText|tooltip|semanticLabel|primaryLabel|secondaryLabel|emptyText)\s*:\s*(['"])(.*?)\1''',
    dotAll: true,
  ),
];

const _scannedRoots = ['apps', 'modules'];
const _allowedComment = 'hardcoded-ui-text: allow';

Future<void> main() async {
  final violations = <String>[];

  for (final rootPath in _scannedRoots) {
    final root = Directory(rootPath);
    if (!root.existsSync()) {
      continue;
    }

    await for (final entity in root.list(recursive: true)) {
      if (entity is! File || !_shouldScan(entity.path)) {
        continue;
      }
      final source = await entity.readAsString();
      for (final pattern in _uiLiteralPatterns) {
        for (final match in pattern.allMatches(source)) {
          final value = match.group(2) ?? '';
          if (!_isUserFacingLiteral(value) ||
              _isExplicitlyAllowed(source, match.start)) {
            continue;
          }
          final line =
              '\n'.allMatches(source.substring(0, match.start)).length + 1;
          violations.add('${entity.path}:$line: "$value"');
        }
      }
    }
  }

  if (violations.isEmpty) {
    stdout.writeln('No hardcoded UI strings found.');
    return;
  }

  stderr
    ..writeln('Hardcoded UI strings found:')
    ..writeln(violations.join('\n'))
    ..writeln(
      'Use the owning module localization or add "// $_allowedComment" '
      'for intentional non-localizable UI metadata.',
    );
  exitCode = 1;
}

bool _shouldScan(String path) {
  final normalized = path.replaceAll('\\', '/');
  if (!normalized.endsWith('.dart') ||
      !normalized.contains('/lib/') ||
      normalized.contains('/gen/') ||
      normalized.contains('/l10n/') ||
      normalized.endsWith('.g.dart') ||
      normalized.endsWith('.gr.dart') ||
      normalized.endsWith('.freezed.dart') ||
      normalized.endsWith('.config.dart')) {
    return false;
  }

  return normalized.contains('/presentation/') ||
      normalized.contains('/widgets/') ||
      normalized.contains('/screens/') ||
      normalized.contains('/app/') ||
      normalized.contains('/shared/lib/src/mappers/') ||
      normalized.contains('/shared/lib/src/mixins/');
}

bool _isUserFacingLiteral(String value) {
  if (value.isEmpty || value.contains(r'$')) {
    return false;
  }
  return RegExp(r'[A-Za-zА-Яа-яЁёҚқӘәІіҢңҒғҮүҰұӨөҺһ]').hasMatch(value);
}

bool _isExplicitlyAllowed(String source, int offset) {
  final lineStart = source.lastIndexOf('\n', offset - 1) + 1;
  final previousLineEnd = lineStart > 0 ? lineStart - 1 : 0;
  final previousLineStart = previousLineEnd > 0
      ? source.lastIndexOf('\n', previousLineEnd - 1) + 1
      : 0;
  final context = source.substring(previousLineStart, offset);
  return context.contains(_allowedComment);
}
