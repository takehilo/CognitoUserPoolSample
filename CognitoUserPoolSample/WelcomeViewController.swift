import UIKit
import AWSLambda

class WelcomeViewController: UIViewController {
    @IBOutlet weak var userLabel: UILabel!

    override func viewDidLoad() {
        print("#### WelcomeViewController:viewDidLoad")
        super.viewDidLoad()

        self.refresh()
    }

    override func viewWillAppear(animated: Bool) {
        print("#### WelcomeViewController:viewWillAppear:")
        super.viewWillAppear(animated)

    }

    @IBAction func logoutTapped(sender: AnyObject) {
        print("#### WelcomeViewController:logoutTapped:")

        AwsClientManager.sharedInstance.signOut()
        self.refresh()
    }

    func refresh() {
        print("#### WelcomeViewController:refresh")

        AwsClientManager.sharedInstance.currentUser?.getSession().continueWithSuccessBlock {
            (task: AWSTask!) -> AnyObject? in
            dispatch_async(dispatch_get_main_queue()) {
                self.userLabel.text = AwsClientManager.sharedInstance.currentUser?.username
            }
            return nil
        }

//        let lambda = AWSLambdaInvoker.defaultLambdaInvoker()
//        let request = AWSLambdaInvokerInvocationRequest()
//        request.functionName = "FUNCTION_NAME"
//
//        lambda.invoke(request).continueWithBlock {
//            (task: AWSTask!) -> AnyObject? in
//            print(task.result)
//            return nil
//        }
    }
}
