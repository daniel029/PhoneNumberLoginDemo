//
//  AreaCodeCell.h
//  iRun
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaCode.h"

@interface AreaCodeCell : UITableViewCell
{
    UILabel *_areaLabel;
    UILabel *_codeLabel;
}

- (void)setAreaCode:(AreaCode *)areaCode;

@end
