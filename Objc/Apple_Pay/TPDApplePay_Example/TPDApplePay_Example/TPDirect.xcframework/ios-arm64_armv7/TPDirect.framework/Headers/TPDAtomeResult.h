//
//  TPDAtomeResult.h
//  TPDirect
//
//  TPDirect iOS SDK - v2.14.0
//  Created by Cherri Kevin on 12/27/21.
//  Copyright © 2021 tech.cherri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPDAtomeResult : NSObject

@property (strong, nonatomic) NSString * recTradeId;
@property (strong, nonatomic) NSString * orderNumber;
@property (assign, nonatomic) NSInteger  status;
@property (strong, nonatomic) NSString * bankTransactionId;


@end
