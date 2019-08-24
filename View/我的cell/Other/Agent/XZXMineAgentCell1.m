//
//  XZXMineAgentCell1.m
//  BigMarket
//
//  Created by RedSky on 2019/5/22.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMineAgentCell1.h"

@implementation XZXMineAgentCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.ViewBtn.cornerRadius = 15.0f;
    self.ViewBtn.layer.borderColor = kThemeColor.CGColor;
    self.ViewBtn.layer.borderWidth = 2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)View_Action:(id)sender {
    if (self.ViewProduceBlock) {
        self.ViewProduceBlock();
    }
}
@end
