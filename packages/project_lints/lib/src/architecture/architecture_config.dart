import 'package:yaml/yaml.dart';

const _supportedArchitectureVersion = 1;

class ArchitectureConfigParser {
  ArchitectureParseResult parse(
    String source, {
    String sourceName = 'architecture.yaml',
  }) {
    final violations = <ConfigViolation>[];
    final Object? document;
    try {
      document = loadYaml(source);
    } on YamlException catch (error) {
      return ArchitectureParseResult(
        violations: [
          ConfigViolation(sourceName, 'Invalid YAML: ${error.message}'),
        ],
      );
    } on Object catch (error) {
      return ArchitectureParseResult(
        violations: [
          ConfigViolation(sourceName, 'Could not parse YAML: $error'),
        ],
      );
    }

    final root = _readMap(document, sourceName, violations);
    if (root == null) {
      return ArchitectureParseResult(violations: violations);
    }

    final version = _readInt(
      root['version'],
      '$sourceName.version',
      violations,
    );
    if (version != null && version != _supportedArchitectureVersion) {
      violations.add(
        ConfigViolation(
          '$sourceName.version',
          'Unsupported version $version. Supported version: '
              '$_supportedArchitectureVersion.',
        ),
      );
    }

    final groups = _parseGroups(root['groups'], sourceName, violations);
    final modules = _parseModules(root['modules'], sourceName, violations);
    final rules = _parseRules(root['rules'], sourceName, violations);
    _validateReferences(groups, modules, sourceName, violations);

    violations.sort();
    if (violations.isNotEmpty || version == null || rules == null) {
      return ArchitectureParseResult(violations: violations);
    }

    return ArchitectureParseResult(
      config: ArchitectureConfig(
        version: version,
        groups: groups,
        modules: modules,
        rules: rules,
      ),
    );
  }

  Map<String, GroupConfig> _parseGroups(
    Object? value,
    String sourceName,
    List<ConfigViolation> violations,
  ) {
    final groupsPath = '$sourceName.groups';
    final groupMap = _readMap(value, groupsPath, violations);
    if (groupMap == null) return const {};

    final groups = <String, GroupConfig>{};
    for (final entry in _sortedEntries(groupMap)) {
      final groupPath = '$groupsPath.${entry.key}';
      final moduleNames = _readStringList(entry.value, groupPath, violations);
      if (moduleNames == null) continue;

      final seenModules = <String>{};
      for (final moduleName in moduleNames) {
        if (!seenModules.add(moduleName)) {
          violations.add(
            ConfigViolation(
              groupPath,
              'Module "$moduleName" is listed more than once.',
            ),
          );
        }
      }
      groups[entry.key] = GroupConfig(
        name: entry.key,
        modules: List.unmodifiable(moduleNames),
      );
    }
    return Map.unmodifiable(groups);
  }

  Map<String, ModuleConfig> _parseModules(
    Object? value,
    String sourceName,
    List<ConfigViolation> violations,
  ) {
    final modulesPath = '$sourceName.modules';
    final moduleMap = _readMap(value, modulesPath, violations);
    if (moduleMap == null) return const {};
    if (moduleMap.isEmpty) {
      violations.add(
        ConfigViolation(modulesPath, 'At least one module must be configured.'),
      );
    }

    final modules = <String, ModuleConfig>{};
    for (final entry in _sortedEntries(moduleMap)) {
      final modulePath = '$modulesPath.${entry.key}';
      final rawModule = _readMap(entry.value, modulePath, violations);
      if (rawModule == null) continue;

      final path = _readNonEmptyString(
        rawModule['path'],
        '$modulePath.path',
        violations,
      );
      final allow = _readMap(
        rawModule['allow'],
        '$modulePath.allow',
        violations,
      );
      final allowedGroups = allow == null
          ? null
          : _readStringList(
              allow['groups'],
              '$modulePath.allow.groups',
              violations,
            );
      if (path == null || allowedGroups == null) continue;

      modules[entry.key] = ModuleConfig(
        name: entry.key,
        path: path,
        allowedGroups: List.unmodifiable(allowedGroups),
      );
    }
    return Map.unmodifiable(modules);
  }

  RulesConfig? _parseRules(
    Object? value,
    String sourceName,
    List<ConfigViolation> violations,
  ) {
    final rulesPath = '$sourceName.rules';
    final rules = _readMap(value, rulesPath, violations);
    if (rules == null) return null;

    final dependencies = _parseRule(
      rules['dependencies'],
      '$rulesPath.dependencies',
      violations,
    );
    final imports = _parseRule(
      rules['imports'],
      '$rulesPath.imports',
      violations,
    );
    final relativeImports = _parseRule(
      rules['relative_imports'],
      '$rulesPath.relative_imports',
      violations,
    );
    final circularDependencies = _parseRule(
      rules['circular_dependencies'],
      '$rulesPath.circular_dependencies',
      violations,
    );
    if (dependencies == null ||
        imports == null ||
        relativeImports == null ||
        circularDependencies == null) {
      return null;
    }

    return RulesConfig(
      dependencies: DependencyRulesConfig(enabled: dependencies),
      importsEnabled: imports,
      relativeImportsEnabled: relativeImports,
      circularDependenciesEnabled: circularDependencies,
    );
  }

  bool? _parseRule(
    Object? value,
    String path,
    List<ConfigViolation> violations,
  ) {
    final rule = _readMap(value, path, violations);
    if (rule == null) return null;
    return _readBool(rule['enabled'], '$path.enabled', violations);
  }

  void _validateReferences(
    Map<String, GroupConfig> groups,
    Map<String, ModuleConfig> modules,
    String sourceName,
    List<ConfigViolation> violations,
  ) {
    for (final group in groups.values.toList()..sort()) {
      for (final moduleName in group.modules) {
        if (!modules.containsKey(moduleName)) {
          violations.add(
            ConfigViolation(
              '$sourceName.groups.${group.name}',
              'Unknown module "$moduleName".',
            ),
          );
        }
      }
    }

    for (final module in modules.values.toList()..sort()) {
      for (final groupName in module.allowedGroups) {
        if (!groups.containsKey(groupName)) {
          violations.add(
            ConfigViolation(
              '$sourceName.modules.${module.name}.allow.groups',
              'Unknown group "$groupName".',
            ),
          );
        }
      }
    }
  }
}

class ArchitectureConfig {
  const ArchitectureConfig({
    required this.version,
    required this.groups,
    required this.modules,
    required this.rules,
  });

  final int version;
  final Map<String, GroupConfig> groups;
  final Map<String, ModuleConfig> modules;
  final RulesConfig rules;
}

class GroupConfig implements Comparable<GroupConfig> {
  const GroupConfig({required this.name, required this.modules});

  final String name;
  final List<String> modules;

  @override
  int compareTo(GroupConfig other) => name.compareTo(other.name);
}

class ModuleConfig implements Comparable<ModuleConfig> {
  const ModuleConfig({
    required this.name,
    required this.path,
    required this.allowedGroups,
  });

  final String name;
  final String path;
  final List<String> allowedGroups;

  @override
  int compareTo(ModuleConfig other) => name.compareTo(other.name);
}

class RulesConfig {
  const RulesConfig({
    required this.dependencies,
    required this.importsEnabled,
    required this.relativeImportsEnabled,
    required this.circularDependenciesEnabled,
  });

  final DependencyRulesConfig dependencies;
  final bool importsEnabled;
  final bool relativeImportsEnabled;
  final bool circularDependenciesEnabled;
}

class DependencyRulesConfig {
  const DependencyRulesConfig({required this.enabled});

  final bool enabled;
}

class ConfigViolation implements Comparable<ConfigViolation> {
  const ConfigViolation(this.location, this.message);

  final String location;
  final String message;

  @override
  int compareTo(ConfigViolation other) {
    final locationComparison = location.compareTo(other.location);
    if (locationComparison != 0) return locationComparison;
    return message.compareTo(other.message);
  }
}

class ArchitectureParseResult {
  const ArchitectureParseResult({this.config, this.violations = const []});

  final ArchitectureConfig? config;
  final List<ConfigViolation> violations;
}

Map<String, Object?>? _readMap(
  Object? value,
  String path,
  List<ConfigViolation> violations,
) {
  if (value is! Map<Object?, Object?>) {
    violations.add(ConfigViolation(path, 'Expected a map.'));
    return null;
  }

  final result = <String, Object?>{};
  for (final entry in value.entries) {
    final key = entry.key;
    if (key is! String || key.isEmpty) {
      violations.add(
        ConfigViolation(path, 'Map keys must be non-empty strings.'),
      );
      continue;
    }
    result[key] = entry.value;
  }
  return result;
}

List<String>? _readStringList(
  Object? value,
  String path,
  List<ConfigViolation> violations,
) {
  if (value is! List<Object?>) {
    violations.add(ConfigViolation(path, 'Expected a list of strings.'));
    return null;
  }

  final result = <String>[];
  for (var index = 0; index < value.length; index++) {
    final item = value[index];
    if (item is! String || item.isEmpty) {
      violations.add(
        ConfigViolation('$path[$index]', 'Expected a non-empty string.'),
      );
      continue;
    }
    result.add(item);
  }
  return result;
}

String? _readNonEmptyString(
  Object? value,
  String path,
  List<ConfigViolation> violations,
) {
  if (value is! String || value.trim().isEmpty) {
    violations.add(ConfigViolation(path, 'Expected a non-empty string.'));
    return null;
  }
  return value;
}

int? _readInt(Object? value, String path, List<ConfigViolation> violations) {
  if (value is! int) {
    violations.add(ConfigViolation(path, 'Expected an integer.'));
    return null;
  }
  return value;
}

bool? _readBool(Object? value, String path, List<ConfigViolation> violations) {
  if (value is! bool) {
    violations.add(ConfigViolation(path, 'Expected a boolean.'));
    return null;
  }
  return value;
}

List<MapEntry<String, Object?>> _sortedEntries(Map<String, Object?> map) =>
    map.entries.toList()..sort((left, right) => left.key.compareTo(right.key));
