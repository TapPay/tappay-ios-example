# tappay-iOS-example(Swift)

TapPay SDK Example Code for iOS Plateform.

TapPay iOS SDK is used to get token(i.e. prime) on iOS platform for charging a credit card.

> Obtain your app id and keys here. > https://www.tappaysdk.com/en

# Usage

## Direct Pay
1. Import TPDirect.framework and TPDirectResource into your project.
2. Create a Bridging-Header.h file and Import TPDirect SDK
```swift
#import <TPDirect/TPDirect.h>
```
3. Use TPDSetup to set up your environment.

``` swift
import AdSupport
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

TPDSetup.setWithAppId(APP_ID, withAppKey: "APP_KEY", with: TPDServerType.ServerType)

TPDSetup.shareInstance().setupIDFA(ASIdentifierManager.shared().advertisingIdentifier.uuidString)

TPDSetup.shareInstance().serverSync()
}
```

4. Add UIView in your Main.storyboard and initialize TPDForm.
```swift
self.tpdForm = TPDForm.setup(withContainer: Your View)
```
5. Setup TPDForm Text Color
```swift
tpdForm.setErrorColor(UIColor.red)
tpdForm.setOkColor(UIColor.green)
tpdForm.setNormalColor(UIColor.black)
```
6. Setup TPDForm onFormUpdated Callback get TPDForm Status, check is can get prime.

```swift
tpdForm.onFormUpdated { (status) in
if (status.isCanGetPrime()) {
// Can make payment.
}else{
// Can't make payment.
}
}
```

7. Use TPDForm to initialize TPDCard.
```swift
self.tpdCard = TPDCard.setup(self.tpdForm)
```
8. Use the getPrime() function in TPDCard to obtain the prime token.

```swift
tpdCard.onSuccessCallback { (prime, cardInfo) in

print("Prime : \(prime!), cardInfo : \ (cardInfo)")

}.onFailureCallback { (status, message) in

print("status : \(status) , Message : \(message)")

}.getPrime()
```



## Apple Pay

1. Download and import TPDirect.framework into your project.

2. Create a Bridging-Header.h file Import TPDirect SDK
```swift
#import <TPDirect/TPDirect.h>
```
3. Import PassKit.framework into your project.
```swift
import PassKit
```
4. Enable Apple Pay in your Xcode and add Apple Merchant IDs.
5. Use TPDSetup to set up your environment.
```swift
import AdSupport
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

TPDSetup.setWithAppId(APP_ID, withAppKey: "APP_KEY", with: TPDServerType.ServerType)

TPDSetup.shareInstance().setupIDFA(ASIdentifierManager.shared().advertisingIdentifier.uuidString)

TPDSetup.shareInstance().serverSync()
}
```
6. Create TPDMerchant for Apple Pay Merchant Information.
7. Create TPDConsumer for Apple Pay Consumer Information.
8. Create TPDCart for Apple Pay Cart Information.
9. Check Device Support Apple Pay.
```swift
TPDApplePay.canMakePayments()
```
10. Setup TPDApplePay with TPDMerchant, TPDConsumer and TPDCart.
```swift
TPDApplePay.setupWthMerchant(merchant, with: consumer, with: cart, withDelegate: self)
```
11. Start Payment.
```swift
applePay.startPayment()
```

12. Get Prime via delegate.
```swift
func tpdApplePay(_ applePay: TPDApplePay!, didReceivePrime prime: String!) {

// 1. Send Your Prime To Your Server, And Handle Payment With Result

print("Prime : \(prime!)");

// 2. Handle Payment Result Success / Failure in Delegate.
let paymentReault = true;
applePay.showPaymentResult(paymentReault)
}
}
```

13. Handle Payment Success Result.
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

14. Handle Payment Failure Result.
```swift
func tpdApplePay(_ applePay: TPDApplePay!, didFailurePayment result: TPDTransactionResult!) {
print("Apple Pay Did Failure ==> Message : \(result.message), ErrorCode : \(result.status)")
}
```
