//
//  TPDIPassMoneyResult.h
//  TPDirect
//
//  Created by Kevin Kao on 2025/5/5.
//  Copyright © 2025 tech.cherri. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPDIPassMoneyResult : NSObject

@property (strong, nonatomic) NSString * recTradeId;
@property (strong, nonatomic) NSString * orderNumber;
@property (assign, nonatomic) NSInteger  status;
@property (strong, nonatomic) NSString * bankTransactionId;

@end

NS_ASSUME_NONNULL_END
