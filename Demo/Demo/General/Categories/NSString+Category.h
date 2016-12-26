//
//  NSString+Category.h
//  iRun
//
//  Created by LiuYingbin on 16/10/19.
//  Copyright © 2016年 LiuYingbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

- (CGSize)compatibleSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

//过滤电话号码非法字符
+ (NSString *)filterPhone:(NSString *)phone;

@end
