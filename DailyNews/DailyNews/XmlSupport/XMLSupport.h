//
//  XMLSupport.h
//  DailyNews
//
//  Created by 徐 焕 on 14-2-16.
//  Copyright (c) 2014年 徐 焕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLSupport : NSObject
{
    NSString *title_c,*link_c,*description,*title_i,*news_id,*link_i,*guid,*pubDate;
    NSMutableArray *titleArray,*news_idArray,*linkArray,*guidArray,*pubDateArray;
}
    @property (strong,nonatomic) NSString *title_c,*link_c,*description,*title_i,*news_id,*link_i,*guid,*pubDate;
    @property (strong,nonatomic) NSMutableArray *titleArray,*news_idArray,*linkArray,*guidArray,*pubDateArray;
    
    -(void)initArray;
    -(void)channelAnalysis:(NSString *)cname;
    -(void)itemAnalysis:(NSString *)cname;
    
@end
