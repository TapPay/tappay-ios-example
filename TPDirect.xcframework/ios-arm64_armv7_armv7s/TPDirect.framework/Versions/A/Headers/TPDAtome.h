//
//  TPDAtome.h
//  TPDirect
//
//  TPDirect iOS SDK - v2.14.0
//  Created by Cherri Kevin on 12/27/21.
//  Copyright © 2021 tech.cherri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPDAtomeResult.h"
NS_ASSUME_NONNULL_BEGIN

@interface TPDAtome : NSObject


/// Set on getPrime Success Callback
/// @param callback (NSString * _Nullable prime)
- (instancetype _Nonnull)onSuccessCallback:(void(^_Nonnull)(NSString *_Nullable prime))callback;

/// Set on getPrime Failure Callback
/// @param callback (NSInteger status, NSString * _Nonnull message)
- (instancetype _Nonnull)onFailureCallback:(void(^_Nonnull)(NSInteger status , NSString *_Nonnull message))callback;

/// Setup TPDAtome Instance
/// @param returnUrl NSString, returnUrl
+ (instancetype _Nonnull)setupWithReturnUrl: (NSString * _Nonnull)returnUrl;

/// This Method Will Get Prime, And Return Results Via onSuccessCallback and onFailureCallback.
- (void)getPrime;

/// Pass Payment Url to redirect to Atome App, complete Atome transaction Get Result via callback.
/// @param url Payment Url From Pay By Prime Success.
/// @param callback Get Easy Wallet Result, You Need to implement handleUrl in AppDelegate continueUserActivity
- (void)redirect:(NSString * _Nonnull)url completion:(void (^_Nonnull)(TPDAtomeResult * _Nonnull result))callback;

/// Use this method to handle link come from TapPay,
/// and return results via redirectWith Url (TPDAtome callback).
/// @param link From TapPay Payment Result Url
+ (BOOL)handleAtomeUniversalLink: (NSURL * _Nonnull)link;

/// Check device installed Atome App.
+ (BOOL)isAtomeAvailable;

/// Go to App Store install Atome App.
+ (void)installAtomeApp;

/// Set up Exception Observer
/// @param aSelector handle exception function
+ (void)addExceptionObserver:(SEL)aSelector;

/// Use this function in your handle exception function to parse Atome result
/// @param notification, Handle exception
+ (TPDAtomeResult *)parseURL:(NSNotification *)notification;


@end

NS_ASSUME_NONNULL_END
