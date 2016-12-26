//
//  NSString+Category.m
//  iRun
//
//  Created by LiuYingbin on 16/10/19.
//  Copyright © 2016年 LiuYingbin. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

- (CGSize)compatibleSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    if (lineBreakMode == NSLineBreakByCharWrapping)
    {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary *attributes = @{NSFontAttributeName : font,
                                     NSParagraphStyleAttributeName : paragraphStyle};
        
        CGRect textRect = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil];
        
        if (size.width > 0)
        {
            textRect.size.width = MIN(size.width, textRect.size.width);
        }
        return textRect.size;
    }
    else
    {
        NSDictionary *attributes = @{NSFontAttributeName:font};
        
        CGRect textRect = [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil];
        
        if (size.width > 0)
        {
            textRect.size.width = MIN(size.width, textRect.size.width);
        }
        return textRect.size;
    }
}

+ (NSString *)filterPhone:(NSString *)phone
{
    phone = [phone stringByReplacingOccurrencesOfString:@"+" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"\\t" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    NSString *a0 = [NSString stringWithFormat:@"%c", 0xa0];
    phone = [phone stringByReplacingOccurrencesOfString:a0 withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phone = [phone stringByReplacingOccurrencesOfString:@")" withString:@""];
    return phone;
}

@end
