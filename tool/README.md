# Repository tools

Repository automation is split by responsibility:

- `scripts/` contains Bash scripts that only orchestrate commands
  sequentially.
- `validation/` contains Dart validation tools.
- `generation/` contains Dart tools that create or transform repository files.

Use `snake_case` for both shell and Dart filenames.
