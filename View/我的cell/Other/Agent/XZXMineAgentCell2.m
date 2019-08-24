//
//  XZXMineAgentCell2.m
//  BigMarket
//
//  Created by RedSky on 2019/5/22.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMineAgentCell2.h"

@implementation XZXMineAgentCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.select.userInteractionEnabled = false;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
