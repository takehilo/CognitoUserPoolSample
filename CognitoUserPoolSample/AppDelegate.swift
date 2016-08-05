import UIKit
import AWSCore
import AWSCognitoIdentityProvider

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AWSCognitoIdentityInteractiveAuthenticationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        print("#### AppDelegate:application:didFinishLaunchingWithOptions:")
        
        AWSLogger.defaultLogger().logLevel = .Debug

        AwsClientManager.sharedInstance.initialize(self)

        return true
    }

    func startPasswordAuthentication() -> AWSCognitoIdentityPasswordAuthentication {
        print("#### AppDelegate:startPasswordAuthentication:")

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        dispatch_async(dispatch_get_main_queue()) {
            self.window?.rootViewController?.presentViewController(vc, animated: true, completion: nil)
        }
        return vc
    }

}

