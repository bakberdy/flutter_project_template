import 'package:analysis_server_plugin/plugin.dart';
import 'package:analysis_server_plugin/registry.dart';
import 'package:project_lints/src/rules/class_name_matches_file_name_rule.dart';
import 'package:project_lints/src/rules/common_feature_import_rule.dart';
import 'package:project_lints/src/rules/cross_feature_import_rule.dart';
import 'package:project_lints/src/rules/module_dependency_rule.dart';

class ProjectLintsPlugin extends Plugin {
  @override
  String get name => 'Project architecture lints';

  @override
  void register(PluginRegistry registry) {
    registry
      ..registerLintRule(ModuleDependencyRule())
      ..registerLintRule(CrossFeatureImportRule())
      ..registerLintRule(CommonFeatureImportRule())
      ..registerLintRule(ClassNameMatchesFileNameRule());
  }
}
