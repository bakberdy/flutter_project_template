import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:project_lints/src/architecture/architecture_policy.dart';
import 'package:project_lints/src/rules/avoid_force_unwrap_rule.dart';
import 'package:project_lints/src/rules/class_name_matches_file_name_rule.dart';
import 'package:project_lints/src/rules/common_feature_import_rule.dart';
import 'package:project_lints/src/rules/cross_feature_import_rule.dart';
import 'package:project_lints/src/rules/module_dependency_rule.dart';

class ProjectLintsPlugin extends Plugin {
  @override
  String get name => 'Project architecture lints';

  @override
  void register(PluginRegistry registry) {
    final policyResolver = ArchitecturePolicyLoader().resolve;
    registry
      ..registerLintRule(
        ModuleDependencyRule(policyResolver: policyResolver),
      )
      ..registerLintRule(
        CrossFeatureImportRule(policyResolver: policyResolver),
      )
      ..registerLintRule(
        CommonFeatureImportRule(policyResolver: policyResolver),
      )
      ..registerLintRule(ClassNameMatchesFileNameRule())
      ..registerLintRule(AvoidForceUnwrapRule());
  }
}
