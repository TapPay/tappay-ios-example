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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
    
    
    @objc func didClickSetupButton(sender:PKPaymentButton) {
        
        TPDApplePay.showSetupView()
    }

    
    //MARK: - Apple Pay Setting
    func paymentButtonSetting() {
        
        
        // Check Consumer / Application Can Use Apple Pay.
        if !TPDApplePay.canMakePayments(usingNetworks: self.merchant.supportedNetworks) {
            
            applePayButton = PKPaymentButton.init(paymentButtonType: .setUp, paymentButtonStyle: .black)
            applePayButton.addTarget(self, action: #selector(ViewController.didClickSetupButton(sender:)), for: .touchUpInside)
            view.addSubview(applePayButton)
            applePayButton.center = view.center
            return;
        }
        
        // Check Device Support Apple Pay
        if TPDApplePay.canMakePayments() {
            applePayButton = PKPaymentButton.init(paymentButtonType: .buy, paymentButtonStyle: .black)
            applePayButton.addTarget(self, action: #selector(ViewController.didClickBuyButton(sender:)), for: .touchUpInside)

            view.addSubview(applePayButton)
            applePayButton.center = view.center
            
            return;
        }
        
    }
    
    
    func merchantSetting() {
        
        merchant = TPDMerchant()
        merchant.merchantName               = "TapPay!"
        merchant.merchantCapability         = .capability3DS;
        merchant.applePayMerchantIdentifier = "merchant.tech.cherri"; // Your Apple Pay Merchant ID (https://developer.apple.com/account/ios/identifier/merchant)
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
        merchant.shippingMethods            = [shipping1, shipping2];
   
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
        consumer.requiredShippingAddressFields  = [.email, .name, .phone]
        consumer.requiredBillingAddressFields   = [.email, .name, .phone]
    
    }
    
    func cartSetting() {
        
        cart = TPDCart()
        
        let book = TPDPaymentItem(itemName:"Book", withAmount: NSDecimalNumber(string: "100.00"))
        cart.add(book)
        
        let shippingFee = TPDPaymentItem(itemName:"Shipping", withAmount: NSDecimalNumber(string: "50.00"))
        cart.add(shippingFee)
        
        let discount = TPDPaymentItem(itemName:"Discount", withAmount: NSDecimalNumber(string: "-3.00"))
        cart.add(discount)
        
        let tax = TPDPaymentItem(itemName:"Tax", withAmount: NSDecimalNumber(string: "6.00"))
        cart.add(tax)

        cart.shippingType   = .shipping;
        
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
        
        print("Shipping Method.identifier : \(applePay.cart.shippingMethod.identifier)")
        print("Shipping Method.detail : \(applePay.cart.shippingMethod.detail)")
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
    
    func tpdApplePay(_ applePay: TPDApplePay!, canAuthorizePaymentWithShippingContact shippingContact: PKContact!) -> Bool {
        //
        
        print("=====================================================")
        print("======> canAuthorizePaymentWithShippingContact ")
        print("shippingContact.name : \(shippingContact.name?.givenName) \(shippingContact.name?.familyName)")
        print("shippingContact.emailAddress : \(shippingContact.emailAddress)")
        print("shippingContact.phoneNumber : \(shippingContact.phoneNumber?.stringValue)")
        print("===================================================== \n\n")
        return true;
    }
    
    // With Payment Handle
    func tpdApplePay(_ applePay: TPDApplePay!, didReceivePrime prime: String!) {
        
        // 1. Send Your Prime To Your Server, And Handle Payment With Result
        // ...
        print("=====================================================");
        print("======> didReceivePrime");
        print("Prime : \(prime!)");
        print("total Amount :   \(applePay.cart.totalAmount!)")
        print("Client IP : \(applePay.consumer.clientIP!)")
        print("shippingContact.name : \(applePay.consumer.shippingContact?.name?.givenName) \(applePay.consumer.shippingContact?.name?.familyName)");
        print("shippingContact.emailAddress : \(applePay.consumer.shippingContact?.emailAddress)");
        print("shippingContact.phoneNumber : \(applePay.consumer.shippingContact?.phoneNumber?.stringValue)");
        print("===================================================== \n\n");
        
        // 2. If Payment Success, set paymentReault = ture.
        let paymentReault = true;
        applePay.showPaymentResult(paymentReault)
    }
}
