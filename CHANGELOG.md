## 2.1.0
- Added support of Swift Package Manager (SPM) in iOS.

## 2.0.2
- Migration to `Built-in-Kotlin` for Android plugin.
- Fixed deprecated code in the example app.

## 2.0.1
- Fix source files using `dart format .`

## 2.0.0
- Set minimum Dart SDK to `3.7.0`.
- Upgrade Android platform to use `kts` script.

**NEW FEATURES:**
- Added support of opening specific folder in `Android`. `AndroidFolderType.other` should be used along with `folderPath` in `AndroidConfig`.

**BREAKING CHANGES:**
- The `FolderType` enum is renamed to `AndroidFolderType` for Android.
- Removed the `required` keyword from `folderType` param in `AndroidConfig`; `AndroidFolderType.download` is now used as the default value.
- `subFolderPath` param in `IosConfig` is renamed to `folderPath` and is now **optional**.

## 1.1.1
- Added doc comments in source files.

## 1.1.0
- Upgrade Android configuration to support latest Gradle version.
- Upgrade cocoapods to the latest version in iOS example app.

## 1.0.3
- Added namespace in `android/build.gradle` to support new Gradle versions.

## 1.0.2
- Updated `Flutter linter` & `Dart analysis`.

## 1.0.1
- Added videos in `Preview`

## 1.0.0
- Added support of opening `Recent` folder in `Android` and any `sub-folder` inside app's document in `iOS`

## 0.0.4
- Upload preview

## 0.0.3
- Upgrade platform related files.
- Upgrade kotlin version to "1.9.10"
- Upgrade iOS deployment target to "12"

## 0.0.2
- Update description

## 0.0.1
- Initial release.