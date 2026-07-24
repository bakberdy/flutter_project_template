import 'dart:io';

const _allowedComment = 'hardcoded-ui-text: allow';
const _scannedRoots = ['apps', 'modules'];

final _literalPatterns = [
  RegExp(
    r'''(?:const\s+)?Text\s*\(\s*(['"])(.*?)\1''',
    dotAll: true,
  ),
  RegExp(
    r'''\b(?:title|message|description|label|hintText|helperText|errorText|tooltip|semanticLabel|primaryLabel|secondaryLabel|emptyText)\s*:\s*(['"])(.*?)\1''',
    dotAll: true,
  ),
];

void main(List<String> arguments) {
  final isNonBlocking = arguments.contains('--non-blocking');
  final repositoryRoot = _findRepositoryRoot();
  final violations = <_Violation>[];

  for (final rootName in _scannedRoots) {
    final root = Directory.fromUri(repositoryRoot.uri.resolve('$rootName/'));
    if (!root.existsSync()) continue;

    for (final entity in root.listSync(recursive: true, followLinks: false)) {
      if (entity is! File || !_shouldScan(entity.path)) continue;

      final source = entity.readAsStringSync();
      for (final pattern in _literalPatterns) {
        for (final match in pattern.allMatches(source)) {
          final value = match.group(2) ?? '';
          if (!_isUserFacingLiteral(value) ||
              _isExplicitlyAllowed(source, match.start)) {
            continue;
          }

          final relativePath = entity.uri.path.substring(
            repositoryRoot.uri.path.length,
          );
          final line =
              '\n'.allMatches(source.substring(0, match.start)).length + 1;
          violations.add(
            _Violation(
              path: relativePath,
              line: line,
              value: value,
            ),
          );
        }
      }
    }
  }

  violations.sort(
    (first, second) => first.location.compareTo(second.location),
  );
  if (violations.isEmpty) {
    stdout.writeln('No hardcoded UI strings found.');
    return;
  }

  stderr
    ..writeln('Hardcoded UI strings found:')
    ..writeln(violations.map((violation) => violation.description).join('\n'))
    ..writeln(
      'Use the owning module localization or add '
      '"// $_allowedComment" for intentional non-localizable UI metadata.',
    );

  _writeGitHubReport(violations, isNonBlocking: isNonBlocking);
  if (isNonBlocking) {
    stdout.writeln(
      'Hardcoded UI strings are reported as warnings and do not fail CI.',
    );
    return;
  }

  exitCode = 1;
}

void _writeGitHubReport(
  List<_Violation> violations, {
  required bool isNonBlocking,
}) {
  if (Platform.environment['GITHUB_ACTIONS'] != 'true') return;

  final annotationLevel = isNonBlocking ? 'warning' : 'error';
  for (final violation in violations) {
    stdout.writeln(
      '::$annotationLevel '
      'file=${_escapeWorkflowProperty(violation.path)},'
      'line=${violation.line},'
      'title=Hardcoded UI text::'
      '${_escapeWorkflowData(violation.value)}',
    );
  }

  final summaryPath = Platform.environment['GITHUB_STEP_SUMMARY'];
  final repository = Platform.environment['GITHUB_REPOSITORY'];
  final serverUrl = Platform.environment['GITHUB_SERVER_URL'];
  final revision = Platform.environment['GITHUB_SHA'];
  if (summaryPath == null ||
      repository == null ||
      serverUrl == null ||
      revision == null) {
    return;
  }

  final summary = StringBuffer()
    ..writeln('## Hardcoded UI texts')
    ..writeln()
    ..writeln(
      isNonBlocking
          ? 'These findings are optional warnings and do not fail validation.'
          : 'These findings fail validation.',
    )
    ..writeln();
  for (final violation in violations) {
    final encodedPath = violation.path
        .split('/')
        .map(Uri.encodeComponent)
        .join('/');
    final url =
        '$serverUrl/$repository/blob/$revision/$encodedPath#L${violation.line}';
    summary.writeln(
      '- [${violation.path}:${violation.line}]($url): '
      '`${_escapeMarkdownCode(violation.value)}`',
    );
  }
  File(
    summaryPath,
  ).writeAsStringSync(summary.toString(), mode: FileMode.append);
}

String _escapeWorkflowProperty(String value) {
  return _escapeWorkflowData(
    value,
  ).replaceAll(':', '%3A').replaceAll(',', '%2C');
}

String _escapeWorkflowData(String value) {
  return value
      .replaceAll('%', '%25')
      .replaceAll('\r', '%0D')
      .replaceAll('\n', '%0A');
}

String _escapeMarkdownCode(String value) {
  return value.replaceAll('`', r'\`').replaceAll('\n', ' ');
}

Directory _findRepositoryRoot() {
  var current = Directory.current.absolute;

  while (true) {
    final pubspec = File.fromUri(current.uri.resolve('pubspec.yaml'));
    final modules = Directory.fromUri(current.uri.resolve('modules/'));
    if (pubspec.existsSync() &&
        modules.existsSync() &&
        RegExp(
          '^workspace:',
          multiLine: true,
        ).hasMatch(pubspec.readAsStringSync())) {
      return current;
    }

    final parent = current.parent;
    if (parent.path == current.path) {
      stderr.writeln(
        'Could not find the repository root from ${Directory.current.path}.',
      );
      exit(1);
    }
    current = parent;
  }
}

bool _shouldScan(String path) {
  final normalizedPath = path.replaceAll(r'\', '/');

  if (!normalizedPath.endsWith('.dart') ||
      !normalizedPath.contains('/lib/') ||
      RegExp('/(?:gen|l10n)/').hasMatch(normalizedPath) ||
      RegExp(r'\.(?:g|gr|freezed|config)\.dart$').hasMatch(normalizedPath)) {
    return false;
  }

  return RegExp(
        '/(?:presentation|widgets|screens|app)/',
      ).hasMatch(normalizedPath) ||
      RegExp(
        '/shared/lib/src/(?:mappers|mixins)/',
      ).hasMatch(normalizedPath);
}

bool _isUserFacingLiteral(String value) {
  if (value.isEmpty || value.contains(r'$')) return false;

  return RegExp(
    '[A-Za-zА-Яа-яЁёҚқӘәІіҢңҒғҮүҰұӨөҺһ]',
  ).hasMatch(value);
}

bool _isExplicitlyAllowed(String source, int offset) {
  final lineStart = source.lastIndexOf('\n', offset - 1) + 1;
  final previousLineEnd = lineStart > 0 ? lineStart - 1 : 0;
  final previousLineStart = previousLineEnd > 0
      ? source.lastIndexOf('\n', previousLineEnd - 1) + 1
      : 0;
  return source.substring(previousLineStart, offset).contains(_allowedComment);
}

final class _Violation {
  const _Violation({
    required this.path,
    required this.line,
    required this.value,
  });

  final String path;
  final int line;
  final String value;

  String get location => '$path:$line';
  String get description => '$location: "$value"';
}
