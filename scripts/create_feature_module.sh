#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'USAGE'
Create a feature module using the repository architecture contract.

Usage:
  ./scripts/create_feature_module.sh <module_name> [options]

Options:
  --feature <feature_name>  Initial feature directory. Defaults to module_name.
  --description <text>      Package description.
  --no-codegen              Skip pub get, generators, format, and analyze.
  --root <path>             Repository root. Defaults to auto-detection.
  -h, --help                Show this help.

Examples:
  ./scripts/create_feature_module.sh client_orders
  ./scripts/create_feature_module.sh admin_reports --feature reports
USAGE
}

usage_error() {
  printf '%s\n\n' "$1" >&2
  usage >&2
  exit 64
}

option_value() {
  local option="$1"
  local value="${2:-}"
  if [[ -z "$value" || "$value" == -* ]]; then
    usage_error "$option requires a value."
  fi
  printf '%s' "$value"
}

validate_name() {
  local value="$1"
  local label="$2"
  if [[ ! "$value" =~ ^[a-z][a-z0-9]*(_[a-z][a-z0-9]*)*$ ]]; then
    usage_error "$label must use lower snake_case and start with a letter: $value"
  fi
}

to_pascal_case() {
  local value="$1"
  local result=''
  local part
  local first
  local rest
  local old_ifs="$IFS"
  IFS='_'
  for part in $value; do
    first="$(printf '%s' "${part:0:1}" | tr '[:lower:]' '[:upper:]')"
    rest="${part:1}"
    result="${result}${first}${rest}"
  done
  IFS="$old_ifs"
  printf '%s' "$result"
}

find_repository_root() {
  local current
  local parent
  current="$(pwd -P)"

  while true; do
    if [[ -f "$current/pubspec.yaml" && -d "$current/modules" ]] &&
      grep -q '^workspace:' "$current/pubspec.yaml"; then
      printf '%s' "$current"
      return
    fi

    parent="$(dirname -- "$current")"
    if [[ "$parent" == "$current" ]]; then
      printf 'Could not find the repository root from %s.\n' "$(pwd -P)" >&2
      exit 1
    fi
    current="$parent"
  done
}

run_command() {
  local working_directory="$1"
  shift
  printf '\n> '
  printf '%q ' "$@"
  printf '\n'
  (cd "$working_directory" && "$@")
}

module_name=''
feature_name=''
description=''
repository_root=''
run_codegen=true

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h | --help)
      usage
      exit 0
      ;;
    --feature)
      feature_name="$(option_value "$1" "${2:-}")"
      shift 2
      ;;
    --description)
      description="$(option_value "$1" "${2:-}")"
      shift 2
      ;;
    --root)
      repository_root="$(option_value "$1" "${2:-}")"
      shift 2
      ;;
    --no-codegen)
      run_codegen=false
      shift
      ;;
    -*)
      usage_error "Unknown option: $1"
      ;;
    *)
      if [[ -n "$module_name" ]]; then
        usage_error 'Only one module_name is allowed.'
      fi
      module_name="$1"
      shift
      ;;
  esac
done

if [[ -z "$module_name" ]]; then
  usage_error 'module_name is required.'
fi

validate_name "$module_name" 'module_name'
feature_name="${feature_name:-$module_name}"
validate_name "$feature_name" 'feature_name'

if [[ -n "$repository_root" ]]; then
  requested_repository_root="$repository_root"
  if ! repository_root="$(cd -- "$requested_repository_root" 2>/dev/null && pwd -P)"; then
    printf 'Repository root does not exist: %s\n' "$requested_repository_root" >&2
    exit 1
  fi
else
  repository_root="$(find_repository_root)"
fi

if [[ ! -f "$repository_root/pubspec.yaml" ]]; then
  printf 'Root pubspec.yaml was not found in %s.\n' "$repository_root" >&2
  exit 1
fi
if [[ ! -d "$repository_root/modules" ]]; then
  printf 'Modules directory was not found in %s.\n' "$repository_root" >&2
  exit 1
fi

module_directory="$repository_root/modules/$module_name"
if [[ -e "$module_directory" ]]; then
  printf 'Module already exists: %s\n' "$module_directory" >&2
  exit 1
fi

module_class="$(to_pascal_case "$module_name")"
generated_asset_type="\$Assets${module_class}Gen"
generated_asset_getter="${module_class:0:1}"
generated_asset_getter="$(printf '%s' "$generated_asset_getter" | tr '[:upper:]' '[:lower:]')${module_class:1}"
description="${description:-$module_class feature module.}"

mkdir -p \
  "$module_directory/assets/$module_name/icons" \
  "$module_directory/assets/$module_name/images" \
  "$module_directory/assets/$module_name/files" \
  "$module_directory/lib/l10n" \
  "$module_directory/lib/src/common/config/di" \
  "$module_directory/lib/src/features/$feature_name/data" \
  "$module_directory/lib/src/features/$feature_name/domain" \
  "$module_directory/lib/src/features/$feature_name/presentation" \
  "$module_directory/test/common" \
  "$module_directory/test/features/$feature_name"

cat >"$module_directory/README.md" <<EOF
# $module_name

$description

The package follows \`docs/architecture/feature-module-structure.md\`.
Localization and generated module assets are available internally through
\`context.l10n\` and \`context.assets\`. Internal context, assets, constants,
endpoints, and navigation paths must not be exported from the package barrel.

EOF

cat >"$module_directory/pubspec.yaml" <<EOF
name: $module_name
description: $description
publish_to: none
version: 0.1.0
resolution: workspace

environment:
  sdk: ^3.12.0
  flutter: ">=3.44.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  core:
    path: ../core
  design_system:
    path: ../design_system
  shared:
    path: ../shared
  dartz: ^0.10.1
  equatable: ^2.0.8
  flutter_bloc: ^9.1.1
  freezed_annotation: ^3.1.0
  get_it: ^9.2.0
  injectable: ^3.0.0
  intl: ^0.20.2
  json_annotation: ^4.12.0

dev_dependencies:
  build_runner: ^2.13.0
  flutter_gen_runner: ^5.13.0+1
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  freezed: ^3.2.5
  injectable_generator: ^3.0.2
  json_serializable: ^6.13.0
  mocktail: ^1.0.5

flutter:
  generate: true
  assets:
    - assets/$module_name/

flutter_gen:
  assets:
    outputs:
      package_parameter_enabled: true
EOF

cat >"$module_directory/build.yaml" <<'EOF'
targets:
  $default:
    builders:
      json_serializable:
        options:
          field_rename: snake

      freezed:
        generate_for:
          - lib/src/features/**/domain/entities/**.dart
          - lib/src/features/**/presentation/blocs/**.dart
        options:
          to_json: false
          from_json: false
          when: false
          map: false

      injectable_generator:injectable_builder:
        options:
          auto_register: true
          generate_for_injectable: true

      flutter_gen_runner:
        options:
          output: lib/gen/
          line_length: 80
EOF

cat >"$module_directory/l10n.yaml" <<EOF
arb-dir: lib/l10n
template-arb-file: ${module_name}_en.arb
output-dir: lib/gen/l10n
output-localization-file: ${module_name}_localizations.dart
output-class: ${module_class}Localizations
nullable-getter: false
EOF

cat >"$module_directory/lib/$module_name.dart" <<EOF
library;

export 'gen/l10n/${module_name}_localizations.dart';
export 'src/common/config/di/${module_name}_di.dart';
export 'src/common/config/di/${module_name}_di.module.dart';

EOF

for locale in en kk ru; do
  cat >"$module_directory/lib/l10n/${module_name}_${locale}.arb" <<EOF
{
  "@@locale": "$locale"
}

EOF
done

cat >"$module_directory/lib/src/common/${module_name}_context_x.dart" <<EOF
import 'package:$module_name/gen/assets.gen.dart';
import 'package:$module_name/gen/l10n/${module_name}_localizations.dart';
import 'package:flutter/widgets.dart';

extension ${module_class}ContextX on BuildContext {
  ${module_class}Localizations get l10n =>
      ${module_class}Localizations.of(this);

  $generated_asset_type get assets => Assets.$generated_asset_getter;
}

EOF

cat >"$module_directory/lib/src/common/config/di/${module_name}_di.dart" <<EOF
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '${module_name}_di.module.dart';

@InjectableInit.microPackage()
Future<void> configure${module_class}Dependencies() async =>
    ${module_class}PackageModule().init(GetItHelper(GetIt.instance));

EOF

cat >"$module_directory/test/common/${module_name}_context_x_test.dart" <<EOF
import 'package:$module_name/gen/assets.gen.dart';
import 'package:$module_name/gen/l10n/${module_name}_localizations.dart';
import 'package:$module_name/src/common/${module_name}_context_x.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('exposes generated localization and assets', (tester) async {
    await tester.pumpWidget(
      Localizations(
        locale: const Locale('en'),
        delegates: const [
          DefaultWidgetsLocalizations.delegate,
          ${module_class}Localizations.delegate,
        ],
        child: Builder(
          builder: (context) {
            expect(context.l10n, isA<${module_class}Localizations>());
            expect(context.assets, same(Assets.$generated_asset_getter));
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  });
}

EOF

touch \
  "$module_directory/assets/$module_name/.gitkeep" \
  "$module_directory/assets/$module_name/icons/.gitkeep" \
  "$module_directory/assets/$module_name/images/.gitkeep" \
  "$module_directory/assets/$module_name/files/.gitkeep" \
  "$module_directory/lib/src/features/$feature_name/data/.gitkeep" \
  "$module_directory/lib/src/features/$feature_name/domain/.gitkeep" \
  "$module_directory/lib/src/features/$feature_name/presentation/.gitkeep" \
  "$module_directory/test/features/$feature_name/.gitkeep"

workspace_entry="  - modules/$module_name"
if ! grep -Fxq "$workspace_entry" "$repository_root/pubspec.yaml"; then
  WORKSPACE_ENTRY="$workspace_entry" perl -0pi -e '
    my $entry = $ENV{WORKSPACE_ENTRY};
    s/(^workspace:\n(?:[ \t]+.*\n)*)/$1$entry\n/m
      or die "Root pubspec.yaml does not define a workspace.\n";
  ' "$repository_root/pubspec.yaml"
fi

printf 'Repository: %s\n' "$repository_root"
printf 'Created modules/%s.\n' "$module_name"

if [[ "$run_codegen" == false ]]; then
  printf 'Code generation skipped (--no-codegen).\n'
  exit 0
fi

run_command "$repository_root" flutter pub get
run_command "$module_directory" flutter gen-l10n
run_command "$module_directory" dart run build_runner build
run_command "$module_directory" dart format lib test
run_command "$module_directory" flutter analyze

printf 'Module %s is generated and validated.\n' "$module_name"
