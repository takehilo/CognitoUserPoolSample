import UIKit
import AWSCore
import AWSCognitoIdentityProvider

class LoginViewController: UIViewController, AWSCognitoIdentityPasswordAuthentication {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var lastKnownUsername: String?
    var passwordAuthenticationCompletion: AWSTaskCompletionSource?

    override func viewWillAppear(animated: Bool) {
        print("#### LoginViewController:viewWillAppear:")
        super.viewWillAppear(animated)

        self.usernameField.text = self.lastKnownUsername
        self.passwordField.text = nil
    }

    @IBAction func loginTapped(sender: AnyObject) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        let username = self.usernameField.text!
        let password = self.passwordField.text!
        if username.isEmpty || password.isEmpty {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            self.showAlert(title: "ログインエラー", message: "ユーザ名とパスワードは必須です。")
        } else {
            let result = AWSCognitoIdentityPasswordAuthenticationDetails(username: username, password: password)
            self.passwordAuthenticationCompletion?.setResult(result)  // ここでCognito通信
        }
    }

    func getPasswordAuthenticationDetails(authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource) {
        print("#### LoginViewController:getPasswordAuthenticationDetails:passwordAuthenticationCompletionSource:")

        self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource
        self.lastKnownUsername = authenticationInput.lastKnownUsername
    }

    func didCompletePasswordAuthenticationStepWithError(error: NSError) {
        print("#### LoginViewController:didCompletePasswordAuthenticationStepWithError:")

        dispatch_async(dispatch_get_main_queue()) {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false

            if error.code != 0 {
                self.showAlert(title: "ログインエラー")
            } else {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }

    func showAlert(title title: String, message: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }

}

