import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/rule_context.dart';
import 'package:analyzer/analysis_rule/rule_visitor_registry.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/error/error.dart';
import 'package:path/path.dart' as p;
import 'package:project_lints/src/architecture/architecture_config.dart';
import 'package:project_lints/src/architecture/architecture_policy.dart';
import 'package:project_lints/src/rules/generated_file.dart';

class CommonFeatureImportRule extends AnalysisRule {
  CommonFeatureImportRule({ArchitecturePolicyResolver? policyResolver})
    : policyResolver = policyResolver ?? ArchitecturePolicyLoader().resolve,
      super(
        name: 'common_feature_import',
        description:
            'Prevents common module code from depending on feature code.',
      );

  static const code = LintCode(
    'common_feature_import',
    'Common code cannot import feature "{0}".',
    correctionMessage:
        'Reverse the dependency or move the shared contract into common. '
        'Only common/config may compose features.',
    uniqueName: 'ProjectLints.commonFeatureImport',
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
    if (isGeneratedCodeFile(sourcePath)) return;
    final policy = policyResolver(sourcePath);
    if (policy == null || !policy.config.rules.importsEnabled) return;
    final module = policy.moduleForPath(sourcePath);
    if (module == null ||
        !_isCommonSource(policy, module, sourcePath) ||
        _isConfigSource(policy, module, sourcePath)) {
      return;
    }

    final visitor = _CommonFeatureImportVisitor(
      rule: this,
      policy: policy,
      module: module,
      sourcePath: sourcePath,
    );
    registry
      ..addImportDirective(this, visitor)
      ..addExportDirective(this, visitor);
  }

  bool _isCommonSource(
    ArchitecturePolicy policy,
    ModuleConfig module,
    String sourcePath,
  ) {
    final relativePath = _relativePath(policy, module, sourcePath);
    final segments = p.split(relativePath);
    return segments.length >= 3 &&
        segments[0] == 'lib' &&
        segments[1] == 'src' &&
        segments[2] == 'common';
  }

  bool _isConfigSource(
    ArchitecturePolicy policy,
    ModuleConfig module,
    String sourcePath,
  ) {
    final segments = p.split(_relativePath(policy, module, sourcePath));
    return segments.length >= 4 && segments[3] == 'config';
  }

  String _relativePath(
    ArchitecturePolicy policy,
    ModuleConfig module,
    String sourcePath,
  ) {
    final moduleRoot = p.join(policy.repositoryRoot, module.path);
    return p.relative(sourcePath, from: moduleRoot);
  }
}

class _CommonFeatureImportVisitor extends SimpleAstVisitor<void> {
  const _CommonFeatureImportVisitor({
    required this.rule,
    required this.policy,
    required this.module,
    required this.sourcePath,
  });

  final CommonFeatureImportRule rule;
  final ArchitecturePolicy policy;
  final ModuleConfig module;
  final String sourcePath;

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
    final feature = policy.importedFeature(
      module: module,
      sourcePath: sourcePath,
      uri: uri,
    );
    if (feature == null) return;
    rule.reportAtNode(node.uri, arguments: [feature]);
  }
}
