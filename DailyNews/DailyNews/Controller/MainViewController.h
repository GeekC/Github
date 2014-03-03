//
//  MainViewController.h
//  DailyNews
//
//  Created by 徐 焕 on 14-2-15.
//  Copyright (c) 2014年 徐 焕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSideMenu.h"


@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;
@property (nonatomic, assign) BOOL menuIsVisible;
@property (nonatomic, strong) HMSideMenu *sideMenu;
@property (weak, nonatomic) IBOutlet UIButton *sidebarBtn;
- (void)switchChannel:(int) i;
- (IBAction)sidebarBtnClick:(id)sender;

@end
