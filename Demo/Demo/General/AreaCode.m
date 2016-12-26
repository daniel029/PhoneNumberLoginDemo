//
//  AreaCode.m
//  iRun
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "AreaCode.h"

@implementation AreaCode

- (id)initWithString:(NSString *)str
{
    self = [super init];
    if (self)
    {
        NSArray *array = [str componentsSeparatedByString:@","];
        if ([array count] > 1)
        {
            _area = [array objectAtIndex:0];
            _code = [[NSString alloc ]initWithFormat:@"+%@", [array objectAtIndex:1]];
        }
        
    }
    return self;
}

- (id)initWithArea:(NSString *)area code:(NSString *)code
{
    self = [super init];
    if (self)
    {
        _area = area;
        _code = code;
    }
    
    return self;
}

- (NSComparisonResult) letterAscendSort:(AreaCode *)another
{
    return [_area compare: another.area
                 options: NSCaseInsensitiveSearch
            | NSNumericSearch];
    
}


@end
