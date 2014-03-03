//
//  WebViewController.h
//  DailyNews
//
//  Created by 徐 焕 on 14-2-15.
//  Copyright (c) 2014年 徐 焕. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface WebViewController :UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *wvc;
@property (copy,nonatomic) NSString *urlString,*title;
@end
