# Sync Checklist - Before Committing Changes

## ✅ Files Verification

### Critical Files (MUST be updated)
- [ ] `my_course_app/lib/providers/enrollment_provider.dart`
  - Uses function-based providers (`Future<String> enrollInSubject(Ref ref, String subjectId)`)
  - No `ref.invalidate()` inside providers
  - Has `@riverpod` annotations

- [ ] `my_course_app/lib/providers/enrollment_provider.g.dart`
  - Generated file exists
  - Contains `enrollInSubjectProvider` and `dropSubjectProvider`

- [ ] `my_course_app/lib/presentation/screens/subject_list_screen.dart`
  - Uses `ref.read(enrollInSubjectProvider(subject.id).future)`
  - Has `ref.invalidate()` calls AFTER successful enrollment
  - No `enrollmentActionsProvider.notifier`

- [ ] `my_course_app/lib/presentation/screens/my_subjects_screen.dart`
  - Uses `ref.read(dropSubjectProvider(subject.id).future)`
  - No `enrollmentActionsProvider.notifier`

- [ ] `my_course_app/lib/presentation/screens/register_screen.dart`
  - Spacing between fields is 8px
  - Dropdowns have `isDense: true`
  - Bottom padding is 100px

### Configuration Files
- [ ] `my_course_app/pubspec.yaml` - Dependencies up to date
- [ ] `my_course_app/pubspec.lock` - Lock file present
- [ ] `my_course_app/android/gradle.properties` - Gradle settings configured

### Documentation
- [ ] `README.md` - Project overview and setup instructions
- [ ] `my_course_app/BUGFIX_DOCUMENTATION.md` - Bug fix details
- [ ] `SYNC_CHECKLIST.md` - This file

## 🔧 Pre-Commit Commands

Run these commands before committing:

```bash
# 1. Navigate to project
cd my_course_app

# 2. Get dependencies
flutter pub get

# 3. Generate provider files
dart run build_runner build --delete-conflicting-outputs

# 4. Format code
dart format .

# 5. Analyze code
flutter analyze

# 6. Test (if tests exist)
flutter test
```

## 🚫 Files to Exclude from Git

Add to `.gitignore`:
```
# Build outputs
build/
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages

# Generated files
*.g.dart
*.freezed.dart

# IDE
.idea/
.vscode/
*.iml

# Platform specific
android/.gradle/
android/local.properties
ios/Pods/
ios/.symlinks/

# Other
.DS_Store
pubspec.lock  # Optional - some include this
```

## 📋 Testing Checklist

Before pushing to repository:

### Web (Edge/Chrome)
- [ ] App launches without errors
- [ ] Login works
- [ ] Registration works (no overflow)
- [ ] Browse subjects loads
- [ ] Enrollment works (no disposal error)
- [ ] UI updates after enrollment
- [ ] My Subjects shows enrolled courses
- [ ] Drop subject works

### Android Emulator
- [ ] App builds successfully
- [ ] Registration form doesn't overflow
- [ ] All features work as on web
- [ ] No performance issues

## 🔄 Git Commands

```bash
# Check status
git status

# Add all changes
git add .

# Commit with message
git commit -m "Fix: Resolved enrollment provider disposal error - Changed to function-based providers"

# Push to repository
git push origin main
```

## ⚠️ Important Notes

1. **Never commit `.g.dart` files** - They should be generated locally
2. **Always run build_runner** after pulling changes to provider files
3. **Test on both web and Android** before marking as complete
4. **Document any new bugs** in BUGFIX_DOCUMENTATION.md

## 📞 Emergency Rollback

If the app breaks after sync:

```bash
# Revert last commit
git revert HEAD

# Or reset to previous commit
git reset --hard HEAD~1

# Force push (use with caution)
git push --force
```

---

**Last Updated:** November 19, 2025, 2:45 AM
**Verified By:** Development Team
**Status:** ✅ Ready for Sync
