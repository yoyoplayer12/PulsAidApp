import UIKit
import Flutter
import GoogleMaps

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
        GMSServices.provideAPIKey("AIzaSyANpL7kEInnJvZJmvSPJibifvk7RiUvmDU")
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
