# CognitoUserPoolSample
Cognito UserPool + Identityのサンプルプロジェクトです。

## Requirements
* Swift 2.0
* XCode7
* iOS8.0以上

## Install Dependencies
```
$ pod install
```

## Setup Cognito
`Constants.swift`にUserPoolおよびIdentityの情報を記入しておきます。

* **UserPoolは米国東部(バージニア北部)リージョン(us-east-1)で作成してください。**

```
static let COGNITO_IDENTITY_USER_POOL_ID = "YOUR_USER_POOL_ID"
static let COGNITO_IDENTITY_USER_POOL_APP_CLIENT_ID = "YOUR_USER_POOL_APP_CLIENT_ID"
static let COGNITO_IDENTITY_USER_POOL_APP_CLIENT_SECRET = "YOUR_USER_POOL_APP_CLIENT_SECRET"
static let COGNITO_IDENTITY_USER_POOL_KEY = "CognitoUserPool"
static let COGNITO_IDENTITY_POOL_ID = "YOUR_IDENTITY_POOL_ID"
```
