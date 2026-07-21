import 'dart:io';

import 'package:yaml/yaml.dart';

const _supportedArchitectureVersion = 1;
const _dependencySectionNames = <String>[
  'dependencies',
  'dev_dependencies',
  'dependency_overrides',
];

void main() {
  try {
    final result = validateArchitecture(Directory.current.absolute);
    if (result.configViolations.isNotEmpty) {
      _printConfigViolations(result.configViolations);
      exitCode = 1;
      return;
    }
    if (result.dependencyViolations.isNotEmpty) {
      _printDependencyViolations(result.dependencyViolations);
      exitCode = 1;
      return;
    }

    stdout
      ..writeln('Module dependency validation passed.')
      ..writeln('Checked ${result.checkedModuleCount} modules.');
  } on Object catch (error) {
    stderr
      ..writeln('Module dependency validation failed.')
      ..writeln()
      ..writeln('Unexpected validation error: $error');
    exitCode = 1;
  }
}

ValidationResult validateArchitecture(
  Directory repositoryRoot, {
  String configPath = 'architecture.yaml',
}) {
  final configFile = File.fromUri(repositoryRoot.uri.resolve(configPath));
  if (!configFile.existsSync()) {
    return ValidationResult(
      configViolations: [
        ConfigViolation(configPath, 'Configuration file does not exist.'),
      ],
    );
  }

  final parseResult = ArchitectureConfigParser().parse(
    configFile.readAsStringSync(),
    sourceName: configPath,
  );
  final config = parseResult.config;
  if (config == null) {
    return ValidationResult(configViolations: parseResult.violations);
  }
  if (config.version != _supportedArchitectureVersion) {
    return ValidationResult(
      configViolations: [
        ConfigViolation(
          '$configPath.version',
          'Unsupported version ${config.version}.',
        ),
      ],
    );
  }

  final enabledUnsupportedRules = <String>[
    if (config.rules.importsEnabled) 'imports',
    if (config.rules.relativeImportsEnabled) 'relative_imports',
    if (config.rules.circularDependenciesEnabled) 'circular_dependencies',
  ];
  if (enabledUnsupportedRules.isNotEmpty) {
    return ValidationResult(
      configViolations: [
        for (final rule in enabledUnsupportedRules)
          ConfigViolation(
            '$configPath.rules.$rule.enabled',
            'This rule is reserved for future implementation and must be '
                'false.',
          ),
      ],
    );
  }

  final pubspecResult = ModulePubspecReader(repositoryRoot).read(config);
  if (pubspecResult.violations.isNotEmpty) {
    return ValidationResult(
      configViolations: pubspecResult.violations,
      checkedModuleCount: config.modules.length,
    );
  }

  final dependencyViolations = ModuleDependencyValidator().validate(
    config,
    pubspecResult.pubspecs,
  );
  return ValidationResult(
    dependencyViolations: dependencyViolations,
    checkedModuleCount: config.modules.length,
  );
}

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
      final moduleNames = _readStringList(
        entry.value,
        groupPath,
        violations,
      );
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

class ModulePubspecReader {
  const ModulePubspecReader(this.repositoryRoot);

  final Directory repositoryRoot;

  ModulePubspecReadResult read(ArchitectureConfig config) {
    final violations = <ConfigViolation>[];
    final pubspecs = <String, ModulePubspec>{};
    final modules = config.modules.values.toList()..sort();

    for (final module in modules) {
      final moduleUri = repositoryRoot.uri
          .resolve('${module.path}/')
          .normalizePath();
      if (moduleUri.scheme != 'file' ||
          !moduleUri.path.startsWith(repositoryRoot.uri.path)) {
        violations.add(
          ConfigViolation(
            module.path,
            'Configured module path must resolve inside the repository root.',
          ),
        );
        continue;
      }

      final moduleDirectory = Directory.fromUri(moduleUri);
      if (!moduleDirectory.existsSync()) {
        violations.add(
          ConfigViolation(
            module.path,
            'Configured module directory does not exist.',
          ),
        );
        continue;
      }

      final pubspecPath = '${module.path}/pubspec.yaml';
      final pubspecFile = File.fromUri(
        moduleDirectory.uri.resolve('pubspec.yaml'),
      );
      if (!pubspecFile.existsSync()) {
        violations.add(
          ConfigViolation(pubspecPath, 'Module pubspec.yaml does not exist.'),
        );
        continue;
      }

      final parseResult = ModulePubspecParser().parse(
        pubspecFile.readAsStringSync(),
        sourceName: pubspecPath,
      );
      violations.addAll(parseResult.violations);
      final pubspec = parseResult.pubspec;
      if (pubspec == null) continue;
      if (pubspec.name != module.name) {
        violations.add(
          ConfigViolation(
            pubspecPath,
            'Package name "${pubspec.name}" does not match configured module '
            'name "${module.name}".',
          ),
        );
        continue;
      }
      pubspecs[module.name] = pubspec;
    }

    violations.sort();
    return ModulePubspecReadResult(
      pubspecs: Map.unmodifiable(pubspecs),
      violations: List.unmodifiable(violations),
    );
  }
}

class ModulePubspecParser {
  ModulePubspecParseResult parse(
    String source, {
    required String sourceName,
  }) {
    final violations = <ConfigViolation>[];
    final Object? document;
    try {
      document = loadYaml(source);
    } on YamlException catch (error) {
      return ModulePubspecParseResult(
        violations: [
          ConfigViolation(sourceName, 'Invalid YAML: ${error.message}'),
        ],
      );
    } on Object catch (error) {
      return ModulePubspecParseResult(
        violations: [
          ConfigViolation(sourceName, 'Could not parse YAML: $error'),
        ],
      );
    }

    final root = _readMap(document, sourceName, violations);
    if (root == null) {
      return ModulePubspecParseResult(violations: violations);
    }
    final name = _readNonEmptyString(
      root['name'],
      '$sourceName.name',
      violations,
    );
    final dependencies = <String>{};
    for (final sectionName in _dependencySectionNames) {
      final sectionValue = root[sectionName];
      if (sectionValue == null) continue;
      final section = _readMap(
        sectionValue,
        '$sourceName.$sectionName',
        violations,
      );
      if (section != null) dependencies.addAll(section.keys);
    }

    violations.sort();
    if (name == null || violations.isNotEmpty) {
      return ModulePubspecParseResult(violations: violations);
    }
    return ModulePubspecParseResult(
      pubspec: ModulePubspec(
        name: name,
        dependencies: Set.unmodifiable(dependencies),
      ),
    );
  }
}

class ModuleDependencyValidator {
  List<DependencyViolation> validate(
    ArchitectureConfig config,
    Map<String, ModulePubspec> pubspecs,
  ) {
    if (!config.rules.dependencies.enabled) return const [];

    final violations = <DependencyViolation>[];
    final moduleNames = config.modules.keys.toList()..sort();
    for (final moduleName in moduleNames) {
      final module = config.modules[moduleName]!;
      final pubspec = pubspecs[moduleName];
      if (pubspec == null) continue;

      final allowedDependencies = <String>{};
      for (final groupName in module.allowedGroups) {
        allowedDependencies.addAll(config.groups[groupName]!.modules);
      }
      allowedDependencies.remove(moduleName);

      final dependencies = pubspec.dependencies.toList()..sort();
      for (final dependency in dependencies) {
        if (!config.modules.containsKey(dependency)) continue;
        if (dependency == moduleName ||
            !allowedDependencies.contains(dependency)) {
          violations.add(
            DependencyViolation(
              moduleName: moduleName,
              dependencyName: dependency,
              allowedDependencies: allowedDependencies.toList()..sort(),
              pubspecPath: '${module.path}/pubspec.yaml',
            ),
          );
        }
      }
    }

    violations.sort();
    return List.unmodifiable(violations);
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

class ModulePubspec {
  const ModulePubspec({required this.name, required this.dependencies});

  final String name;
  final Set<String> dependencies;
}

class DependencyViolation implements Comparable<DependencyViolation> {
  const DependencyViolation({
    required this.moduleName,
    required this.dependencyName,
    required this.allowedDependencies,
    required this.pubspecPath,
  });

  final String moduleName;
  final String dependencyName;
  final List<String> allowedDependencies;
  final String pubspecPath;

  @override
  int compareTo(DependencyViolation other) {
    final moduleComparison = moduleName.compareTo(other.moduleName);
    if (moduleComparison != 0) return moduleComparison;
    return dependencyName.compareTo(other.dependencyName);
  }
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

class ModulePubspecParseResult {
  const ModulePubspecParseResult({this.pubspec, this.violations = const []});

  final ModulePubspec? pubspec;
  final List<ConfigViolation> violations;
}

class ModulePubspecReadResult {
  const ModulePubspecReadResult({
    required this.pubspecs,
    required this.violations,
  });

  final Map<String, ModulePubspec> pubspecs;
  final List<ConfigViolation> violations;
}

class ValidationResult {
  const ValidationResult({
    this.configViolations = const [],
    this.dependencyViolations = const [],
    this.checkedModuleCount = 0,
  });

  final List<ConfigViolation> configViolations;
  final List<DependencyViolation> dependencyViolations;
  final int checkedModuleCount;
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

int? _readInt(
  Object? value,
  String path,
  List<ConfigViolation> violations,
) {
  if (value is! int) {
    violations.add(ConfigViolation(path, 'Expected an integer.'));
    return null;
  }
  return value;
}

bool? _readBool(
  Object? value,
  String path,
  List<ConfigViolation> violations,
) {
  if (value is! bool) {
    violations.add(ConfigViolation(path, 'Expected a boolean.'));
    return null;
  }
  return value;
}

List<MapEntry<String, Object?>> _sortedEntries(Map<String, Object?> map) =>
    map.entries.toList()..sort((left, right) => left.key.compareTo(right.key));

void _printConfigViolations(List<ConfigViolation> violations) {
  stderr
    ..writeln('Module dependency validation failed.')
    ..writeln()
    ..writeln('Configuration errors:');
  for (final violation in violations) {
    stderr
      ..writeln()
      ..writeln('[${violation.location}]')
      ..writeln(violation.message);
  }
  stderr
    ..writeln()
    ..writeln('Found ${violations.length} configuration errors.');
}

void _printDependencyViolations(List<DependencyViolation> violations) {
  stderr
    ..writeln('Module dependency validation failed.')
    ..writeln();
  for (final violation in violations) {
    stderr
      ..writeln('[${violation.moduleName}]')
      ..writeln('Forbidden dependency: ${violation.dependencyName}');
    if (violation.allowedDependencies.isEmpty) {
      stderr.writeln('Allowed local dependencies: none');
    } else {
      stderr.writeln('Allowed local dependencies:');
      for (final dependency in violation.allowedDependencies) {
        stderr.writeln('  - $dependency');
      }
    }
    stderr
      ..writeln('Declared in:')
      ..writeln('  ${violation.pubspecPath}')
      ..writeln();
  }
  stderr.writeln(
    'Found ${violations.length} dependency '
    '${violations.length == 1 ? 'violation' : 'violations'}.',
  );
}
