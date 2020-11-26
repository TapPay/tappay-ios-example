//
//  ViewController.m
//  TPDApplePay_Example
//
//  Copyright © 2017年 Cherri Tech Inc. All rights reserved.
//

#import "ViewController.h"
#import <TPDirect/TPDirect.h>

@interface ViewController ()

@property (nonatomic, strong) TPDMerchant *merchant;
@property (nonatomic, strong) TPDConsumer *consumer;
@property (nonatomic, strong) TPDCart *cart;
@property (nonatomic, strong) TPDApplePay *applePay;
@property (nonatomic, strong) PKPaymentButton *applePayButton;
@property (weak, nonatomic) IBOutlet UITextView *displayText;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    [self merchantSetting];
    [self consumerSetting];
    [self cartSetting];
    [self paymentButtonSetting];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClickBuyButton:(PKPaymentButton *)sender {
    
    
    // Without Handle Payment
    self.applePay = [TPDApplePay setupWthMerchant:self.merchant
                                     withConsumer:self.consumer
                                         withCart:self.cart
                                     withDelegate:self];
    
    [self.applePay startPayment];
    
    
}

- (void)paymentButtonSetting {
    
    
    // Check Consumer / Application Can Use Apple Pay.
    if ([TPDApplePay canMakePaymentsUsingNetworks:self.merchant.supportedNetworks]) {
        self.applePayButton = [PKPaymentButton buttonWithType:PKPaymentButtonTypeBuy style:PKPaymentButtonStyleBlack];
    } else {
        self.applePayButton = [PKPaymentButton buttonWithType:PKPaymentButtonTypeSetUp style:PKPaymentButtonStyleBlack];
    }
    
    [self.view addSubview:self.applePayButton];
    self.applePayButton.center = self.view.center;
    
    [self.applePayButton addTarget:self action:@selector(didClickBuyButton:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)merchantSetting {
    
    self.merchant = [TPDMerchant new];
    self.merchant.merchantName               = @"TapPay!";
    self.merchant.merchantCapability         = PKMerchantCapability3DS;
    self.merchant.applePayMerchantIdentifier = @"merchant.tech.cherri.global.test"; // Your Apple Pay Merchant ID (https://developer.apple.com/account/ios/identifier/merchant)
    self.merchant.countryCode                = @"TW";
    self.merchant.currencyCode               = @"TWD";
    self.merchant.supportedNetworks          = @[PKPaymentNetworkAmex, PKPaymentNetworkVisa ,PKPaymentNetworkMasterCard];
    
    
    // Set Shipping Method.
    PKShippingMethod *shipping1 = [PKShippingMethod new];
    shipping1.identifier = @"TapPayExpressShippint024";
    shipping1.detail     = @"Ships in 24 hours";
    shipping1.amount     = [NSDecimalNumber decimalNumberWithString:@"10.0"];
    shipping1.label      = @"Shipping 24";
    
    PKShippingMethod *shipping2 = [PKShippingMethod new];
    shipping2.identifier = @"TapPayExpressShippint006";
    shipping2.detail     = @"Ships in 6 hours";
    shipping2.amount     = [NSDecimalNumber decimalNumberWithString:@"50.0"];
    shipping2.label      = @"Shipping 6";
    
//    self.merchant.shippingMethods            = @[shipping1, shipping2];
    
    
}

- (void)consumerSetting {
    
    // Set Consumer Contact.
    PKContact *contact  = [PKContact new];
    NSPersonNameComponents *name = [NSPersonNameComponents new];
    name.familyName = @"Cherri";
    name.givenName  = @"TapPay";
    contact.name    = name;
    
    self.consumer = [TPDConsumer new];
    self.consumer.billingContact    = contact;
    self.consumer.shippingContact   = contact;
    self.consumer.requiredShippingAddressFields  = PKAddressFieldNone;
    self.consumer.requiredBillingAddressFields   = PKAddressFieldNone;
    
}

- (void)cartSetting {
    
    self.cart = [TPDCart new];
    self.cart.isAmountPending = YES;
    self.cart.isShowTotalAmount = NO;
    
    TPDPaymentItem *final = [TPDPaymentItem paymentItemWithItemName:@"final"
                                                        withAmount:[NSDecimalNumber decimalNumberWithString:@"100.00"]];
    [self.cart addPaymentItem:final];
    
    TPDPaymentItem * pending = [TPDPaymentItem pendingPaymentItemWithItemName:@"pending"];
    [self.cart addPaymentItem:pending];
    
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - TPDApplePayDelegate
- (void)tpdApplePayDidStartPayment:(TPDApplePay *)applePay {
    
    NSLog(@"=====================================================");
    NSLog(@"Apple Pay On Start");
    NSLog(@"===================================================== \n\n");
}

- (void)tpdApplePay:(TPDApplePay *)applePay didSuccessPayment:(TPDTransactionResult *)result {
    
    NSLog(@"=====================================================");
    NSLog(@"Apple Pay Did Success ==> Amount : %@", [result.amount stringValue]);
    
    NSLog(@"shippingContact.name : %@ %@", applePay.consumer.shippingContact.name.givenName, applePay.consumer.shippingContact.name.familyName);
    NSLog(@"shippingContact.emailAddress : %@", applePay.consumer.shippingContact.emailAddress);
    NSLog(@"shippingContact.phoneNumber : %@", applePay.consumer.shippingContact.phoneNumber.stringValue);
    NSLog(@"===================================================== \n\n");
    
}

- (void)tpdApplePay:(TPDApplePay *)applePay didFailurePayment:(TPDTransactionResult *)result {
    
    NSLog(@"=====================================================");
    NSLog(@"Apple Pay Did Failure ==> Message : %@, ErrorCode : %ld", result.message, (long)result.status);
    NSLog(@"===================================================== \n\n");
}

- (void)tpdApplePayDidCancelPayment:(TPDApplePay *)applePay {
    
    NSLog(@"=====================================================");
    NSLog(@"Apple Pay Did Cancel");
    NSLog(@"===================================================== \n\n");
}

- (void)tpdApplePayDidFinishPayment:(TPDApplePay *)applePay {
    
    NSLog(@"=====================================================");
    NSLog(@"Apple Pay Did Finish");
    NSLog(@"===================================================== \n\n");
}

- (void)tpdApplePay:(TPDApplePay *)applePay didSelectShippingMethod:(PKShippingMethod *)shippingMethod {
    
    NSLog(@"=====================================================");
    NSLog(@"======> didSelectShippingMethod: ");
    NSLog(@"Shipping Method.identifier : %@", shippingMethod.identifier);
    NSLog(@"Shipping Method.detail : %@", shippingMethod.detail);
    NSLog(@"===================================================== \n\n");
    
}

- (TPDCart *)tpdApplePay:(TPDApplePay *)applePay didSelectPaymentMethod:(PKPaymentMethod *)paymentMethod cart:(TPDCart *)cart {
    
    NSLog(@"=====================================================");
    NSLog(@"======> didSelectPaymentMethod: ");
    NSLog(@"===================================================== \n\n");
    
    if (paymentMethod.type == PKPaymentMethodTypeDebit) {
        [self.cart addPaymentItem:[TPDPaymentItem paymentItemWithItemName:@"Discount"
                                                               withAmount:[NSDecimalNumber decimalNumberWithString:@"-1.00"]]];
    }
    
    return self.cart;
}


- (BOOL)tpdApplePay:(TPDApplePay *)applePay canAuthorizePaymentWithShippingContact:(PKContact *)shippingContact {
    
    NSLog(@"=====================================================");
    NSLog(@"======> canAuthorizePaymentWithShippingContact ");
    NSLog(@"shippingContact.name : %@ %@", shippingContact.name.givenName, shippingContact.name.familyName);
    NSLog(@"shippingContact.emailAddress : %@", shippingContact.emailAddress);
    NSLog(@"shippingContact.phoneNumber : %@", shippingContact.phoneNumber.stringValue);
    NSLog(@"===================================================== \n\n");
    return YES;
}

// With Payment Handle

- (void)tpdApplePay:(TPDApplePay *)applePay didReceivePrime:(NSString *)prime withExpiryMillis:(long)expiryMillis withCardInfo:(TPDCardInfo *)cardInfo withMerchantReferenceInfo:(NSDictionary *)merchantReferenceInfo {

    // 1. Send Your 'Prime' To Your Server, And Handle Payment With Result
    // ...
    NSLog(@"=====================================================");
    NSLog(@"======> didReceivePrime ");
    NSLog(@"Prime : %@", prime);
    NSLog(@"Expiry millis : %ld",expiryMillis);
    NSLog(@"merchantReferenceInfo : %@", merchantReferenceInfo);
    NSLog(@"totalAmount : %@",applePay.cart.totalAmount);
    NSLog(@"Client  IP : %@",applePay.consumer.clientIP);
    NSLog(@"shippingContact.name : %@ %@", applePay.consumer.shippingContact.name.givenName, applePay.consumer.shippingContact.name.familyName);
    NSLog(@"shippingContact.emailAddress : %@", applePay.consumer.shippingContact.emailAddress);
    NSLog(@"shippingContact.phoneNumber : %@", applePay.consumer.shippingContact.phoneNumber.stringValue);

    PKPaymentMethod * paymentMethod = self.consumer.paymentMethod;

    NSLog(@"tpye : %ld", paymentMethod.type);
    NSLog(@"Network : %@", paymentMethod.network);
    NSLog(@"Display Name : %@", paymentMethod.displayName);
    NSLog(@"===================================================== \n\n");


    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *payment = [NSString stringWithFormat:@"Use below cURL to proceed the payment.\ncurl -X POST \\\nhttps://sandbox.tappaysdk.com/tpc/payment/pay-by-prime \\\n-H \'content-type: application/json\' \\\n-H \'x-api-key: partner_6ID1DoDlaPrfHw6HBZsULfTYtDmWs0q0ZZGKMBpp4YICWBxgK97eK3RM\' \\\n-d \'{ \n \"prime\": \"%@\", \"partner_key\": \"partner_6ID1DoDlaPrfHw6HBZsULfTYtDmWs0q0ZZGKMBpp4YICWBxgK97eK3RM\", \"merchant_id\": \"GlobalTesting_CTBC\", \"details\":\"TapPay Test\", \"amount\": %@, \"cardholder\": { \"phone_number\": \"+886923456789\", \"name\": \"Jane Doe\", \"email\": \"Jane@Doe.com\", \"zip_code\": \"12345\", \"address\": \"123 1st Avenue, City, Country\", \"national_id\": \"A123456789\" }, \"remember\": true }\'",prime,applePay.cart.totalAmount];
        self.displayText.text = payment;
        NSLog(@"%@", payment);
    });


    // 2. If Payment Success, set paymentReault = YES.
    BOOL paymentReault = YES;
    [applePay showPaymentResult:paymentReault];
}


@end
