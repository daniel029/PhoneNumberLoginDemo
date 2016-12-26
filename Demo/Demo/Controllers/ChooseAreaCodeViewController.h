//
//  ChooseAreaCodeViewController.h
//  iRun
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "BaseViewController.h"
#import "AreaCode.h"

@protocol ChooseAreaCodeDelegate <NSObject>

- (void) choosedAreaCode:(AreaCode *)areaCode;

@end

@interface ChooseAreaCodeViewController : BaseViewController

@property(nonatomic, weak) id<ChooseAreaCodeDelegate> delegate;

- (id)initWithCountryString:(NSString *)countryString;

@end
