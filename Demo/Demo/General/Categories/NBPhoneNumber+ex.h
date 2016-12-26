//
//  NBPhoneNumber+ex.h
//  iRun
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "NBPhoneNumber.h"

@interface NBPhoneNumber (ex)

+ (BOOL)isValidNumber:(NSString *)phoneNumber countryCode:(int)countryCode;
+ (BOOL)isValidNumber:(NSString *)phoneNumber countryCodeString:(NSString *)countryCode;

@end
