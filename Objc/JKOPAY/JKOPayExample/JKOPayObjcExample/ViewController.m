//
//  ViewController.m
//  JKOPayObjcExample
//
//  Created by Cherri Kevin on 4/14/20.
//  Copyright © 2020 Cherri. All rights reserved.
//

#import "ViewController.h"
#import <TPDirect/TPDirect.h>

@interface ViewController ()

@property (strong, nonatomic) NSString * frontend_redirect_url;
@property (strong, nonatomic) NSString * backend_notify_url;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.frontend_redirect_url = @"https://example.com/front-end-redirect";
    self.backend_notify_url = @"https://example.com/back-end-notify";
}
- (IBAction)startJKOPay:(id)sender {
    TPDJKOPay *jkoPay = [TPDJKOPay setupWithReturnUrl:@"Your universal link"];
    
    [[[jkoPay onSuccessCallback:^(NSString * _Nullable prime) {
        //send prime to your server and call pay by prime
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *payment = [NSString stringWithFormat:@"Use below cURL to get the payment_url.\ncurl -X POST \\\nhttps://sandbox.tappaysdk.com/tpc/payment/pay-by-prime \\\n-H \'content-type: application/json\' \\\n-H \'x-api-key: partner_6ID1DoDlaPrfHw6HBZsULfTYtDmWs0q0ZZGKMBpp4YICWBxgK97eK3RM\' \\\n-d \'{ \n \"prime\": \"%@\", \"partner_key\": \"partner_6ID1DoDlaPrfHw6HBZsULfTYtDmWs0q0ZZGKMBpp4YICWBxgK97eK3RM\", \"merchant_id\": \"GlobalTesting_LINEPAY\", \"details\":\"TapPay Test\", \"amount\": 100, \"cardholder\": { \"phone_number\": \"+886923456789\", \"name\": \"Jane Doe\", \"email\": \"Jane@Doe.com\", \"zip_code\": \"12345\", \"address\": \"123 1st Avenue, City, Country\", \"national_id\": \"A123456789\" },\"result_url\": {\"frontend_redirect_url\":\"%@\",\"backend_notify_url\":\"%@\"} }\'", prime, self.frontend_redirect_url, self.backend_notify_url];
            
            NSLog(@"%@", payment);
        });
    }]onFailureCallback:^(NSInteger status, NSString * _Nonnull message) {
        NSLog(@"status : %ld, msg: %@", status, message);
    }] getPrime];
}


@end
