//
//  TPDPiWallet.h
//  TPDirect
//
//  Created by Cherri Kevin on 2/16/22.
//  Copyright © 2022 tech.cherri. All rights reserved.
//

#import "TPDPiWalletResult.h"

@interface TPDPiWallet : NSObject

/// Set on getPrime Success Callback
///
/// @param callback (NSString *_Nullable prime)
- (instancetype _Nonnull)onSuccessCallback:(void(^_Nonnull)(NSString *_Nullable prime))callback;

/// Set on getPrime Failure Callback
///
/// @param callback (NSInteger status, NSString *_Nonnull message)
- (instancetype _Nonnull)onFailureCallback:(void(^_Nonnull)(NSInteger status , NSString *_Nonnull message))callback;

/// Setup TPDPiWallet Instance
///
/// @param returnUrl NSString, returnUrl
+ (instancetype _Nonnull)setupWithReturUrl: (NSString * _Nonnull)returnUrl;

/// This Method Will Get Prime, And Return Results Via onSuccessCallback and onFailureCallback.
- (void)getPrime;

/// Pass Payment Url to redirect to Pi Wallet App, complete Pi Wallet transaction Get Result via callback.
/// @param url Payment Url From Pay By Prime Success.
/// @param callback Get Pi Wallet Result, You Need to implement handleUrl in AppDelegate continueUserActivity
- (void)redirect:(NSString * _Nonnull)url completion:(void (^_Nonnull)(TPDPiWalletResult * _Nonnull result))callback;

/// Use this method to handle link come from TapPay,
/// and return results via redirectWith Url (TPDPiWalletResult callback).
/// @param link From TapPay Payment Result Url
+ (BOOL)handlePiWalletUniversalLink: (NSURL * _Nonnull)link;

/// Check device installed Pi Wallet App.
+ (BOOL)isPiWalletAvailable;

/// Go to App Store install Pi Wallet App.
+ (void)installPiWalletApp;

/// Set up Exception Observer
/// @param aSelector handle exception function.
+ (void)addExceptionObserver:(SEL)aSelector;

/// Use this function in your handle exception function to parse Pi Wallet result
/// @param notification , Handle exception
+ (TPDPiWalletResult *)parseURL:(NSNotification *)notification;

@end
