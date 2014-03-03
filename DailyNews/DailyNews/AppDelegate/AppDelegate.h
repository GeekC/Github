//
//  AppDelegate.h
//  DailyNews
//
//  Created by 徐 焕 on 14-2-15.
//  Copyright (c) 2014年 徐 焕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *fontname;
}

@property (strong, nonatomic) UIWindow *window;
@property (readonly) NSString *fontname;

@end
