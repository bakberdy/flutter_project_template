#!/usr/bin/env bash

set -euo pipefail

repository_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$repository_root"

flutter_packages=()
dart_packages=()

for package in apps/* modules/*; do
  if [[ -f "$package/pubspec.yaml" && -d "$package/test" ]]; then
    flutter_packages+=("$package")
  fi
done

for package in packages/*; do
  if [[ -f "$package/pubspec.yaml" && -d "$package/test" ]]; then
    dart_packages+=("$package")
  fi
done

test_suite_count=$((${#flutter_packages[@]} + ${#dart_packages[@]}))
if [[ $test_suite_count -eq 0 ]]; then
  echo "No test suites found."
  exit 0
fi

echo "Running $test_suite_count test suites..."

for package in "${flutter_packages[@]}"; do
  echo
  echo "==> $package"
  flutter test "$package"
done

for package in "${dart_packages[@]}"; do
  echo
  echo "==> $package"
  (
    cd "$package"
    dart pub get
    dart test
  )
done

echo
echo "All test suites passed."
