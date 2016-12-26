//
//  ISOAreaCode.h
//  iRun
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AreaCode.h"

@interface ISOAreaCode : NSObject
{
    NSArray *_searchIndex;   //首字母的索引数组
    NSMutableDictionary *_dicAreaCodeToIndex;  //areacode对应于indexPath的map
}

@property (nonatomic, readonly, retain) NSMutableArray *arrAreaCodes;

+ (ISOAreaCode *)instance;

- (NSMutableArray *)ISOAreaCodeArray;
- (NSArray *)searchIndex;
- (NSIndexPath *)indexPathByArea:(NSString *)area;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)titleForHeaderInSection:(NSInteger)section;
- (AreaCode *)areaCodeAtSection:(NSInteger)section Row:(NSInteger)row;
- (AreaCode *)localAreaCode;
- (NSString *)countryCode:(NSString*)areaCode;
- (NSString *)areaCode:(NSString *)countryCode;
- (BOOL)isValidCountryCode:(NSString *)countryCode;

@end
