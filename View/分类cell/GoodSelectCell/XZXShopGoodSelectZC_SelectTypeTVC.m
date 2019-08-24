//
//  XZXShopGoodSelectZC_SelectTypeTVC.m
//  BigMarket
//
//  Created by RedSky on 2019/7/25.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXShopGoodSelectZC_SelectTypeTVC.h"

@implementation XZXShopGoodSelectZC_SelectTypeTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.AllPayBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.AllPayBtn setTitleColor:kThemeColor forState:UIControlStateSelected];
    self.AllPayBtn.layer.borderWidth = 1.0;
    self.AllPayBtn.layer.cornerRadius = 2.0;
    
    [self.OnePayBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.OnePayBtn.layer.borderWidth = 1.0;
    [self.OnePayBtn setTitleColor:kThemeColor forState:UIControlStateSelected];
    self.OnePayBtn.layer.cornerRadius = 2.0;
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)AllPay_Action:(id)sender {
    if ([self.delegate respondsToSelector:@selector(DidselectAllPayMoney:)]) {
        [self.delegate DidselectAllPayMoney:YES];
    }
}
- (IBAction)OnePay_Action:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(DidselectAllPayMoney:)]) {
        [self.delegate DidselectAllPayMoney:false];
    }
}
@end
