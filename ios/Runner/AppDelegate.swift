import UIKit
import Flutter

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        return true
    }

    override func applicationDidEnterBackground(_ application: UIApplication) {
        // Ilova fon rejimiga o'tganda bajariladigan kod
    }

    override func applicationWillEnterForeground(_ application: UIApplication) {
        // Ilova fon rejimidan qaytganida bajariladigan kod
    }
}
