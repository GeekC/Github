//
//  XMLSupport.m
//  DailyNews
//
//  Created by 徐 焕 on 14-2-16.
//  Copyright (c) 2014年 徐 焕. All rights reserved.
//

#import "XMLSupport.h"
#import "GDataXMLNode.h"

@implementation XMLSupport
{
    NSFileManager *fileManager;
    NSArray *paths;
    NSString *documentsDirectory;
}
@synthesize title_c,link_c,description,title_i,news_id,link_i,guid,pubDate,titleArray,news_idArray,linkArray,guidArray,pubDateArray;

-(void)initArray
{
    titleArray = [NSMutableArray arrayWithCapacity:1];
    news_idArray = [NSMutableArray arrayWithCapacity:1];
    linkArray = [NSMutableArray arrayWithCapacity:1];
    guidArray = [NSMutableArray arrayWithCapacity:1];
    pubDateArray = [NSMutableArray arrayWithCapacity:1];
}
    
-(void)channelAnalysis:(NSString *)cname
{
    fileManager = [NSFileManager defaultManager];
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",cname]];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:path];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData  options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray *channelarray = [rootElement elementsForName:@"channel"];
    for (GDataXMLElement *channel in channelarray) {
        GDataXMLElement *titlecElement = [[channel elementsForName:@"title"] objectAtIndex:0];
        title_c = [titlecElement stringValue];
        
        GDataXMLElement *linkcElement = [[channel elementsForName:@"link"] objectAtIndex:0];
        link_c = [linkcElement stringValue];

        GDataXMLElement *descriptionElement = [[channel elementsForName:@"description"] objectAtIndex:0];
        description = [descriptionElement stringValue];
    }
}
    
-(void)itemAnalysis:(NSString *)cname
{
    fileManager = [NSFileManager defaultManager];
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",cname]];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:path];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData  options:0 error:nil];
    GDataXMLElement *rootElement = [doc rootElement];
    NSArray *channelarray = [rootElement elementsForName:@"channel"];
        for (GDataXMLElement *channel in channelarray) {
            NSArray *items = [channel elementsForName:@"item"];
            for (GDataXMLElement *item in items) {
                GDataXMLElement *titleiElement = [[item elementsForName:@"title"] objectAtIndex:0];
                title_i = [titleiElement stringValue];
                [titleArray addObject:title_i];
            
                GDataXMLElement *news_idElement = [[item elementsForName:@"news_id"] objectAtIndex:0];
                news_id = [news_idElement stringValue];
                [news_idArray addObject:news_id];
                
                GDataXMLElement *linkiElement = [[item elementsForName:@"link"] objectAtIndex:0];
                link_i = [linkiElement stringValue];
                [linkArray addObject:link_i];
                
                GDataXMLElement *guidElement = [[item elementsForName:@"guid"] objectAtIndex:0];
                guid = [guidElement stringValue];
                [guidArray addObject:guid];
                
                GDataXMLElement *pubDateElement = [[item elementsForName:@"pubDate"] objectAtIndex:0];
                pubDate = [pubDateElement stringValue];
                [pubDateArray addObject:pubDate];
        }
    }
}

    



    
@end
