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

Run the bootstrap generator once after creating a repository from this
template:

```bash
dart run tool/generation/bootstrap_project.dart my_app \
  --display-name "My App" \
  --organization com.acme \
  --ios-team ABCDE12345 \
  --dry-run
```

Review the dry-run output, then repeat without `--dry-run`. The generator:

- derives `com.acme.myapp` unless `--application-id` is provided;
- updates Android and iOS identifiers, the Apple team, Fastlane, workflows,
  and deployment documentation;
- moves `MainActivity.kt` to its matching Android package;
- updates mobile and admin display names, admin web metadata, and localized
  admin titles;
- writes `project.json` as the resulting project-identity record;
- resolves dependencies, regenerates admin localization, formats, and analyzes
  the workspace.

Use `--no-codegen` only when Flutter tooling is unavailable. Generated
localization must be refreshed before committing.
