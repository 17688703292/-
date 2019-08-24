//
//  XZXMessageContentTC.m
//  BigMarket
//
//  Created by RedSky on 2019/6/24.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMessageContentTC.h"

@implementation XZXMessageContentTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.BackView.cornerRadius = 10.0;
    self.Content.cornerRadius  = 5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
