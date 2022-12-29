//
//  TPDPlusPay.h
//  TPDirect
//
//  TPDirect iOS SDK
//  Created by Cherri_TapPay_LukeCho on 2022/4/15.
//  Copyright © 2022 tech.cherri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPDPaymentBase.h"
#import "TPDPaymentResultBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPDPlusPay : TPDPaymentBase

/// Set on getPrime Success Callback
/// @param callback (NSString * _Nullable prime)
- (instancetype _Nonnull)onSuccessCallback:(void(^_Nonnull)(NSString *_Nullable prime))callback;

/// Set on getPrime Failure Callback
/// @param callback (NSInteger status, NSString * _Nonnull message)
- (instancetype _Nonnull)onFailureCallback:(void(^_Nonnull)(NSInteger status , NSString *_Nonnull message))callback;

/**
 Setup TPDPlusPay Instance.

 @param returnUrl NSString , returnUrl.
 @return TPDPlusPay Instance.
 */

+ (instancetype)setupWithReturnUrl:(NSString *)returnUrl;

/// This Method Will Get Prime, And Return Results Via onSuccessCallback and onFailureCallback.
- (void)getPrime;

/**
 This Method Will Get Prime , And Return Results Via successCallback and failureCallback.
 
 @param successCallback (NSString *_Nullable prime)
 @param failureCallback (NSInteger status, NSString *_Nonnull message)
 */

- (void)getPrimeWithSuccess:(void(^)(NSString *_Nullable prime))successCallback
                    failure:(void(^)(NSInteger status , NSString *_Nonnull message))failureCallback;

- (void)redirect:(NSString * _Nonnull)url completion:(void (^_Nonnull)(TPDPlusPayResult * _Nonnull result))callback;

/// Use this method to handle link come from TapPay,
/// and return results via redirectWith Url (TPDPlusPay callback).
/// @param link From TapPay Payment Result Url
+ (BOOL)handlePlusPayUniversalLink: (NSURL * _Nonnull)link;

/// Set up Exception Observer
/// @param aSelector handle exception function
+ (void)addExceptionObserver:(SEL)aSelector;

/// Use this function in your handle exception function to parse Plus Pay result
/// @param notification, Handle exception
+ (TPDPlusPayResult *)parseURL:(NSNotification *)notification;

/// Check device installed Plus Pay App.
+ (BOOL)isPlusPayAvailable;

@end

NS_ASSUME_NONNULL_END
