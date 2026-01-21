//
//  TPDPiWalletResult.h
//  TPDirect
//
//  Created by Cherri Kevin on 2/16/22.
//  Copyright © 2022 tech.cherri. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TPDPiWalletResult : NSObject

@property (strong, nonatomic) NSString * recTradeId;
@property (strong, nonatomic) NSString * orderNumber;
@property (assign, nonatomic) NSInteger  status;
@property (strong, nonatomic) NSString * bankTransactionId;

@end

