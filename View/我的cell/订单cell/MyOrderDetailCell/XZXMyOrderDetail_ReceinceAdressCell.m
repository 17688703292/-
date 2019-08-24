//
//  XZXMyOrderDetail_ReceinceAdressCell.m
//  Slumbers
//
//  Created by RedSky on 2019/3/9.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XZXMyOrderDetail_ReceinceAdressCell.h"

@implementation XZXMyOrderDetail_ReceinceAdressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.Title.layer.masksToBounds = YES;
    self.Title.layer.cornerRadius  = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
