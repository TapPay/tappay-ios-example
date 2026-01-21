//
//  TPDPxPayPlus.h
//  TPDirect
//
//  Created by Kevin Kao on 2025/4/15.
//  Copyright © 2025 tech.cherri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPDPxPayPlusResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPDPxPayPlus : NSObject

/// Set on getPrime Success Callback
/// - Parameter callback: (NSString * _Nullable prime)
- (instancetype _Nonnull)onSuccessCallback:(void(^_Nonnull)(NSString *_Nullable prime))callback;

/// Set on getPrime Failure Callback
/// - Parameter callback: (NSInteger status, NSString * _Nonnull message)
- (instancetype _Nonnull)onFailureCallback:(void(^_Nonnull)(NSInteger status , NSString *_Nonnull message))callback;

/// Setup TPDPxPayPlus Instance.
/// - Parameter returnUrl: NSString , returnUrl.
+ (instancetype)setupWithReturnUrl:(NSString *)returnUrl;

/// This Method Will Get Prime, And Return Results Via onSuccessCallback and onFailureCallback.
- (void)getPrime;

/// Pass Payment Url to redirect to PXPay Plus App, complete PXPay Plus Transaction Get Result via Callback
/// - Parameters:
///   - url: Payment Url Get From Pay By Prime Success.
///   - callback: Get PXPay Plus Result, You Need to implement handlePxPayPlusUniversalLink in AppDelegate continueUserActivity
- (void)redirect:(NSString * _Nonnull)url completion:(void (^_Nonnull)(TPDPxPayPlusResult * _Nonnull result))callback;

/// Use this method to handle link come from TapPay ,
/// - Parameter link: From TapPay Payment Result Url
+ (BOOL)handlePxPayPlusUniversalLink: (NSURL * _Nonnull)link;

/// Set up Exception Observer
/// - Parameter aSelector: handle exception function.
+ (void)addExceptionObserver:(SEL)aSelector;

/// Use this function in your handle exception function to parse PXPay Plus result
/// - Parameter notification: Handle exception
+ (TPDPxPayPlusResult *)parseURL:(NSNotification *)notification;


@end

NS_ASSUME_NONNULL_END
