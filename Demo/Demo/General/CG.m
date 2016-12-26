//
//  CG.m
//  iRun
//
//  Created by LiuYingbin on 16/10/17.
//  Copyright © 2016年 LiuYingbin. All rights reserved.
//

#import "CG.h"

void dispatchOnMainQueue(dispatch_block_t block)
{
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

void dispatchOnMainQueueSync(dispatch_block_t block)
{
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

@interface CG ( )
{
  
}

@end

@implementation CG

+ (CG *)s
{
    static dispatch_once_t onceToken;
    static CG *sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[CG alloc] init];
    });
    
    return sSharedInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        CGRect tScreenRect = [[UIScreen mainScreen] bounds];
        _H = MAX(tScreenRect.size.height, tScreenRect.size.width);
        _W = MIN(tScreenRect.size.width, tScreenRect.size.height);
        _scale = [[UIScreen mainScreen] scale];
    }
    
    return self;
}

@end
