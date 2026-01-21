//
//  TPDStatus.h
//  TPDirect
//
//  Created by liaozonglun on 07/07/2017.
//  Copyright © 2017 tech.cherri. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FormStatus) {
    FormStatus_OK   ,
    FormStatus_Empty,
    FormStatus_Error,
    FormStatus_Typing
    
};

typedef NS_ENUM(NSInteger, TextFieldStatus) {
    TextFieldStatus_Exists    ,
    TextFieldStatus_Not_Exists,
};

@interface TPDStatus : NSObject

@property FormStatus        cardNumberStatus;
@property FormStatus        expirationDateStatus;
@property FormStatus        ccvStatus;
@property FormStatus        nameEnStatus;
@property FormStatus        emailStatus;
@property FormStatus        phoneNumberCountryCodeStatus;
@property FormStatus        phoneNumberStatus;
@property TextFieldStatus   nameEnTextFieldStatus;
@property TextFieldStatus   emailTextFieldStatus;
@property TextFieldStatus   phoneNumberTextFieldStatus;

#pragma mark - Function
/**
 @return TPDStatus Instance.
 */
+ (instancetype _Nonnull)status;

#pragma mark - Function
/**
 This method will return boolean value for checking getPrime status.

 @return Bool, getPrime status.
 */
- (BOOL)isCanGetPrime;

/**
 This method will return boolean value for checking getCardholderPrime status.

 @return Bool, getPrime status.
 */
- (BOOL)isCanGetCardholderPrime;

/**
 This method will return boolean value for checking error status.

 @return Bool, error status.
 */
- (BOOL)isHasAnyError;


- (BOOL)isCanGetCCVPrime;


@end

