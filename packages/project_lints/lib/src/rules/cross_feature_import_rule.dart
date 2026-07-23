import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:project_lints/src/architecture/architecture_config.dart';
import 'package:project_lints/src/architecture/architecture_policy.dart';

class CrossFeatureImportRule extends AnalysisRule {
  CrossFeatureImportRule({ArchitecturePolicyResolver? policyResolver})
    : policyResolver = policyResolver ?? ArchitecturePolicyLoader().resolve,
      super(
        name: 'cross_feature_import',
        description:
            'Prevents one feature folder from importing another feature '
            'folder in the same module.',
      );

  static const code = LintCode(
    'cross_feature_import',
    'Feature "{0}" cannot import feature "{1}".',
    correctionMessage:
        "Move the shared contract to this module's common folder.",
    uniqueName: 'ProjectLints.crossFeatureImport',
  );

  final ArchitecturePolicyResolver policyResolver;

  @override
  DiagnosticCode get diagnosticCode => code;

  @override
  void registerNodeProcessors(
    RuleVisitorRegistry registry,
    RuleContext context,
  ) {
    final sourcePath = context.definingUnit.file.path;
    final policy = policyResolver(sourcePath);
    if (policy == null || !policy.config.rules.importsEnabled) return;
    final module = policy.moduleForPath(sourcePath);
    if (module == null) return;
    final sourceFeature = policy.featureForPath(module, sourcePath);
    if (sourceFeature == null) return;

    final visitor = _CrossFeatureImportVisitor(
      rule: this,
      policy: policy,
      module: module,
      sourcePath: sourcePath,
      sourceFeature: sourceFeature,
    );
    registry
      ..addImportDirective(this, visitor)
      ..addExportDirective(this, visitor);
  }
}

class _CrossFeatureImportVisitor extends SimpleAstVisitor<void> {
  const _CrossFeatureImportVisitor({
    required this.rule,
    required this.policy,
    required this.module,
    required this.sourcePath,
    required this.sourceFeature,
  });

  final CrossFeatureImportRule rule;
  final ArchitecturePolicy policy;
  final ModuleConfig module;
  final String sourcePath;
  final String sourceFeature;

  @override
  void visitExportDirective(ExportDirective node) {
    _check(node);
  }

  @override
  void visitImportDirective(ImportDirective node) {
    _check(node);
  }

  void _check(UriBasedDirective node) {
    final uri = node.uri.stringValue;
    if (uri == null) return;
    final importedFeature = policy.importedFeature(
      module: module,
      sourcePath: sourcePath,
      uri: uri,
    );
    if (importedFeature == null || importedFeature == sourceFeature) return;
    rule.reportAtNode(node.uri, arguments: [sourceFeature, importedFeature]);
  }
}
