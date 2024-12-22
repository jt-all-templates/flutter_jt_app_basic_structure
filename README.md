# Using `jt_app_basic_structure` as a Starter Template

This guide helps you quickly set up a new Flutter application using the reusable structure from the `jt_app_basic_structure` project.

---

## Steps to Kick-Start a New App

### 1. Create a New Flutter Project
Start by creating a new Flutter project with the desired name:
```bash
flutter create my_new_app
```

### 2. Copy Template Files
Replace the default files in your newly created project with the reusable template:
- Copy the following folders and files from the `jt_app_basic_structure` project into your new app's root directory:
  ```
  lib/
  assets/
  pubspec.yaml
  ```
- Overwrite any existing files.

---

### 3. Replace Package Name
The project contains references to the original package name (`jt_app_basic_structure`). You need to replace it with your new app's package name.

1. **Search and Replace**:
   - Use your code editor or tools to search for all occurrences of `jt_app_basic_structure` and replace them with your new app's package name.

2. **Command-Line Example**:
   On Linux or macOS:
   ```bash
   grep -rl "jt_app_basic_structure" . | xargs sed -i '' 's/jt_app_basic_structure/my_new_app/g'
   ```

---

### 4. Update the `pubspec.yaml` File
1. Open the `pubspec.yaml` file.
2. Check if any packages in the `pubspec.yaml` are outdated and update them as needed:
   ```bash
   flutter pub outdated
   ```

4. Fetch dependencies:
   ```bash
   flutter pub get
   ```

---

### 5. Run Your App
Launch your app to ensure everything is set up correctly:
```bash
flutter run
```

---


This workflow helps you quickly initialize new Flutter projects using the `jt_app_basic_structure` template. 🎉