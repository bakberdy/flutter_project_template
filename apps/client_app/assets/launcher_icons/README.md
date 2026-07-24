# Client launcher icon sources

Add one square PNG for each client flavor:

- `development.png`
- `production.png`

Use 1024 x 1024 source images. Keep important artwork away from the outer edge
because Android launchers may mask the generated icon. The iOS generator removes
alpha transparency.

From the repository root, generate both Android and iOS flavor icons with:

```bash
make client-icons
```

Generated Android resources are written under each flavor's `android/app/src/`
directory. Generated iOS catalogs are written under `ios/Runner/Assets.xcassets`
and selected by the matching Xcode build configuration.
