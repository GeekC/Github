//
//  SettingViewController.h
//  DailyNews
//
//  Created by 徐 焕 on 14-2-15.
//  Copyright (c) 2014年 徐 焕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *btn_Change;
@property (weak, nonatomic) IBOutlet UIPickerView *FontPicker;
@property (weak, nonatomic) IBOutlet UILabel *TextEmp;
@property (weak, nonatomic) IBOutlet UIButton *cleanCache;
@property (weak, nonatomic) IBOutlet UIProgressView *cacheprog;
@property (weak, nonatomic) IBOutlet UILabel *cachesizelbl;
@property (weak, nonatomic) IBOutlet UIButton *btn_ApplyFont;
- (IBAction)ChangeChannel:(id)sender;
- (IBAction)ApplyFont:(id)sender;
- (IBAction)CleanCache:(id)sender;
@end
