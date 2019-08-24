//
//  XZXMineOrder2_CC.m
//  Slumbers
//
//  Created by RedSky on 2019/3/19.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XZXMineOrder2_CC.h"

@implementation XZXMineOrder2_CC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImage.clipsToBounds = YES;
    self.num.cornerRadius = 12.5f;
    self.num.layer.borderColor = kThemeColor.CGColor;
    self.num.layer.borderWidth = 1.0;
    self.num.adjustsFontSizeToFitWidth = YES;
    self.num.hidden = true;
}

@end
