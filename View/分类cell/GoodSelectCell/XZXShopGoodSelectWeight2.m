//
//  XZXShopGoodSelectWeight2.m
//  Slumbers
//
//  Created by RedSky on 2018/12/26.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXShopGoodSelectWeight2.h"

@implementation XZXShopGoodSelectWeight2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.WeightName.layer.masksToBounds   = YES;
    self.WeightName.layer.backgroundColor = kBackgroundColor.CGColor;
    self.WeightName.layer.cornerRadius    = 15.0f;
}

@end
