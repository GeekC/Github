//
//  SettingViewController.m
//  DailyNews
//
//  Created by 徐 焕 on 14-2-15.
//  Copyright (c) 2014年 徐 焕. All rights reserved.
//

#import "SettingViewController.h"
#import "ChangeViewController.h"
#import "AppDelegate.h"

@interface SettingViewController ()
{
    NSMutableArray *fontArray;
    NSString *sysfont;
    float cachesize;
}

@end

@implementation SettingViewController

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
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    self.navigationItem.title = @"系统设置";
    [self.TextEmp setTextAlignment:NSTextAlignmentCenter];
    self.TextEmp.numberOfLines = 0;
    self.TextEmp.lineBreakMode = NSLineBreakByWordWrapping;
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    cachesize =[self folderSizeAtPath:cachesPath];
    self.cachesizelbl.text = [NSString stringWithFormat:@"当前缓存大小为:%.2fM",cachesize];
    _FontPicker.delegate = self;
    _FontPicker.dataSource = self;
    fontArray = [[NSMutableArray alloc] init];
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames )
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames )
        {
            [fontArray addObject:fontName];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)ChangeChannel:(id)sender {
    ChangeViewController *cvc = [[ChangeViewController alloc]init];
    [self.navigationController pushViewController:cvc animated:YES];
}

- (IBAction)ApplyFont:(id)sender {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    NSString *infopath =[documentsDirectory stringByAppendingPathComponent:@"info.plist"];
    NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:sysfont,@"字体",nil];
    [fileManager createFileAtPath:@"info.plist" contents:nil attributes:nil];
    [infoDict writeToFile:infopath atomically:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"字体修改成功，重启程序后生效" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)CleanCache:(id)sender {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSEnumerator *childFilesEnumerator = [[fileManager subpathsAtPath:cachesPath] objectEnumerator];
    NSString* fileName;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        cachesize -= (float)[[fileManager attributesOfItemAtPath:[cachesPath stringByAppendingPathComponent:fileName] error:nil] fileSize]/(1024*1024);
        self.cachesizelbl.text = [NSString stringWithFormat:@"当前缓存大小为:%.2fM",cachesize];
        [fileManager removeItemAtPath:[cachesPath stringByAppendingPathComponent:fileName] error:NULL];
    }
}


- (long long) fileSizeAtPath:(NSString *) filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]){
        return [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

- (float) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath])
        return 0;
    NSEnumerator *childFilesEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        folderSize += [self fileSizeAtPath:[folderPath stringByAppendingPathComponent:fileName]];
    }
    return folderSize/(1024.0*1024.0);
}

#pragma mark pickerview function

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:UITextAlignmentLeft];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [fontArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [fontArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    sysfont = [fontArray objectAtIndex:row];
    self.TextEmp.font = [UIFont fontWithName:[fontArray objectAtIndex:row] size:14];
    self.TextEmp.text = [NSString stringWithFormat:@"当前字体为%@\n示例：你好ABCabc123",[fontArray objectAtIndex:row]];
}

@end
