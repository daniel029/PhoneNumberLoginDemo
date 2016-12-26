//
//  FetchAuthCodeResponseMessage.h
//  Demo
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "ResponseMessage.h"

@interface FetchAuthCodeResponseMessage : ResponseMessage
@property(nonatomic, assign) int authCodeCount;
@property(nonatomic, assign) int countDown;
@property(nonatomic, strong) NSString *mockAuthCode;

@end
