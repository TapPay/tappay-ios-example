//
//  ViewController.m
//  TPDLinePay_Example
//
//  Created by 高嘉琦 on 2018/1/2.
//  Copyright © 2018年 Cherri Tech Inc. All rights reserved.
//

#import "ViewController.h"
#import <TPDirect/TPDirect.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *displayText;
@property (strong, nonatomic) NSString * frontend_redirect_url;
@property (strong, nonatomic) NSString * backend_notify_url;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.frontend_redirect_url = @"https://example.com/front-end-redirect";
    self.backend_notify_url = @"https://example.com/back-end-notify";
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startLinePayAction:(id)sender {
    
    
    // 1. Initilize TPDLinePay Object.
    TPDLinePay * linePay = [TPDLinePay setupWithReturnUrl:@"tapapyLinePayExample://frontend_redirect"];
    
    // 2. Check current device can use LINE Pay.
    if ([TPDLinePay isLinePayAvailable]) {
        
        // 3. Get Prime.
        [[[linePay onSuccessCallback:^(NSString * _Nullable prime) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *payment = [NSString stringWithFormat:@"Use below cURL to get the payment_url.\ncurl -X POST \\\nhttps://sandbox.tappaysdk.com/tpc/payment/pay-by-prime \\\n-H \'content-type: application/json\' \\\n-H \'x-api-key: partner_6ID1DoDlaPrfHw6HBZsULfTYtDmWs0q0ZZGKMBpp4YICWBxgK97eK3RM\' \\\n-d \'{ \n \"prime\": \"%@\", \"partner_key\": \"partner_6ID1DoDlaPrfHw6HBZsULfTYtDmWs0q0ZZGKMBpp4YICWBxgK97eK3RM\", \"merchant_id\": \"GlobalTesting_LINEPAY\", \"details\":\"TapPay Test\", \"amount\": 100, \"cardholder\": { \"phone_number\": \"+886923456789\", \"name\": \"Jane Doe\", \"email\": \"Jane@Doe.com\", \"zip_code\": \"12345\", \"address\": \"123 1st Avenue, City, Country\", \"national_id\": \"A123456789\" },\"result_url\": {\"frontend_redirect_url\":\"%@\",\"backend_notify_url\":\"%@\"} }\'", prime, self.frontend_redirect_url, self.backend_notify_url];
                self.displayText.text = payment;
                NSLog(@"%@", payment);
            });
//          After get payment_url from TapPay, use redirect url function to LINE Pay payment page.
//            [linePay redirect:@"payment_url" withViewController:self completion:^(TPDLinePayResult * _Nonnull result) {
//                NSLog(@"LINE Pay Result : %@",result);
//            }]
            
            
            
        }]onFailureCallback:^(NSInteger status, NSString * _Nonnull message) {
            
            NSLog(@"status : %lu , message : %@", status, message);
            
        }] getPrime];
    }
}

@end
