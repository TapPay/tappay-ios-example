//
//  ViewController.m
//  TPDCardholderFormExample
//
//  Created by Kevin Kao on 2025/11/5.
//

#import "ViewController.h"
#import <TPDirect/TPDirect.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *cardholderFormView;
@property (strong, nonatomic) TPDCardholderForm   *tpdCardholderForm;
@property (weak, nonatomic) IBOutlet UIButton *payButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tpdCardholderForm = [TPDCardholderForm setupWithContainer:self.cardholderFormView];
    
    [self.tpdCardholderForm setErrorColor:[self colorWithRGB:@"FF5858" withAlpha:1]];
    
    [self.tpdCardholderForm onFormUpdated:^(TPDStatus * _Nonnull status) {
            [self.payButton setEnabled:[status isCanGetCardholderPrime]];
    }];
}

- (IBAction)doneAction:(id)sender {
    
    [[[self.tpdCardholderForm onSuccessCallback:^(NSString * _Nullable prime, NSInteger status, NSString * _Nonnull message) {
                NSLog(@"prime: %@, status: %d, message: %@", prime, status, message);
        }] onFailureCallback:^(NSInteger status, NSString * _Nonnull message) {
            NSLog(@"status: %d, message: %@", status, message);
        }] getCardholderPrime];
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
