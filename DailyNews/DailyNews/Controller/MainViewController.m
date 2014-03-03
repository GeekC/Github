//
//  MainViewController.m
//  DailyNews
//
//  Created by 徐 焕 on 14-2-15.
//  Copyright (c) 2014年 徐 焕. All rights reserved.
//

#import "MainViewController.h"
#import "SettingViewController.h"
#import "WebViewController.h"
#import "XMLSupport.h"
#import "AppDelegate.h"
#import "HMSideMenu.h"



@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@end

@implementation MainViewController
    {
        XMLSupport *xmlSupport ;
        NSMutableDictionary *channelDict;
        NSMutableArray *channelArray;
        UIAlertView *alert ;
        UIFont *sysfont;
    }

@synthesize sidebarBtn,newsTableView;
    
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
    [self Datainitialize];
    [self viewinitialize];
    [super viewDidLoad];
}

-(void)Datainitialize
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    NSString *channelArraypath =[documentsDirectory stringByAppendingPathComponent:@"channelArray.plist"];
    NSString *channelDictpath =[documentsDirectory stringByAppendingPathComponent:@"channelDict.plist"];
    xmlSupport = [[XMLSupport alloc] init];
    channelArray = [NSArray arrayWithContentsOfFile:channelArraypath];
    channelDict = [[NSMutableDictionary alloc]initWithContentsOfFile:channelDictpath];
    [self switchChannel:0];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    sysfont = [UIFont fontWithName:[myDelegate fontname] size:14];
}

-(void)viewinitialize
{
    
    UIView *Item1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [Item1 setMenuActionWithBlock:^{
        [self switchChannel:0];
    }];
    UIImageView *Icon1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [Icon1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[channelArray objectAtIndex:0]]]];
    [Item1 addSubview:Icon1];
    
    UIView *Item2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [Item2 setMenuActionWithBlock:^{
        [self switchChannel:1];
    }];
    UIImageView *Icon2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40 , 40)];
    [Icon2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[channelArray objectAtIndex:1]]]];
    [Item2 addSubview:Icon2];
    
    UIView *Item3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [Item3 setMenuActionWithBlock:^{
        [self switchChannel:2];
    }];
    UIImageView *Icon3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [Icon3 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[channelArray objectAtIndex:2]]]];
    [Item3 addSubview:Icon3];
    
    UIView *Item4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [Item4 setMenuActionWithBlock:^{
        [self switchChannel:3];
    }];
    UIImageView *Icon4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [Icon4 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[channelArray objectAtIndex:3]]]];
    [Item4 addSubview:Icon4];
    
    UIView *Item5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [Item5 setMenuActionWithBlock:^{
        [self switchChannel:4];
    }];
    UIImageView *Icon5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [Icon5 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[channelArray objectAtIndex:4]]]];
    [Item5 addSubview:Icon5];
    
    self.sideMenu = [[HMSideMenu alloc] initWithItems:@[Item1, Item2, Item3, Item4, Item5]];
    [self.sideMenu setItemSpacing:5.0f];
    [self.view addSubview:self.sideMenu];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_nc.png"] forBarMetrics:UIBarMetricsLandscapePhone];
    [self.navigationController.navigationBar setAlpha:1];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(Setting)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    self.newsTableView.delegate = self;
    self.newsTableView.dataSource = self;
    [self.newsTableView setSectionHeaderHeight:0];
    [self.newsTableView setSectionFooterHeight:0];
}



-(void)refresh
{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    alert = [[UIAlertView alloc]initWithTitle:nil
                                      message:@"刷新成功"
                                     delegate:nil
                            cancelButtonTitle:@"OK"
                            otherButtonTitles:nil];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    for (int i = 0 ; i < [channelArray count]; i++) {
        NSString *urlString = [NSString stringWithFormat:@"http://www.people.com.cn/rss/%@.xml",[channelArray objectAtIndex:i]];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",[channelArray objectAtIndex:i]]];
            NSURL    *url = [NSURL URLWithString:urlString];
            NSString *context = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
            NSMutableData *writer = [[NSMutableData alloc] init];
            [writer appendData:[context dataUsingEncoding:NSUTF8StringEncoding]];
            [writer writeToFile:path atomically:YES];
    }
    [alert show];
    app.networkActivityIndicatorVisible = NO;
}

-(void)Setting
{
    SettingViewController * svc = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
}

- (void)switchChannel:(int) i
{
    self.navigationItem.title = [NSString stringWithFormat:@"%@新闻",[channelDict objectForKey:[channelArray objectAtIndex:i]]];
    [xmlSupport initArray];
    [xmlSupport channelAnalysis:[channelArray objectAtIndex:i]];
    [xmlSupport itemAnalysis:[channelArray objectAtIndex:i]];
    [self.newsTableView reloadData];    
}

- (IBAction)sidebarBtnClick:(id)sender
{
    if (self.sideMenu.isOpen)
    {
        [self.sideMenu close];
        [sidebarBtn setImage:[UIImage imageNamed:@"Arrow Circle Left.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.sideMenu open];
        [sidebarBtn setImage:[UIImage imageNamed:@"Arrow Circle Right.png"] forState:UIControlStateNormal];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return [xmlSupport.linkArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if( [tableView isEqual:self.newsTableView]) {
        static NSString *cellIdentifier = @"Cells";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if( cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        cell.textLabel.highlightedTextColor = [UIColor redColor];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.font = sysfont;
        cell.textLabel.text = [xmlSupport.titleArray objectAtIndex:indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( [tableView isEqual:self.newsTableView] == NO)
        return ;
    [[tableView cellForRowAtIndexPath:indexPath] setTextColor:[UIColor redColor]];
    WebViewController *wvc = [[WebViewController alloc]init];
    wvc.urlString = [xmlSupport.linkArray objectAtIndex:indexPath.row];
    wvc.title = [xmlSupport.titleArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:wvc animated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.newsTableView deselectRowAtIndexPath:[self.newsTableView indexPathForSelectedRow] animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end





