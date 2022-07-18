//
//  ViewController.m
//  TPDPlusPayExample
//
//  Created by Cherri_TapPay_LukeCho on 2022/4/28.
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

- (IBAction)startPlusPay:(id)sender {
    TPDPlusPay * plusPay = [TPDPlusPay setupWithReturnUrl:@"https://google.com.tw"];
    NSLog(@"%d", [TPDPlusPay isPlusPayAvailable]);
    [[[plusPay onSuccessCallback:^(NSString * _Nullable prime) {
        NSString *payment = [NSString stringWithFormat:@"Use below cURL to get the payment_url.\ncurl -X POST \\\nhttps://sandbox.tappaysdk.com/tpc/payment/pay-by-prime \\\n-H \'content-type: application/json\' \\\n-H \'x-api-key: partner_6ID1DoDlaPrfHw6HBZsULfTYtDmWs0q0ZZGKMBpp4YICWBxgK97eK3RM\' \\\n-d \'{ \n \"prime\": \"%@\", \"partner_key\": \"partner_6ID1DoDlaPrfHw6HBZsULfTYtDmWs0q0ZZGKMBpp4YICWBxgK97eK3RM\", \"merchant_id\": \"GlobalTesting_PLUS_PAY_Manual_CAP\", \"details\":\"TapPay Test\", \"amount\": 100, \"cardholder\": { \"phone_number\": \"+886923456789\", \"name\": \"Jane Doe\", \"email\": \"Jane@Doe.com\", \"zip_code\": \"12345\", \"address\": \"123 1st Avenue, City, Country\", \"national_id\": \"A123456789\" },\"result_url\": {\"frontend_redirect_url\":\"%@\",\"backend_notify_url\":\"%@\"} }\'", prime, self.frontend_redirect_url, self.backend_notify_url];

        NSLog(@"%@", payment);
    }] onFailureCallback:^(NSInteger status, NSString * _Nonnull message) {
        NSLog(@"status : %ld, msg: %@", status, message);
    }]getPrime];
}

@end
