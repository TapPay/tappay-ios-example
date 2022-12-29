//
//  TPDPaymentBase.h
//  TPDirect
//
//  Created by Cherri_TapPay_LukeCho on 2022/4/15.
//  Copyright © 2022 tech.cherri. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TPDPaymentType) {
    TPDPaymentTypePlusPay
};

@interface TPDPaymentBase : NSObject

@property (assign, nonatomic) TPDPaymentType paymentType;

- (BOOL)isUniversalLink:(NSString *)UniversalLink;
- (BOOL)isURI:(NSString *)Uri;
- (BOOL)isPaymentAvailable;
- (BOOL)isPaymentParameterValid;

@end

NS_ASSUME_NONNULL_END
