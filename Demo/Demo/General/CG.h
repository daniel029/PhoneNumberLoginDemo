//
//  CG.h
//  iRun
//
//  Created by LiuYingbin on 16/10/17.
//  Copyright © 2016年 LiuYingbin. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif
    
    void dispatchOnMainQueue(dispatch_block_t block);
    void dispatchOnMainQueueSync(dispatch_block_t block);

    
#ifdef __cplusplus
}
#endif

@interface CG : NSObject

@property (nonatomic, assign, readonly) CGFloat   H;
@property (nonatomic, assign, readonly) CGFloat   W;
@property (nonatomic, assign, readonly) CGFloat scale;

+ (CG *)s;

@end
