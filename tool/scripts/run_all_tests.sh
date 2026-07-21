#!/usr/bin/env bash

set -euo pipefail

repository_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$repository_root"

packages=()

for package in apps/* modules/*; do
  if [[ -f "$package/pubspec.yaml" && -d "$package/test" ]]; then
    packages+=("$package")
  fi
done

if [[ ${#packages[@]} -eq 0 ]]; then
  echo "No app or module test suites found."
  exit 0
fi

echo "Running ${#packages[@]} test suites..."

for package in "${packages[@]}"; do
  echo
  echo "==> $package"
  flutter test "$package"
done

echo
echo "All app and module test suites passed."
