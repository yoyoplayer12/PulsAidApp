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
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            if let apiKey = dict["API_KEY"] as? String {
                GMSServices.provideAPIKey(apiKey)
            }
        }        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
