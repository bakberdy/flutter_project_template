import 'package:analyzer/analysis_rule/analysis_rule.dart';
import 'package:analyzer/analysis_rule/pubspec.dart';
import 'package:analyzer/error/error.dart';
import 'package:project_lints/src/architecture/architecture_policy.dart';

class ModuleDependencyRule extends AnalysisRule {
  ModuleDependencyRule({ArchitecturePolicyResolver? policyResolver})
    : policyResolver = policyResolver ?? ArchitecturePolicyLoader().resolve,
      super(
        name: 'invalid_module_dependency',
        description:
            'Prevents local module dependencies forbidden by '
            'architecture.yaml.',
      );

  static const code = LintCode(
    'invalid_module_dependency',
    'Module "{0}" cannot depend on module "{1}".',
    correctionMessage: 'Remove this dependency. Allowed local modules: {2}.',
    uniqueName: 'ProjectLints.invalidModuleDependency',
  );

  final ArchitecturePolicyResolver policyResolver;

  @override
  DiagnosticCode get diagnosticCode => code;

  @override
  PubspecVisitor<Object?> get pubspecVisitor => _ModuleDependencyVisitor(this);
}

class _ModuleDependencyVisitor extends PubspecVisitor<Object?> {
  _ModuleDependencyVisitor(this.rule);

  final ModuleDependencyRule rule;

  @override
  void visitPackageDependency(PubspecDependency dependency) {
    _check(dependency);
  }

  @override
  void visitPackageDevDependency(PubspecDependency dependency) {
    _check(dependency);
  }

  @override
  void visitPackageDependencyOverride(PubspecDependency dependency) {
    _check(dependency);
  }

  void _check(PubspecDependency dependency) {
    final dependencyNode = dependency.name;
    final dependencyName = dependencyNode?.text;
    final sourceUrl = dependencyNode?.span.sourceUrl;
    if (dependencyNode == null ||
        dependencyName == null ||
        sourceUrl == null ||
        sourceUrl.scheme != 'file') {
      return;
    }

    final policy = rule.policyResolver(sourceUrl.toFilePath());
    if (policy == null || !policy.config.rules.dependencies.enabled) return;
    final module = policy.moduleForPath(sourceUrl.toFilePath());
    if (module == null || policy.isDependencyAllowed(module, dependencyName)) {
      return;
    }

    final allowed = policy.allowedDependenciesFor(module).toList()..sort();
    final allowedDescription = allowed.isEmpty ? 'none' : allowed.join(', ');
    rule.reportAtPubNode(
      dependencyNode,
      arguments: [module.name, dependencyName, allowedDescription],
    );
  }
}
