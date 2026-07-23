import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:path/path.dart' as p;

class ClassNameMatchesFileNameRule extends AnalysisRule {
  ClassNameMatchesFileNameRule()
    : super(
        name: 'class_name_matches_file_name',
        description:
            'Requires a public class name to match its snake_case file name.',
      );

  static const code = LintCode(
    'class_name_matches_file_name',
    'Public class "{0}" must be named "{1}" to match this file.',
    correctionMessage: 'Rename the class or its file.',
    uniqueName: 'ProjectLints.classNameMatchesFileName',
  );

  @override
  DiagnosticCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final filePath = context.definingUnit.file.path;
    if (!context.isInLibDir ||
        _isGeneratedFile(filePath) ||
        _isAnalyticsEventsFile(filePath)) {
      return;
    }
    registry.addCompilationUnit(
      this,
      _ClassNameMatchesFileNameVisitor(this, filePath),
    );
  }
}

class _ClassNameMatchesFileNameVisitor extends SimpleAstVisitor<void> {
  const _ClassNameMatchesFileNameVisitor(this.rule, this.filePath);

  final ClassNameMatchesFileNameRule rule;
  final String filePath;

  @override
  void visitCompilationUnit(CompilationUnit node) {
    if (node.directives.any(
      (directive) => directive is PartDirective || directive is PartOfDirective,
    )) {
      return;
    }

    final publicClasses = _publicClasses(node);
    final expectedName = _classNameForFile(filePath);
    if (publicClasses.any(
      (declaration) => declaration.namePart.typeName.lexeme == expectedName,
    )) {
      return;
    }

    for (final declaration in publicClasses) {
      final nameToken = declaration.namePart.typeName;
      final actualName = nameToken.lexeme;
      rule.reportAtToken(
        nameToken,
        arguments: [actualName, expectedName],
      );
    }
  }
}

List<ClassDeclaration> _publicClasses(CompilationUnit unit) => unit.declarations
    .whereType<ClassDeclaration>()
    .where(
      (declaration) => !declaration.namePart.typeName.lexeme.startsWith('_'),
    )
    .toList();

String _classNameForFile(String filePath) {
  final fileName = p.basenameWithoutExtension(filePath);
  return fileName
      .split('_')
      .where((part) => part.isNotEmpty)
      .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
      .join();
}

bool _isGeneratedFile(String filePath) {
  const generatedSuffixes = [
    '.freezed.dart',
    '.g.dart',
    '.gen.dart',
    '.gr.dart',
    '.module.dart',
  ];
  return generatedSuffixes.any(filePath.endsWith);
}

bool _isAnalyticsEventsFile(String filePath) {
  final segments = p.split(p.normalize(filePath));
  return segments.contains('analytics') &&
      p.basename(filePath).endsWith('_events.dart');
}
