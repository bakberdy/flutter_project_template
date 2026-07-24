# Repository tools

Repository automation is split by responsibility:

- `scripts/` contains Bash scripts that only orchestrate commands
  sequentially.
- `validation/` contains Dart validation tools.
- `generation/` contains Dart tools that create or transform repository files.

Use `snake_case` for both shell and Dart filenames.

`validation/run_changed_tests.dart` runs tests only in changed testable
packages. Pass the comparison revision with `--base <git-revision>`.

## Bootstrap a project

Edit the top-level values in `project.yaml`, then preview the changes:

```bash
dart run tool/generation/bootstrap_project.dart --dry-run
```

Review the dry-run output, then repeat without `--dry-run`. You can edit
`project.yaml` and run the command again whenever the project identity changes.
Do not edit its script-managed `applied` section. The generator:

- reads the project name, display name, organization, application ID, and
  Apple team from `project.yaml`;
- updates Android and iOS identifiers, the Apple team, Fastlane, workflows,
  and deployment documentation;
- moves `MainActivity.kt` to its matching Android package;
- updates mobile and admin display names, admin web metadata, and localized
  admin titles;
- updates the `applied` section in `project.yaml` after changing the project;
- resolves dependencies, regenerates admin localization, formats, and analyzes
  the workspace.

Use `--no-codegen` only when Flutter tooling is unavailable. Generated
localization must be refreshed before committing.
