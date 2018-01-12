# tappay-iOS-example(Swift)

TapPay SDK Example Code for iOS Plateform.

TapPay iOS SDK is used to get token(i.e. prime) on iOS platform for charging a credit card.

> Obtain your app id and keys here. > https://www.tappaysdk.com/en

# Demo

![direct pay demo](https://media.giphy.com/media/xUOxeQPVxyh59SBOi4/giphy.gif)   ![apple pay demo](https://media.giphy.com/media/3ohjVaPE9DBZRMN8hG/giphy.gif)   <img src="./line_pay.gif" width="300px"/>

# Usage

## Direct Pay
### 1. Import TPDirect.framework and TPDirectResource into your project.
### 2. Create a Bridging-Header.h file and Import TPDirect SDK
```objc
#import <TPDirect/TPDirect.h>
```
### 3. Use TPDSetup to set up your environment.

``` swift
import AdSupport
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    TPDSetup.setWithAppId(APP_ID, withAppKey: "APP_KEY", with: TPDServerType.ServerType)

    TPDSetup.shareInstance().setupIDFA(ASIdentifierManager.shared().advertisingIdentifier.uuidString)

    TPDSetup.shareInstance().serverSync()
}
```

### 4. Add UIView in your Main.storyboard and initialize TPDForm.
```swift
self.tpdForm = TPDForm.setup(withContainer: Your View)
```
### 5. Setup TPDForm Text Color
```swift
tpdForm.setErrorColor(UIColor.red)
tpdForm.setOkColor(UIColor.green)
tpdForm.setNormalColor(UIColor.black)
```
### 6. Setup TPDForm onFormUpdated Callback get TPDForm Status, check is can get prime.

```swift
tpdForm.onFormUpdated { (status) in
    if (status.isCanGetPrime()) {
        // Can make payment.
    } else {
        // Can't make payment.
    }
}
```

### 7. Use TPDForm to initialize TPDCard.
```swift
self.tpdCard = TPDCard.setup(self.tpdForm)
```
### 8. Use the getPrime() function in TPDCard to obtain the prime token.

```swift
tpdCard.onSuccessCallback { (prime, cardInfo) in

    print("Prime : \(prime!), cardInfo : \(cardInfo)")

}.onFailureCallback { (status, message) in

    print("status : \(status) , Message : \(message)")

}.getPrime()
```



## Apple Pay

### 1. Download and import TPDirect.framework into your project.

### 2. Create a Bridging-Header.h file Import TPDirect SDK
```objc
#import <TPDirect/TPDirect.h>
```
### 3. Import PassKit.framework into your project.
```swift
import PassKit
```
### 4. Enable Apple Pay in your Xcode and add Apple Merchant IDs.
### 5. Use TPDSetup to set up your environment.
```swift
import AdSupport
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    TPDSetup.setWithAppId(APP_ID, withAppKey: "APP_KEY", with: TPDServerType.ServerType)

    TPDSetup.shareInstance().setupIDFA(ASIdentifierManager.shared().advertisingIdentifier.uuidString)

    TPDSetup.shareInstance().serverSync()
}
```
### 6. Create TPDMerchant for Apple Pay Merchant Information.
### 7. Create TPDConsumer for Apple Pay Consumer Information.
### 8. Create TPDCart for Apple Pay Cart Information.
### 9. Check Device Support Apple Pay.
```swift
TPDApplePay.canMakePayments()
```
### 10. Setup TPDApplePay with TPDMerchant, TPDConsumer and TPDCart.
```swift
TPDApplePay.setupWthMerchant(merchant, with: consumer, with: cart, withDelegate: self)
```
### 11. Start Payment.
```swift
applePay.startPayment()
```

### 12. Get Prime via delegate.
```swift
func tpdApplePay(_ applePay: TPDApplePay!, didReceivePrime prime: String!) {

    // 1. Send Your Prime To Your Server, And Handle Payment With Result

    print("Prime : \(prime!)");

    // 2. Handle Payment Result Success / Failure in Delegate.
    let paymentReault = true;
    applePay.showPaymentResult(paymentReault)

}
```

### 13. Handle Payment Success Result.
```swift
func tpdApplePay(_ applePay: TPDApplePay!, didSuccessPayment result: TPDTransactionResult!) {
    print("Apple Pay Did Success ==> Amount : \(result.amount.stringValue)")

    print("shippingContact.name : \(applePay.consumer.shippingContact?.name?.givenName) \( applePay.consumer.shippingContact?.name?.familyName)")
    print("shippingContact.emailAddress : \(applePay.consumer.shippingContact?.emailAddress)")
    print("shippingContact.phoneNumber : \(applePay.consumer.shippingContact?.phoneNumber?.stringValue)")

    print("Shipping Method.identifier : \(applePay.cart.shippingMethod.identifier)")
    print("Shipping Method.detail : \(applePay.cart.shippingMethod.detail)")

}
```

### 14. Handle Payment Failure Result.
```swift
func tpdApplePay(_ applePay: TPDApplePay!, didFailurePayment result: TPDTransactionResult!) {
    print("Apple Pay Did Failure ==> Message : \(result.message), ErrorCode : \(result.status)")
}
```


## LINE Pay
### 1. Download and import TPDirect.framework into your project.

### 2. Create a Bridging-Header.h file Import TPDirect SDK
```objc
#import <TPDirect/TPDirect.h>
```

### 3. Linked Framework and Libraries add SafariServices.framework

### 4. Use TPDSetup to set up your environment.
```swift
import AdSupport
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    TPDSetup.setWithAppId(APP_ID, withAppKey: "APP_KEY", with: TPDServerType.ServerType)

    TPDSetup.shareInstance().setupIDFA(ASIdentifierManager.shared().advertisingIdentifier.uuidString)

    TPDSetup.shareInstance().serverSync()
}
```
### 5. Setup Custom URL Scheme
#### Step 1
Go into your app's info.plist file.
#### Step 2
Add a Row to this and call it "URL types"
#### Step 3
Expand the first item in "URL types" and add a row called "URL identifier", the value of this string should be the reverse domain for your app e.g. "com.yourcompany.myapp".
#### Step 4
Again, add a row into the first item in "URL types" and call it "URL Schemes"
#### Step 5
Inside "URL Schemes" you can use each item as a different url you wish to use, so if you wanted to use "myapp://" you would create an item called "myapp".

![](./line_pay_custom_url.png)

### 6. Setup Whitelisting URL Scheme
####  Step 1
Open Info.plist
#### Step 2
Add a Key named LSApplicationQueriesSchemes, and set the type of the value to Array
#### Step 3
Add an item of type String to the Array and set its value to line.

![](./line_pay_white.png)

### Setup TPDLinePay
Use your custom URL Scheme to initialize TPDLinePay object.
```swift
TPDLinePay.setup(withReturnUrl: "You Custom URL SCheme")
```

### isLinePayAvailable
Check current device can use LINE Pay.
```swift
TPDLinePay.isLinePayAvailable()
```

### Install LINE App

```swift
TPDLinePay.installLineApp()
```

### Get Prime
Call getPrime function, via onSuccessCallback or onFailureCallbac to get prime or error message.

```Swift
linePay.onSuccessCallback { (prime) in
    print(prime : \(prime!))
}.onFailureCallback { (status, msg) in
    print("status : \(status), msg : \(msg)")
}.getPrime()
```
### Redirect to LINE Pay Payment Page

Obtain payment_url from TapPay, call redirect url function to LINE Pay Payment Page, get LINE Pay result via callback.
```Swift
linePay.redirect(with: paymentURL, viewController: self, completion: { (result) in

    print("stauts : \(result.status) , recTradeId : \(result.recTradeId) , bankTransactionId : \(result.bankTransactionId) , order_number : \(result.orderNumber)")

})
```

### Handle URL
Use this method handle URL come from TapPay and parse URL data.
( For version higher than iOS 9.0 )
```Swift
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    let tapPayHandled = TPDLinePay.handle(url)
    if (tapPayHandled) {
        return true
        }
    return false
}
```
( For version lower than iOS 9.0 )
```
func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    let tapPayHandled = TPDLinePay.handle(url)
    if (tapPayHandled) {
        return true
    }

    return false
}
```
### Exception Handle
#### Step1
Implement addExceptionOberver function in AppDelegate didFinishLaunchingWithOptions to handle exception, .

```Swift
TPDLinePay.addExceptionObserver(#selector(tappayLinePayExceptionHandler(notofication:)))
```

#### Step2
In AppDelegate add tappayLinePayExceptionHandler function, when exception happened receive notification.

```Swift
@objc func tappayLinePayExceptionHandler(notofication: Notification) {

let result : TPDLinePayResult = TPDLinePay.parseURL(notofication)

print("status : \(result.status) , orderNumber : \(result.orderNumber) , recTradeid : \(result.recTradeId) , bankTransactionId : \(result.bankTransactionId) ")

}

```















