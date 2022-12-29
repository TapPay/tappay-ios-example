//
//  TPDPaymentResultBase.h
//  TPDirect
//
//  Created by Cherri_TapPay_LukeCho on 2022/4/15.
//  Copyright © 2022 tech.cherri. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPDPaymentResultBase : NSObject

@property (strong ,nonatomic) NSString * recTradeId;
@property (strong ,nonatomic) NSString * orderNumber;
@property (assign ,nonatomic) NSInteger status;
@property (strong ,nonatomic) NSString * bankTransactionId;

@end

@interface TPDPlusPayResult : TPDPaymentResultBase

@end

NS_ASSUME_NONNULL_END
