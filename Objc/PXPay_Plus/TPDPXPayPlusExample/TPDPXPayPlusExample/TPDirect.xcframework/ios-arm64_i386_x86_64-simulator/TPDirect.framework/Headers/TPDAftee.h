//
//  TPDAftee.h
//  TPDirect
//
//  Created by Kevin Kao on 2025/7/1.
//  Copyright © 2025 tech.cherri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPDPaymentBase.h"
#import "TPDPaymentResultBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPDAftee : TPDPaymentBase

/// Set on getPrime Success Callback
/// - Parameter callback: (NSString * _Nullable prime)
- (instancetype _Nonnull)onSuccessCallback:(void(^_Nonnull)(NSString *_Nullable prime))callback;

/// Set on getPrime Failure Callback
/// - Parameter callback: (NSInteger status, NSString * _Nonnull message)
- (instancetype _Nonnull)onFailureCallback:(void(^_Nonnull)(NSInteger status , NSString *_Nonnull message))callback;

/// Setup TPDAftee Instance.
/// - Parameter returnUrl: NSString , returnUrl.
+ (instancetype)setupWithReturnUrl:(NSString *)returnUrl;

/// This Method Will Get Prime, And Return Results Via onSuccessCallback and onFailureCallback.
- (void)getPrime;


/// Pass Payment Url to redirect to Aftee Web, complete Aftee Transaction Get Result via Callback
/// - Parameters:
///   - url: Payment Url Get From Pay By Prime Success.
///   - callback: Get Aftee Result, You Need to implement handleAfteeUrl in AppDelegate
- (void)redirect:(NSString * _Nonnull)url completion:(void (^_Nonnull)(TPDAfteeResult * _Nonnull result))callback;


/// Use this method to handle url come from TapPay ,
/// - Parameter url: From TapPay Payment Result Url
+ (BOOL)handleAfteeUrl: (NSURL * _Nonnull)url;


@end

NS_ASSUME_NONNULL_END
