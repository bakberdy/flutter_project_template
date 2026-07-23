import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:project_lints/src/architecture/architecture_config.dart';

typedef ArchitecturePolicyResolver =
    ArchitecturePolicy? Function(String filePath);

class ArchitecturePolicy {
  ArchitecturePolicy({
    required this.repositoryRoot,
    required this.config,
  }) : _moduleRoots = _buildModuleRoots(repositoryRoot, config),
       _allowedDependencies = _buildAllowedDependencies(config);

  final String repositoryRoot;
  final ArchitectureConfig config;
  final Map<String, String> _moduleRoots;
  final Map<String, Set<String>> _allowedDependencies;

  ModuleConfig? moduleForPath(String filePath) {
    final normalizedFile = p.normalize(p.absolute(filePath));
    for (final MapEntry(key: moduleName, value: moduleRoot)
        in _moduleRoots.entries) {
      if (normalizedFile == moduleRoot ||
          p.isWithin(moduleRoot, normalizedFile)) {
        return config.modules[moduleName];
      }
    }
    return null;
  }

  Set<String> allowedDependenciesFor(ModuleConfig module) =>
      _allowedDependencies[module.name] ?? const {};

  bool isDependencyAllowed(ModuleConfig module, String dependencyName) {
    if (!config.modules.containsKey(dependencyName)) return true;
    return dependencyName != module.name &&
        allowedDependenciesFor(module).contains(dependencyName);
  }

  String? featureForPath(ModuleConfig module, String filePath) {
    final moduleRoot = _moduleRoots[module.name];
    if (moduleRoot == null) return null;
    final relativePath = p.relative(
      p.normalize(p.absolute(filePath)),
      from: moduleRoot,
    );
    final segments = p.split(relativePath);
    if (segments.length < 5 ||
        segments[0] != 'lib' ||
        segments[1] != 'src' ||
        segments[2] != 'features') {
      return null;
    }
    return segments[3];
  }

  String? importedFeature({
    required ModuleConfig module,
    required String sourcePath,
    required String uri,
  }) {
    final parsedUri = Uri.tryParse(uri);
    if (parsedUri == null) return null;

    if (parsedUri.scheme == 'package') {
      if (parsedUri.pathSegments.isEmpty ||
          parsedUri.pathSegments.first != module.name) {
        return null;
      }
      final segments = parsedUri.pathSegments.skip(1).toList();
      if (segments.length < 4 ||
          segments[0] != 'src' ||
          segments[1] != 'features') {
        return null;
      }
      return segments[2];
    }

    if (parsedUri.hasScheme) return null;
    final targetPath = p.normalize(
      p.join(p.dirname(sourcePath), parsedUri.path),
    );
    return featureForPath(module, targetPath);
  }
}

class ArchitecturePolicyLoader {
  final Map<String, String> _configPathByDirectory = {};
  final Map<String, ({DateTime modifiedAt, ArchitecturePolicy? policy})>
  _policyByConfigPath = {};

  ArchitecturePolicy? resolve(String filePath) {
    final startDirectory = p.normalize(p.dirname(p.absolute(filePath)));
    final cachedConfigPath = _configPathByDirectory[startDirectory];
    if (cachedConfigPath != null) {
      final configFile = File(cachedConfigPath);
      if (configFile.existsSync()) {
        return _load(configFile, configFile.parent.path);
      }
      _configPathByDirectory.remove(startDirectory);
      _policyByConfigPath.remove(cachedConfigPath);
    }

    final visitedDirectories = <String>[];
    var directory = Directory(startDirectory);
    while (true) {
      visitedDirectories.add(directory.path);
      final configFile = File(p.join(directory.path, 'architecture.yaml'));
      if (configFile.existsSync()) {
        for (final path in visitedDirectories) {
          _configPathByDirectory[path] = configFile.path;
        }
        return _load(configFile, directory.path);
      }

      final parent = directory.parent;
      if (parent.path == directory.path) return null;
      directory = parent;
    }
  }

  ArchitecturePolicy? _load(File configFile, String repositoryRoot) {
    try {
      final modifiedAt = configFile.lastModifiedSync();
      final cached = _policyByConfigPath[configFile.path];
      if (cached != null && cached.modifiedAt == modifiedAt) {
        return cached.policy;
      }

      final result = ArchitectureConfigParser().parse(
        configFile.readAsStringSync(),
        sourceName: configFile.path,
      );
      final config = result.config;
      final policy = config == null
          ? null
          : ArchitecturePolicy(repositoryRoot: repositoryRoot, config: config);
      _policyByConfigPath[configFile.path] = (
        modifiedAt: modifiedAt,
        policy: policy,
      );
      return policy;
    } on FileSystemException {
      return null;
    }
  }
}

Map<String, String> _buildModuleRoots(
  String repositoryRoot,
  ArchitectureConfig config,
) => {
  for (final module in config.modules.values)
    module.name: p.normalize(
      p.absolute(p.join(repositoryRoot, module.path)),
    ),
};

Map<String, Set<String>> _buildAllowedDependencies(
  ArchitectureConfig config,
) => {
  for (final module in config.modules.values)
    module.name: Set.unmodifiable(
      {
        for (final groupName in module.allowedGroups)
          ...config.groups[groupName]?.modules ?? const <String>[],
      }..remove(module.name),
    ),
};
