import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:project_lints/src/architecture/architecture_config.dart';

typedef ArchitecturePolicyResolver =
    ArchitecturePolicy? Function(String filePath);

class ArchitecturePolicy {
  const ArchitecturePolicy({
    required this.repositoryRoot,
    required this.config,
  });

  final String repositoryRoot;
  final ArchitectureConfig config;

  ModuleConfig? moduleForPath(String filePath) {
    final normalizedFile = p.normalize(p.absolute(filePath));
    for (final module in config.modules.values) {
      final moduleRoot = p.normalize(
        p.absolute(p.join(repositoryRoot, module.path)),
      );
      if (normalizedFile == moduleRoot ||
          p.isWithin(moduleRoot, normalizedFile)) {
        return module;
      }
    }
    return null;
  }

  Set<String> allowedDependenciesFor(ModuleConfig module) {
    final allowed = <String>{};
    for (final groupName in module.allowedGroups) {
      allowed.addAll(config.groups[groupName]?.modules ?? const []);
    }
    allowed.remove(module.name);
    return allowed;
  }

  bool isDependencyAllowed(ModuleConfig module, String dependencyName) {
    if (!config.modules.containsKey(dependencyName)) return true;
    return dependencyName != module.name &&
        allowedDependenciesFor(module).contains(dependencyName);
  }

  String? featureForPath(ModuleConfig module, String filePath) {
    final moduleRoot = p.normalize(
      p.absolute(p.join(repositoryRoot, module.path)),
    );
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
  String? _cachedPath;
  DateTime? _cachedModifiedAt;
  ArchitecturePolicy? _cachedPolicy;

  ArchitecturePolicy? resolve(String filePath) {
    var directory = Directory(p.dirname(p.absolute(filePath)));
    while (true) {
      final configFile = File(p.join(directory.path, 'architecture.yaml'));
      if (configFile.existsSync()) {
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
      if (_cachedPath == configFile.path && _cachedModifiedAt == modifiedAt) {
        return _cachedPolicy;
      }

      final result = ArchitectureConfigParser().parse(
        configFile.readAsStringSync(),
        sourceName: configFile.path,
      );
      final config = result.config;
      final policy = config == null
          ? null
          : ArchitecturePolicy(repositoryRoot: repositoryRoot, config: config);
      _cachedPath = configFile.path;
      _cachedModifiedAt = modifiedAt;
      _cachedPolicy = policy;
      return policy;
    } on FileSystemException {
      return null;
    }
  }
}
