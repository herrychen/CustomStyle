//
//  AppDelegate.m
//  CustomStyle
//
//  Created by  陈文娟 on 14-3-29.
//  Copyright (c) 2014年 heinqi. All rights reserved.
//

#import "AppDelegate.h"
#import "WUIImage.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString*_imagePath=[NSHomeDirectory() stringByAppendingPathComponent:@"images/"];
    
    
    NSArray *fileList = [[NSArray alloc] init];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    //    以下这段代码则可以列出给定一个文件夹里的所有子文件夹名
    fileList = [fileManager contentsOfDirectoryAtPath:_imagePath error:&error];
    
    if (fileList.count<1) {
        [WUIImage SeparateImage:[UIImage imageNamed:@"first.png"] ByX:3 andY:3 cacheQuality:.8];

    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
