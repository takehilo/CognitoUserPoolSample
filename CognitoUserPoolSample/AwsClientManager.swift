import Foundation
import AWSCore
import AWSCognito
import AWSCognitoIdentityProvider

class AwsClientManager {
    static let sharedInstance = AwsClientManager()

    var credentialsProvider: AWSCognitoCredentialsProvider?
    var userPool: AWSCognitoIdentityUserPool?
    var currentUser: AWSCognitoIdentityUser? {
        get {
            return self.userPool?.currentUser()
        }
    }

    func initialize(appDelegate: AppDelegate) {
        // ここでap-northeast-1を指定しても、AWSCognitoIdentityUserPoolインスタンスに設定されるidentityProviderNameがus-east-1リージョンになってしまう
        var configuration = AWSServiceConfiguration(region: .APNortheast1, credentialsProvider: nil)
        let userPoolConfiguration = AWSCognitoIdentityUserPoolConfiguration(
            clientId: Constants.COGNITO_IDENTITY_USER_POOL_APP_CLIENT_ID,
            clientSecret: Constants.COGNITO_IDENTITY_USER_POOL_APP_CLIENT_SECRET,
            poolId: Constants.COGNITO_IDENTITY_USER_POOL_ID)
        AWSCognitoIdentityUserPool.registerCognitoIdentityUserPoolWithConfiguration(
            configuration,
            userPoolConfiguration: userPoolConfiguration,
            forKey: Constants.COGNITO_IDENTITY_USER_POOL_KEY)

        self.userPool = AWSCognitoIdentityUserPool(forKey: Constants.COGNITO_IDENTITY_USER_POOL_KEY)
        self.userPool?.delegate = appDelegate

        self.credentialsProvider = AWSCognitoCredentialsProvider(
            regionType: .APNortheast1,
            identityPoolId: Constants.COGNITO_IDENTITY_POOL_ID,
            identityProviderManager: self.userPool)

        configuration = AWSServiceConfiguration(region: .APNortheast1, credentialsProvider: self.credentialsProvider)
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = configuration
    }

    func signOut() {
        self.currentUser?.signOut()
        self.credentialsProvider?.clearKeychain()
    }
}