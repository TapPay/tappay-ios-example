//
//  ViewController.m
//  TPDirect_Example
//
//  Created by Cherri on 2017/11/3.
//  Copyright © 2017年 Cherri Tech Inc. All rights reserved.
//

#import "ViewController.h"
#import <TPDirect/TPDirect.h>


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UITextView *displayText;


@property (strong, nonatomic) TPDForm *tpdForm;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 1. Setup TPDForm With Your Customized CardView, Recommend(width:260, height:80)
    self.tpdForm = [TPDForm setupWithContainer:self.cardView];
    
    // 2. Setup TPDForm Text Color
    [self.tpdForm setErrorColor:[self colorWithRGB:@"D62D20" withAlpha:1.0]];
    [self.tpdForm setOkColor:[self colorWithRGB:@"008744" withAlpha:1.0]];
    [self.tpdForm setNormalColor:[self colorWithRGB:@"0F0F0F" withAlpha:1.0]];
    
    // 3. Setup TPDForm onFormUpdated Callback
    [self.tpdForm onFormUpdated:^(TPDStatus * _Nonnull status) {
        
        __weak typeof(self) weakSelf = self;
        
        [weakSelf.payButton setEnabled:[status isCanGetPrime]];
        weakSelf.payButton.alpha = [status isCanGetPrime] ? 1.0 : 0.25;
    }];
    // 4. Enable Cardholder field
    [self.tpdForm setShowNameEnField:true];
    [self.tpdForm setShowEmailField:true];
    [self.tpdForm setShowPhoneNumberField:true];
    
    
    // Button Disable (Default)
    [self.payButton setEnabled:false];
    self.payButton.alpha = 0.25;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)doneAction:(id)sender {
    
    // Example Card
    // Number : 4242 4242 4242 4242
    // DueMonth : 01
    // DueYear : 23
    // CCV : 123
    
    // 1. Setup TPDCard.
    TPDCard *tpdCard = [TPDCard setup:self.tpdForm];
    
    // 2. Setup TPDCard on Success Callback.
    [[[tpdCard onSuccessCallback:^(NSString * _Nullable prime, TPDCardInfo * _Nullable cardInfo, NSString * cardIdentifier, NSDictionary * merchantReferenceInfo) {
        //
        
        NSString *result = [NSString stringWithFormat:@"Prime : %@,\n merchantReferenceInfo: %@,\n LastFour : %@,\n Bincode : %@,\n Issuer : %@,\n Issuer_zh_tw: %@,\n bank_id: %@,\n cardType : %lu,\n funding : %lu,\n country : %@,\n countryCode : %@,\n level : %@", prime, merchantReferenceInfo,cardInfo.lastFour, cardInfo.bincode, cardInfo.issuer, cardInfo.issuerZhTw, cardInfo.bankId, cardInfo.cardType, cardInfo.funding , cardInfo.country,cardInfo.countryCode,cardInfo.level];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *payment = [NSString stringWithFormat:@"Use below cURL to proceed the payment.\ncurl -X POST \\\nhttps://sandbox.tappaysdk.com/tpc/payment/pay-by-prime \\\n-H \'content-type: application/json\' \\\n-H \'x-api-key: partner_6ID1DoDlaPrfHw6HBZsULfTYtDmWs0q0ZZGKMBpp4YICWBxgK97eK3RM\' \\\n-d \'{ \n \"prime\": \"%@\", \"partner_key\": \"partner_6ID1DoDlaPrfHw6HBZsULfTYtDmWs0q0ZZGKMBpp4YICWBxgK97eK3RM\", \"merchant_id\": \"GlobalTesting_CTBC\", \"details\":\"TapPay Test\", \"amount\": 100, \"cardholder\": { \"phone_number\": \"+886923456789\", \"name\": \"Jane Doe\", \"email\": \"Jane@Doe.com\", \"zip_code\": \"12345\", \"address\": \"123 1st Avenue, City, Country\", \"national_id\": \"A123456789\" }, \"remember\": true }\'",prime];
            self.displayText.text = payment;
            NSLog(@"%@", payment);
        });
        
        NSLog(@"%@", result);
        [self showResult:result];
        
    // 3. Setup TPDCard on Failure Callback.
    }] onFailureCallback:^(NSInteger status, NSString * _Nonnull message) {
        //
        NSString *result = [NSString stringWithFormat:@"Status : %ld, Message : %@", status, message];
        
        NSLog(@"%@", result);
        [self showResult:result];
        
    // 4. Get Prime WIth TPDCard.
    }] getPrime];
    
    
    

}


#pragma mark - function
- (void)showResult:(NSString *)message {
    
    UIAlertController *alertController  = [UIAlertController alertControllerWithTitle:@"Result"
                                                                              message:message
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *doneAction           = [UIAlertAction actionWithTitle:@"Done"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:nil];
    [alertController addAction:doneAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //
        [self presentViewController:alertController animated:YES completion:nil];
    });
    
}

- (UIColor *)colorWithRGB:(NSString *)rgbString withAlpha:(CGFloat)alpha {
    
    NSScanner *scanner = [NSScanner scannerWithString:[rgbString lowercaseString]];
    unsigned int baseColor;
    [scanner scanHexInt:&baseColor];
    
    CGFloat red   = ((baseColor & 0xFF0000) >> 16) / 255.0f;
    CGFloat green = ((baseColor & 0x00FF00) >> 8)  / 255.0f;
    CGFloat blue  =  (baseColor & 0x0000FF) / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
}


@end
