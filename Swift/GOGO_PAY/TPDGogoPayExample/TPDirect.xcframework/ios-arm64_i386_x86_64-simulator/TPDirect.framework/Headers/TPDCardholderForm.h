//
//  TPDCard.h
//
//  Copyright © 2017年 Cherri Tech, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPDCard.h"

@class TPDStatus;
@class TPDCard;

@interface TPDCardholderForm : UIView

#pragma mark - Initialize

/**
 This Method Will Set Up TPDCardholderForm And Return TPDCardholderForm Instance

 @param view Use Your Customized View To Display TPDCardholderForm.
 @return TPDCardholderForm Instance
 */
+ (instancetype)setupWithContainer:(UIView *)view;

#pragma mark - Function

/**
 Updated Current TPDStatus

 @param callback (TPDStatus *_Nonnull status)
 @return TPDCardholderForm Instance
 */
-(instancetype _Nonnull)onFormUpdated:(void(^_Nonnull)(TPDStatus *_Nonnull status))callback;

/**
 Set Error Status TextField TextColor

 @param color Error Color
 */
- (void)setErrorColor:(UIColor * _Nonnull)color;

/**
 Set OK Status TextField TextColor

 @param color Ok Color
 */
- (void)setOkColor:(UIColor * _Nonnull)color;

/**
 Set Normal Status TextField TextColor

 @param color NormalColor
 */
- (void)setNormalColor:(UIColor * _Nonnull)color;

/**
 
 @return NSString, Name EN.
 */
- (NSString *)getNameEn;

/**
 
 @return NSString, Email.
 */
- (NSString *)getEmail;

/**
 
 @return NSString, Phone Number Country Code.
 */
- (NSString *)getPhoneNumberCountryCode;

/**
 
 @return NSString, Phone Number.
 */
- (NSString *)getPhoneNumber;

/**
Set TPDCardholderForm display Email field.

@param showEmailField BOOL
*/
- (void)setShowEmailField:(BOOL)showEmailField;

/**
Set TPDCardholderForm display PhoneNumber field.

@param showPhoneNumberField BOOL
*/
- (void)setShowPhoneNumberField:(BOOL)showPhoneNumberField;

/**
 Set On CreateToken Success Callback
 Remember To Send 'prime' Back To Your Server.

 @param callback (NSString *_Nullable prime, TPDCardInfo *_Nullable cardInfo)
 @return TPDCard Instance
 */
- (instancetype _Nonnull)onSuccessCallback:(void(^ _Nonnull)(NSString *_Nullable prime, NSInteger status,
                                                             NSString *_Nonnull message))callback;


/**
 Set On CreateToken Failure Callback

 @param callback (NSInteger status, NSString *_Nonnull message)
 @return TPDCard Instance
 */
- (instancetype _Nonnull)onFailureCallback:(void(^ _Nonnull)(NSInteger status,
                                                             NSString *_Nonnull message))callback;

/**
 
 This Method Will Get Cardholder Prime , And Return Results Via onSuccessCallback and onFailureCallback.
 
 */
- (void)getCardholderPrime;
@end
