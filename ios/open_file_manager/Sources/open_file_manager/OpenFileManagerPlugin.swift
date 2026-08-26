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
            let dict = call.arguments as? NSDictionary
            let folderPath = dict?["folderPath"] as? String? ?? nil
            openFileManager(result: result, folderPath: folderPath)
        default:
            result(FlutterMethodNotImplemented)
        }
        guard call.method == "openFileManager" else {
            result(FlutterMethodNotImplemented)
            return
        }
    }

    /// Opens the Files app using UIApplication.
    /// - Parameters:
    ///   - result: Result of the method call.
    ///   - folderPath: Sub-folder path receveid from Dart.
    func openFileManager(result: @escaping FlutterResult, folderPath: String?) {
        let paths = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask)

        var documentProviderPath = paths[0].absoluteString.replacingOccurrences(
            of: "file://", with: "shareddocuments://")
        documentProviderPath.append(folderPath ?? "")

        UIApplication.shared.open(URL(string: documentProviderPath)!)
        result(true)
    }
}
