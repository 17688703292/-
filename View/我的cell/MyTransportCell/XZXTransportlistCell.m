//
//  XZXTransportlistCell.m
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXTransportlistCell.h"

@implementation XZXTransportlistCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.Image.cornerRadius = 10.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
