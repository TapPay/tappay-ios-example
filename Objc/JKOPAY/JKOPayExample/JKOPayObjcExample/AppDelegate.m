//
//  AppDelegate.m
//  JKOPayObjcExample
//
//  Created by Cherri Kevin on 4/14/20.
//  Copyright © 2020 Cherri. All rights reserved.
//

#import "AppDelegate.h"
#import <TPDirect/TPDirect.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [TPDSetup setWithAppId:11340 withAppKey:@"app_whdEWBH8e8Lzy4N6BysVRRMILYORF6UxXbiOFsICkz0J9j1C0JUlCHv1tVJC" withServerType:TPDServer_SandBox];

    
    [TPDJKOPay addExceptionObserver:@selector(tappayJKOPayException:)];
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (void)tappayJKOPayException:(NSNotification *)notification {
    
    TPDJKOPayResult *result = [TPDJKOPay parseURL:notification];
    
    NSString *str =[NSString stringWithFormat:@"status : %d ,\n order_number : %@ ,\n rec_trade_id : %@ ,\n bank_transaction_id : %@",result.status,result.orderNumber,result.recTradeId,result.bankTransactionId];
    
}


@end
