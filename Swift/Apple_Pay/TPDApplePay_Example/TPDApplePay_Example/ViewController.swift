//
//  AppDelegate.swift
//  TPDApplePay_Example
//
//  Created by Cherri on 2017/11/3.
//  Copyright © 2017年 Cherri Tech Inc. All rights reserved.
//

import UIKit
import PassKit
import TPDirect

class ViewController: UIViewController {
    
    var merchant : TPDMerchant!
    var consumer : TPDConsumer!
    var cart     : TPDCart!
    var applePay : TPDApplePay!
    var applePayButton : PKPaymentButton!
    @IBOutlet weak var displayText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("version \(TPDSetup.version())")
        merchantSetting()
        consumerSetting()
        cartSetting()
        paymentButtonSetting()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - @IBAction
    @objc func didClickBuyButton(sender:PKPaymentButton) {
        
        applePay = TPDApplePay.setupWthMerchant(merchant, with: consumer, with: cart, withDelegate: self)
        
        applePay.startPayment()
        
    }

    
    //MARK: - Apple Pay Setting
    func paymentButtonSetting() {
        
        
        // Check Consumer / Application Can Use Apple Pay.
        if (TPDApplePay.canMakePayments(usingNetworks: self.merchant.supportedNetworks)) {
            applePayButton = PKPaymentButton.init(paymentButtonType: .buy, paymentButtonStyle: .black)
        } else {
            applePayButton = PKPaymentButton.init(paymentButtonType: .setUp, paymentButtonStyle: .black)
        }
        
        view.addSubview(applePayButton)
        applePayButton.center = view.center
        
        applePayButton.addTarget(self, action: #selector(ViewController.didClickBuyButton(sender:)), for: .touchUpInside)
        
    }
    
    
    func merchantSetting() {
        
        merchant = TPDMerchant()
        merchant.merchantName               = "TapPay!"
        merchant.merchantCapability         = .capability3DS;
        merchant.applePayMerchantIdentifier = "merchant.tech.cherri.global.test"; // Your Apple Pay Merchant ID (https://developer.apple.com/account/ios/identifier/merchant)
        merchant.countryCode                = "TW";
        merchant.currencyCode               = "TWD";
        merchant.supportedNetworks          = [.amex, .masterCard, .visa]
        
        // Set Shipping Method.
        let shipping1 = PKShippingMethod()
        shipping1.identifier = "TapPayExpressShippint024"
        shipping1.detail     = "Ships in 24 hours"
        shipping1.amount     = NSDecimalNumber(string: "10.0");
        shipping1.label      = "Shipping 24"
        
        let shipping2 = PKShippingMethod()
        shipping2.identifier = "TapPayExpressShippint006";
        shipping2.detail     = "Ships in 6 hours";
        shipping2.amount     = NSDecimalNumber(string: "50.0");
        shipping2.label      = "Shipping 6";
//        merchant.shippingMethods            = [shipping1, shipping2];
   
    }
    
    func consumerSetting() {
    
        // Set Consumer Contact.
        let contact = PKContact()
        var name    = PersonNameComponents()
        name.familyName = "Cherri"
        name.givenName  = "TapPay"
        contact.name    = name;
        
        consumer = TPDConsumer()
        consumer.billingContact     = contact
        consumer.shippingContact    = contact
        consumer.requiredShippingAddressFields  = []
        consumer.requiredBillingAddressFields   = []
    
    }
    
    func cartSetting() {
        
        cart = TPDCart()
        
        self.cart.isAmountPending = true
        
        let final = TPDPaymentItem(itemName: "Book", withAmount: NSDecimalNumber(string: "100.00"), withIsVisible: true)
        cart.add(final)
        
        let pending = TPDPaymentItem.pendingPaymentItem(withItemName: "pendingItem")
        cart.add(pending)
        
    }
}


extension ViewController :TPDApplePayDelegate {
    
    func tpdApplePayDidStartPayment(_ applePay: TPDApplePay!) {
        //
        print("=====================================================")
        print("Apple Pay On Start")
        print("===================================================== \n\n")
    }
    
    func tpdApplePay(_ applePay: TPDApplePay!, didSuccessPayment result: TPDTransactionResult!) {
        //
        print("=====================================================")
        print("Apple Pay Did Success ==> Amount : \(result.amount.stringValue)")
        
        print("shippingContact.name : \(applePay.consumer.shippingContact?.name?.givenName) \( applePay.consumer.shippingContact?.name?.familyName)")
        print("shippingContact.emailAddress : \(applePay.consumer.shippingContact?.emailAddress)")
        print("shippingContact.phoneNumber : \(applePay.consumer.shippingContact?.phoneNumber?.stringValue)")
        

        print("===================================================== \n\n")
        

    }
    
    func tpdApplePay(_ applePay: TPDApplePay!, didFailurePayment result: TPDTransactionResult!) {
        //
        print("=====================================================")
        print("Apple Pay Did Failure ==> Message : \(result.message), ErrorCode : \(result.status)")
        print("===================================================== \n\n")
    }
    
    func tpdApplePayDidCancelPayment(_ applePay: TPDApplePay!) {
        //
        print("=====================================================")
        print("Apple Pay Did Cancel")
        print("===================================================== \n\n")
    }
    
    func tpdApplePayDidFinishPayment(_ applePay: TPDApplePay!) {
        //
        print("=====================================================")
        print("Apple Pay Did Finish")
        print("===================================================== \n\n")
    }
    
    func tpdApplePay(_ applePay: TPDApplePay!, didSelect shippingMethod: PKShippingMethod!) {
        //
        print("=====================================================")
        print("======> didSelectShippingMethod: ")
        print("Shipping Method.identifier : \(shippingMethod.identifier?.description)")
        print("Shipping Method.detail : \(shippingMethod.detail)")
        print("===================================================== \n\n")
    }
    
    func tpdApplePay(_ applePay: TPDApplePay!, didSelect paymentMethod: PKPaymentMethod!, cart: TPDCart!) -> TPDCart! {
        //
        print("=====================================================");
        print("======> didSelectPaymentMethod: ");
        print("===================================================== \n\n");
        
        if paymentMethod.type == .debit {
            self.cart.add(TPDPaymentItem(itemName: "Discount", withAmount: NSDecimalNumber(string: "-1.00")))
        }
        
        return self.cart;
        
    }
    
    func tpdApplePay(_ applePay: TPDApplePay!, canAuthorizePaymentWithShippingContact shippingContact: PKContact?) -> Bool {
        //
        
        print("=====================================================")
        print("======> canAuthorizePaymentWithShippingContact ")
        print("shippingContact.name : \(shippingContact?.name?.givenName) \(shippingContact?.name?.familyName)")
        print("shippingContact.emailAddress : \(shippingContact?.emailAddress)")
        print("shippingContact.phoneNumber : \(shippingContact?.phoneNumber?.stringValue)")
        print("===================================================== \n\n")
        return true;
    }
    
    // With Payment Handle
    func tpdApplePay(_ applePay: TPDApplePay!, didReceivePrime prime: String!, withExpiryMillis expiryMillis: Int) {
        // 1. Send Your Prime To Your Server, And Handle Payment With Result
        // ...
        print("=====================================================");
        print("======> didReceivePrime");
        print("Prime : \(prime!)");
        print("Expiry millis : \(expiryMillis)");
        print("total Amount :   \(applePay.cart.totalAmount!)")
        print("Client IP : \(applePay.consumer.clientIP!)")
        print("shippingContact.name : \(applePay.consumer.shippingContact?.name?.givenName) \(applePay.consumer.shippingContact?.name?.familyName)");
        print("shippingContact.emailAddress : \(applePay.consumer.shippingContact?.emailAddress)");
        print("shippingContact.phoneNumber : \(applePay.consumer.shippingContact?.phoneNumber?.stringValue)");
        
        let paymentMethod = self.consumer.paymentMethod!
        
        print("type : \(paymentMethod.type.rawValue)")
        print("Network : \(paymentMethod.network!.rawValue)")
        print("Display Name : \(paymentMethod.displayName!)")
        
        print("===================================================== \n\n");
        
        DispatchQueue.main.async {
            let payment = "Use below cURL to proceed the payment.\ncurl -X POST \\\nhttps://sandbox.tappaysdk.com/tpc/payment/pay-by-prime \\\n-H \'content-type: application/json\' \\\n-H \'x-api-key: partner_6ID1DoDlaPrfHw6HBZsULfTYtDmWs0q0ZZGKMBpp4YICWBxgK97eK3RM\' \\\n-d \'{ \n \"prime\": \"\(prime!)\", \"partner_key\": \"partner_6ID1DoDlaPrfHw6HBZsULfTYtDmWs0q0ZZGKMBpp4YICWBxgK97eK3RM\", \"merchant_id\": \"GlobalTesting_CTBC\", \"details\":\"TapPay Test\", \"amount\": \(applePay.cart.totalAmount!.stringValue), \"cardholder\": { \"phone_number\": \"+886923456789\", \"name\": \"Jane Doe\", \"email\": \"Jane@Doe.com\", \"zip_code\": \"12345\", \"address\": \"123 1st Avenue, City, Country\", \"national_id\": \"A123456789\" }, \"remember\": true }\'"
            self.displayText.text = payment
            print(payment)
            
        }
        
        // 2. If Payment Success, set paymentReault = ture.
        let paymentReault = true;
        applePay.showPaymentResult(paymentReault)
    }
}
