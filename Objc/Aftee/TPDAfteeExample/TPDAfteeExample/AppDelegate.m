//
//  AppDelegate.m
//  TPDAfteeExample
//
//  Created by Kevin Kao on 2025/7/9.
//

#import "AppDelegate.h"
#import <TPDirect/TPDirect.h>

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [TPDSetup setWithAppId:11340 withAppKey:@"app_whdEWBH8e8Lzy4N6BysVRRMILYORF6UxXbiOFsICkz0J9j1C0JUlCHv1tVJC" withServerType:TPDServer_SandBox];
    return YES;
}


@end
