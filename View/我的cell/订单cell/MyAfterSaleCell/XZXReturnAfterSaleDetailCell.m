//
//  XZXReturnAfterSaleDetailCell.m
//  BigMarket
//
//  Created by RedSky on 2019/4/28.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXReturnAfterSaleDetailCell.h"

@implementation XZXReturnAfterSaleDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.EditApplication.cornerRadius = self.frame.size.height*0.35;
    self.CancelApplication.cornerRadius = self.frame.size.height*0.35;
    self.EditApplication.layer.borderColor = kThemeColor.CGColor;
    self.EditApplication.layer.borderWidth = 1.0;
    self.CancelApplication.layer.borderColor = kThemeColor.CGColor;
    self.CancelApplication.layer.borderWidth = 1.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)EditApplication_Action:(id)sender {
    XZXReturnAfterSaleDetailCell *cell = (XZXReturnAfterSaleDetailCell *)[[sender superview] superview];
    if ([self.delegate respondsToSelector:@selector(Right_Action:)]) {
        [self.delegate Right_Action:cell];
    }
}
- (IBAction)CancelApplication_Action:(id)sender {
    if ([self.delegate respondsToSelector:@selector(left_Action)]) {
        [self.delegate left_Action];
    }
}
@end
