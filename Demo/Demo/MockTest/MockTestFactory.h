//
//  MockTestFactory.h
//  Demo
//
//  Created by LiuYingbin on 12/25/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestMessage.h"

@interface MockTestFactory : NSObject

+ (NSString *)mockTestResponse:(RequestMessage *)message;

@end
