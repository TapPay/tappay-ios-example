//
//  AppDelegate.m
//  TPDLinePay_Example
//
//  Created by 高嘉琦 on 2018/1/2.
//  Copyright © 2018年 Cherri Tech Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <TPDirect/TPDirect.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [TPDSetup setWithAppId:11340 withAppKey:@"app_whdEWBH8e8Lzy4N6BysVRRMILYORF6UxXbiOFsICkz0J9j1C0JUlCHv1tVJC" withServerType:TPDServer_SandBox];
    
    
    [TPDLinePay addExceptionObserver:(@selector(tappayLinePayExceptionHandler:))];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
// For version higher than iOS 9.0
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    BOOL tapPayHandled = [TPDLinePay handleURL:url];
    if (tapPayHandled){
        return YES;
    }
    return NO;
}

// For version lower than iOS 9.0
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL tapPayHandled = [TPDLinePay handleURL:url];
    if (tapPayHandled){
        return YES;
    }
    return NO;
}

//When exception happened receive notification.
- (void)tappayLinePayExceptionHandler:(NSNotification *)notification {

    TPDLinePayResult * result = [TPDLinePay parseURL:notification];
    
    NSLog(@"status : %@ , orderNumber : %@ , recTradeId : %@ , bankTransactionId : %@",result.status , result.orderNumber , result.recTradeId , result.bankTransactionId);
    
}


@end
