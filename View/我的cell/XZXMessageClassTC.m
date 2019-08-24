//
//  XZXMessageClassTC.m
//  BigMarket
//
//  Created by RedSky on 2019/6/25.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMessageClassTC.h"

@implementation XZXMessageClassTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.PointImage.cornerRadius = self.frame.size.height*0.7*0.2*0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
