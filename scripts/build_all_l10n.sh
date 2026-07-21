#!/usr/bin/env bash

set -euo pipefail

repository_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repository_root"

packages=()

for package in apps/* modules/*; do
  if [[ -f "$package/pubspec.yaml" && -f "$package/l10n.yaml" ]]; then
    packages+=("$package")
  fi
done

if [[ ${#packages[@]} -eq 0 ]]; then
  echo "No app or module localization configurations found."
  exit 0
fi

echo "Generating localizations for ${#packages[@]} packages..."

for package in "${packages[@]}"; do
  echo
  echo "==> $package"
  (cd "$package" && flutter gen-l10n)
done

echo
echo "All app and module localizations generated successfully."
