import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    // Initialize allowsBackgroundLocationUpdates to true by default
    var allowsBackgroundLocationUpdates: Bool = true
    
    // Initialize showsBackgroundLocationIndicator to true by default
    var showsBackgroundLocationIndicator: Bool = true
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
