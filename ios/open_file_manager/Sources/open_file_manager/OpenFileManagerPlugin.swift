import Flutter
import UIKit

/// This is the main entry point for the Flutter plugin.
/// It manages the method calls from Flutter & sets results accordingly.
public class OpenFileManagerPlugin: NSObject, FlutterPlugin {

    /// Initializes method channel and register method call delegate.
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "open_file_manager", binaryMessenger: registrar.messenger())
        let instance = OpenFileManagerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    /// Handles method calls received from Dart.
    public func handle(
        _ call: FlutterMethodCall, result: @escaping FlutterResult
    ) {
        switch call.method {
        case "openFileManager":
            let arguments = call.arguments as? [String: Any]
            let folderPath = arguments?["folderPath"] as? String
            openFileManager(result: result, folderPath: folderPath)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    /// Opens the app's Documents folder or one of its sub-folders.
    ///
    /// On iPhone/iPad this opens the Files app. On an Apple-silicon Mac the app
    /// runs as a "Designed for iPad" app, where the Files URL scheme does not
    /// exist, so a `file://` URL is handed to LaunchServices which opens Finder.
    ///
    /// - Parameters:
    ///   - result: Result of the method call.
    ///   - folderPath: Sub-folder path received from Dart.
    func openFileManager(result: @escaping FlutterResult, folderPath: String?) {
        let documents = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask)[0]

        // iOS/iPadOS app running on an Apple-silicon Mac ("Designed for iPad").
        // `shareddocuments://` only exists in the iOS runtime, so hand a real
        // `file://` URL to LaunchServices; Finder is the default handler for
        // folders on macOS. Only paths inside the app's own container can be
        // opened because the app is sandboxed.
        if #available(iOS 14.0, *), ProcessInfo.processInfo.isiOSAppOnMac {
            var folder = documents
            if let folderPath = folderPath, !folderPath.isEmpty {
                folder.appendPathComponent(folderPath, isDirectory: true)
            }
            UIApplication.shared.open(folder, options: [:]) { success in
                result(success)
            }
            return
        }

        // iPhone/iPad: open the Files app.
        // Keep the original URL construction: replace file:// with shareddocuments://
        var documentProviderPath = documents.absoluteString.replacingOccurrences(
            of: "file://", with: "shareddocuments://")
        if let folderPath = folderPath, !folderPath.isEmpty {
            documentProviderPath.append(
                folderPath.addingPercentEncoding(
                    withAllowedCharacters: .urlPathAllowed) ?? folderPath)
        }

        guard let url = URL(string: documentProviderPath) else {
            result(
                FlutterError(
                    code: "invalid_url",
                    message: "Unable to build a documents URL",
                    details: documentProviderPath))
            return
        }

        UIApplication.shared.open(url) { success in
            result(success)
        }
    }
}
