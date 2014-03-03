//
//  ChangeViewController.m
//  DailyNews
//
//  Created by 徐 焕 on 14-2-15.
//  Copyright (c) 2014年 徐 焕. All rights reserved.
//

#import "ChangeViewController.h"



@interface ChangeViewController ()

@end

@implementation ChangeViewController
{
    NSFileManager *fileManager ;
    NSArray *paths ;
    NSString *documentsDirectory;
    NSString *channelArraypath ;
    NSString *channelDictpath ;
    NSMutableArray *channelArray ;
    NSMutableDictionary *channelDict ;
    UITableViewCellEditingStyle _editingStyle;
}

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
    self.channelListTableview.delegate = self;
    self.channelListTableview.dataSource = self;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonSystemItemEdit target:self action:@selector(Editlist)];
    fileManager = [NSFileManager defaultManager];
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    channelArraypath =[documentsDirectory stringByAppendingPathComponent:@"channelArray.plist"];
    channelDictpath =[documentsDirectory stringByAppendingPathComponent:@"channelDict.plist"];
    channelArray = [[NSMutableArray alloc] initWithContentsOfFile:channelArraypath];
    channelDict = [[NSMutableDictionary alloc] initWithContentsOfFile:channelDictpath];
}

    
-(void)Editlist
{
    if([self.navigationItem.rightBarButtonItem.title  isEqual: @"编辑"])
    {
        [self.channelListTableview setEditing:YES animated:YES];
        self.navigationItem.rightBarButtonItem.title = @"确认";
    }
    else
    {
        [self.channelListTableview setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置成功" message:[NSString stringWithFormat:@"当前首页项为\n%@-%@-%@-%@-%@\n设置将在程序重启后生效",[channelDict objectForKey:[channelArray objectAtIndex:0]],[channelDict objectForKey:[channelArray objectAtIndex:1]],[channelDict objectForKey:[channelArray objectAtIndex:2]],[channelDict objectForKey:[channelArray objectAtIndex:3]],[channelDict objectForKey:[channelArray objectAtIndex:4]]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self.channelListTableview reloadData];
    }

}
    
    
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    
    {
        return [channelArray count];
    }
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        return 1;
    }
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        UITableViewCell *cell = nil;
        if( [tableView isEqual:self.channelListTableview]) {
            static NSString *cellIdentifier = @"Cells";
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if( cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            [cell setBackgroundColor:[UIColor clearColor]];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            cell.textLabel.highlightedTextColor = [UIColor redColor];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.font = [UIFont fontWithName:@"Arial" size:14.0];
            cell.textLabel.text = [channelDict objectForKey:[channelArray objectAtIndex:indexPath.row]];

        }
        return cell;
    }

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _editingStyle;
}

    
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *temp = [channelArray objectAtIndex:sourceIndexPath.row];
    if(sourceIndexPath.row<destinationIndexPath.row)
    {
        for(int i = sourceIndexPath.row;i<destinationIndexPath.row;i++){
            [channelArray replaceObjectAtIndex:i withObject:[channelArray objectAtIndex:i+1]];
        }
    }
    
    if(sourceIndexPath.row>destinationIndexPath.row)
    {
        for (int i = sourceIndexPath.row; i>destinationIndexPath.row; i--) {
            [channelArray replaceObjectAtIndex:i withObject:[channelArray objectAtIndex:i-1]];
        }
    }
    [channelArray replaceObjectAtIndex:destinationIndexPath.row withObject:temp];
    [channelArray writeToFile:channelArraypath atomically:YES];

}



@end
