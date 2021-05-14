//
//  ViewController.m
//  Direct_Pay_CCV_Form
//
//  Created by Cherri Kevin on 5/13/21.
//

#import "ViewController.h"
#import <TPDirect/TPDirect.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *ccvFormView;


@property (strong, nonatomic) TPDCcvForm * tpdCcvForm;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tpdCcvForm = [TPDCcvForm setupCCVWithContainer:self.ccvFormView];
    
    [self.tpdCcvForm onCCVFormUpdated:^(TPDStatus * _Nullable status) {
        NSLog(@"isCanGetCCVPrime : %d", [status isCanGetCCVPrime]);
    }];
    
    
}
- (IBAction)getCCVPrime:(id)sender {
    TPDCcv *tpdCcv = [TPDCcv setup:self.tpdCcvForm];
    
    [[[tpdCcv onSuccessCallback:^(NSString * _Nonnull prime) {
        NSLog(@"CCV Prime : %@", prime);
    }] onFailureCallback:^(NSInteger status, NSString * _Nonnull message) {
        NSLog(@"status : %ld, message : %@", status, message);
    }] getPrime];
}



@end
