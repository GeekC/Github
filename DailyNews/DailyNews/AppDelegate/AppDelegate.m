//
//  AppDelegate.m
//  DailyNews
//
//  Created by 徐 焕 on 14-2-15.
//  Copyright (c) 2014年 徐 焕. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "RNCachingURLProtocol.h"

@implementation AppDelegate
@synthesize fontname;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NSURLProtocol registerClass:[RNCachingURLProtocol class]];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self initialize];
    self.window.backgroundColor = [UIColor whiteColor];
    MainViewController *mvc = [[MainViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:mvc];
    self.window.rootViewController = nc;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)initialize
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    NSString *channelArraypath =[documentsDirectory stringByAppendingPathComponent:@"channelArray.plist"];
    NSString *channelDictpath =[documentsDirectory stringByAppendingPathComponent:@"channelDict.plist"];
    NSString *infopath =[documentsDirectory stringByAppendingPathComponent:@"info.plist"];
    NSMutableArray *channelArray = [[NSMutableArray alloc]initWithObjects:@"life",@"media",@"culture",@"sports",@"politics",@"world",@"edu",@"game",@"finance",@"haixia",@"auto", nil];;
    if([fileManager fileExistsAtPath:channelArraypath] == NO){
        [fileManager createFileAtPath:@"channelArray.plist" contents:nil attributes:nil];
        [channelArray writeToFile:channelArraypath atomically:YES];
    }
    if ([fileManager fileExistsAtPath:@"channelDict.plist"] == NO) {
        NSMutableDictionary *channelDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"文化",@"culture",@"生活",@"life",@"汽车",@"auto",@"传媒",@"media",@"国内",@"politics",@"国际",@"world",@"经济",@"finance",@"体育",@"sports",@"台湾",@"haixia",@"教育",@"edu",@"游戏",@"game", nil];
        [channelDict writeToFile:channelDictpath atomically:YES];
    }
    for (int i = 0 ; i < [channelArray count]; i++) {
        NSString *urlString = [NSString stringWithFormat:@"http://www.people.com.cn/rss/%@.xml",[channelArray objectAtIndex:i]];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",[channelArray objectAtIndex:i]]];
        if ([fileManager fileExistsAtPath:path] == NO) {
            NSURL    *url = [NSURL URLWithString:urlString];
            NSString *context = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
            NSMutableData *writer = [[NSMutableData alloc] init];
            [writer appendData:[context dataUsingEncoding:NSUTF8StringEncoding]];
            [writer writeToFile:path atomically:YES];
        }
    }
    if([fileManager fileExistsAtPath:infopath] == NO){
        NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Kailasa",@"字体",nil];
        [fileManager createFileAtPath:@"info.plist" contents:nil attributes:nil];
        [infoDict writeToFile:infopath atomically:YES];
    }
    NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] initWithContentsOfFile:infopath];
    fontname = [infoDict objectForKey:@"字体"];
    
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
