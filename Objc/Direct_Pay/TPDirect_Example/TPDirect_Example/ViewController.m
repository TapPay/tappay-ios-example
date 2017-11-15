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
    [[[tpdCard onSuccessCallback:^(NSString * _Nullable prime, TPDCardInfo * _Nullable cardInfo) {
        //
        
        NSString *result = [NSString stringWithFormat:@"Prime : %@,\n LastFour : %@,\n Bincode : %@,\n Issuer : %@,\n cardType : %lu,\n funding : %lu,\n country : %@,\n countryCode : %@,\n level : %@", prime, cardInfo.lastFour, cardInfo.bincode, cardInfo.issuer, cardInfo.cardType, cardInfo.funding , cardInfo.country,cardInfo.countryCode,cardInfo.level];
        
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
- (IBAction)getFraudIdAction:(id)sender {
    
    // Get Fraud ID
    NSString *fraudId = [[TPDSetup shareInstance] getFraudID];
    
    // If use pay-by-token. Get fraud ID before first, and send fraud id to your server.
    NSString *result = [NSString stringWithFormat:@"Send Fraud ID :'%@' to your server, bring it on when you request pay-by-token API", fraudId];
    
    NSLog(@"Fraud ID : %@", fraudId);
    [self showResult:result];
    
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
