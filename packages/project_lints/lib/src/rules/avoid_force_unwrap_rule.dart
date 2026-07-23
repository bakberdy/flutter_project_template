import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:path/path.dart' as p;

class AvoidForceUnwrapRule extends AnalysisRule {
  AvoidForceUnwrapRule()
    : super(
        name: 'avoid_force_unwrap',
        description:
            'Prevents null assertions so nullable values are handled safely.',
      );

  static const code = LintCode(
    'avoid_force_unwrap',
    'Avoid force-unwrapping a nullable value.',
    correctionMessage:
        'Handle the null case explicitly or use a null-aware alternative.',
    uniqueName: 'ProjectLints.avoidForceUnwrap',
  );

  @override
  DiagnosticCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    if (_isGeneratedFile(context.definingUnit.file.path)) {
      return;
    }
    registry.addCompilationUnit(this, _AvoidForceUnwrapVisitor(this));
  }
}

bool _isGeneratedFile(String filePath) {
  final fileName = p.basename(filePath);
  return fileName.contains('.g.') || fileName.contains('.freezed.');
}

class _AvoidForceUnwrapVisitor extends SimpleAstVisitor<void> {
  const _AvoidForceUnwrapVisitor(this.rule);

  final AvoidForceUnwrapRule rule;

  @override
  void visitCompilationUnit(CompilationUnit node) {
    final filePath = node.declaredFragment?.source.fullName;
    if (filePath != null && _isGeneratedFile(filePath)) {
      return;
    }
    node.accept(_ForceUnwrapVisitor(rule));
  }
}

class _ForceUnwrapVisitor extends RecursiveAstVisitor<void> {
  const _ForceUnwrapVisitor(this.rule);

  final AvoidForceUnwrapRule rule;

  @override
  void visitPostfixExpression(PostfixExpression node) {
    if (node.operator.lexeme == '!') {
      rule.reportAtToken(node.operator);
    }
    super.visitPostfixExpression(node);
  }
}
