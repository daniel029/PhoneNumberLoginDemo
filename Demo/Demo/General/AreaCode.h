//
//  AreaCode.h
//  iRun
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaCode : NSObject

@property (nonatomic, readonly, strong) NSString *area;
@property (nonatomic, readonly, strong) NSString *code;

- (id)initWithString:(NSString *)str;
- (id)initWithArea:(NSString *)area code:(NSString *)code;
- (NSComparisonResult) letterAscendSort:(AreaCode *)another;

@end
