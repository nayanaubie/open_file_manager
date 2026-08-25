import 'open_file_manager.dart';
import 'src/core/open_file_manager_platform_interface.dart';

export 'src/models/models.dart';

/// Opens the default file manager app.
Future<bool> openFileManager({
  /// Configuration for Android platform
  AndroidConfig? androidConfig,

  /// Configuration for iOS platform
  IosConfig? iosConfig,
}) {
  return OpenFileManagerPlatform.instance.openFileManager(
    androidConfig: androidConfig,
    iosConfig: iosConfig,
  );
}
