# Bug Fix Documentation - Enrollment Provider Disposal Error

## Date Fixed
November 19, 2025

## Bug Description
**Error Message:**
```
Cannot use the Ref of enrollmentActionsProvider after it has been disposed.
This typically happens if:
- A provider rebuilt, but the previous "build" was still pending and is still performing operations.
```

**Symptoms:**
- Red error dialog appeared when enrolling in subjects
- Enrollment worked but UI didn't update
- Error occurred consistently on both web and Android

## Root Cause
The `EnrollmentActions` was implemented as a **class-based Riverpod provider** with lifecycle methods (build/dispose). When `ref.invalidate()` was called inside the provider's async methods, Riverpod would sometimes dispose the provider before the invalidation completed, causing the disposal error.

## Solution Applied

### 1. Changed Provider Architecture
**Before (Class-based - CAUSED ERRORS):**
```dart
@riverpod
class EnrollmentActions extends _$EnrollmentActions {
  @override
  void build() {}
  
  Future<String> enrollInSubject(String subjectId) async {
    // ... enrollment logic
    ref.invalidate(studentEnrollmentsProvider); //  CAUSED DISPOSAL ERROR
    return AppConstants.enrollSuccess;
  }
}
```

**After (Function-based - FIXED):**
```dart
@riverpod
Future<String> enrollInSubject(Ref ref, String subjectId) async {
  // ... enrollment logic
  // No invalidation here - UI handles it
  return AppConstants.enrollSuccess;
}

@riverpod
Future<String> dropSubject(Ref ref, String subjectId) async {
  // ... drop logic
  return 'Drop request submitted - pending admin approval';
}
```

### 2. Moved Provider Invalidation to UI Layer
**File:** `lib/presentation/screens/subject_list_screen.dart`

```dart
Future<void> _handleEnroll(Subject subject) async {
  // ... confirmation dialog
  
  try {
    // Call the function provider
    final result = await ref.read(enrollInSubjectProvider(subject.id).future);
    if (!mounted) return;
    
    final isSuccess = result.toLowerCase().contains('success');
    
    // ✅ SAFE: Invalidate AFTER the provider completes
    if (isSuccess) {
      ref.invalidate(studentEnrollmentsProvider);
      ref.invalidate(enrolledSubjectsProvider);
      ref.invalidate(totalEnrolledUnitsProvider);
      ref.invalidate(firstYearSubjectsProvider);
      ref.invalidate(majorSubjectsProvider);
      ref.invalidate(minorSubjectsProvider);
    }
    
    setState(() {
      _enrollingSubjectId = null;
    });
    
    // Show success message
  } catch (e) {
    // Handle error
  }
}
```

### 3. Updated My Subjects Screen
**File:** `lib/presentation/screens/my_subjects_screen.dart`

Changed from:
```dart
final enrollmentActions = ref.read(enrollmentActionsProvider.notifier);
final result = await enrollmentActions.dropSubject(subject.id);
```

To:
```dart
final result = await ref.read(dropSubjectProvider(subject.id).future);
```

## Files Modified

1. **`lib/providers/enrollment_provider.dart`**
   - Removed `EnrollmentActions` class
   - Added `enrollInSubject` function provider
   - Added `dropSubject` function provider
   - Removed all `ref.invalidate()` calls from providers

2. **`lib/presentation/screens/subject_list_screen.dart`**
   - Updated `_handleEnroll` to use `enrollInSubjectProvider`
   - Added `ref.invalidate()` calls after successful enrollment
   - Removed `enrollmentActionsProvider.notifier` usage

3. **`lib/presentation/screens/my_subjects_screen.dart`**
   - Updated `_handleDrop` to use `dropSubjectProvider`
   - Removed `enrollmentActionsProvider.notifier` usage

4. **`lib/presentation/screens/register_screen.dart`**
   - Reduced spacing between form fields (12px → 8px)
   - Made dropdowns more compact with `isDense: true`
   - Reduced dropdown font size (12px → 11px)
   - Increased bottom padding (80px → 100px)

## Critical Steps After Code Changes

**ALWAYS run this command after modifying provider files:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

This regenerates the `.g.dart` files which contain the actual provider implementations.

## Why This Fix Works

1. **Function providers have no lifecycle** - They don't have build/dispose methods, so no disposal errors
2. **Invalidation happens AFTER completion** - The provider finishes executing before we refresh other providers
3. **UI controls the refresh** - The presentation layer decides when to refresh data, not the business logic layer

## Testing Checklist

- [x] Enroll in a subject - no error dialog
- [x] UI updates immediately after enrollment
- [x] "My Subjects" screen shows enrolled subjects
- [x] Unit count updates correctly
- [x] Drop subject functionality works
- [x] Registration form doesn't overflow on Android

## Prevention Tips

1. **Never call `ref.invalidate()` inside async provider methods**
2. **Use function-based providers for one-time operations** (like enrollment)
3. **Use class-based providers only for stateful operations** that need lifecycle management
4. **Always run `build_runner` after modifying `@riverpod` annotated files**
5. **Test on both web and Android** - caching behaves differently

## Related Issues

- Gradle build failure due to spaces in Windows username path
  - **Solution:** Move project to path without spaces (e.g., `C:\Projects\`)
  
- Hot reload not applying changes
  - **Solution:** Use hot restart (R) or full rebuild after provider changes

## Contact
If this error reappears, review this document and ensure:
1. All provider files use function-based providers for actions
2. `ref.invalidate()` is only called in UI layer after async completion
3. `.g.dart` files are regenerated with build_runner

---
**Last Updated:** November 19, 2025, 2:42 AM
**Status:** ✅ FIXED AND VERIFIED
