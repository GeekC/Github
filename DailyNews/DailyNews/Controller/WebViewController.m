//
//  WebViewController.m
//  DailyNews
//
//  Created by 徐 焕 on 14-2-15.
//  Copyright (c) 2014年 徐 焕. All rights reserved.
//

#import "WebViewController.h"
#import "AppDelegate.h"

@interface WebViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@end

@implementation WebViewController
{
    NSString *sysfont;
}
@synthesize urlString;
    
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sysfont = [myDelegate fontname];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    _wvc.backgroundColor = [UIColor clearColor];
    _wvc.opaque = NO;
    _wvc.delegate = self;
    _wvc.scalesPageToFit = YES;
    NSURL *url= [NSURL URLWithString:urlString];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url];
    [_wvc loadRequest:request];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
   [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
@end
