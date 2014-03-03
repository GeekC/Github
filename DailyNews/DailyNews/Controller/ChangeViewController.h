//
//  ChangeViewController.h
//  DailyNews
//
//  Created by 徐 焕 on 14-2-15.
//  Copyright (c) 2014年 徐 焕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
    @property (weak, nonatomic) IBOutlet UITableView *channelListTableview;

-(void)Editlist;
@end
