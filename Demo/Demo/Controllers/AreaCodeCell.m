//
//  AreaCodeCell.m
//  iRun
//
//  Created by LiuYingbin on 12/24/16.
//  Copyright © 2016 LiuYingbin. All rights reserved.
//

#import "AreaCodeCell.h"

@implementation AreaCodeCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Custom initialization
        _areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, 230, 20)];
        _areaLabel.backgroundColor = [UIColor clearColor];
        _areaLabel.opaque = YES;
        _areaLabel.font = [UIFont systemFontOfSize:17];
        _areaLabel.textColor = [UIColor blackColor];
        _areaLabel.textAlignment = NSTextAlignmentLeft;
        _areaLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_areaLabel];
        
        _codeLabel = [[UILabel alloc] initWithFrame:CGRectMake([CG s].W - 50 - 30, 12, 50.0f, 20)];
        _codeLabel.backgroundColor = [UIColor clearColor];
        _codeLabel.opaque = YES;
        _codeLabel.font = [UIFont systemFontOfSize:17];
        _codeLabel.textColor = [UIColor blueColor];
        _codeLabel.textAlignment = NSTextAlignmentRight;
        _codeLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_codeLabel];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAreaCode:(AreaCode *)areaCode
{
    _areaLabel.text = areaCode.area;
    _codeLabel.text = areaCode.code;
}
@end
