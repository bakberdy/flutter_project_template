import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:project_lints/src/rules/generated_file.dart';

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
    if (isGeneratedCodeFile(context.definingUnit.file.path)) {
      return;
    }
    registry.addPostfixExpression(
      this,
      _AvoidForceUnwrapVisitor(this, context),
    );
  }
}

class _AvoidForceUnwrapVisitor extends SimpleAstVisitor<void> {
  const _AvoidForceUnwrapVisitor(this.rule, this.context);

  final AvoidForceUnwrapRule rule;
  final RuleContext context;

  @override
  void visitPostfixExpression(PostfixExpression node) {
    final filePath = context.currentUnit?.file.path;
    if (filePath != null && isGeneratedCodeFile(filePath)) {
      return;
    }
    if (node.operator.lexeme == '!') {
      rule.reportAtToken(node.operator);
    }
  }
}
