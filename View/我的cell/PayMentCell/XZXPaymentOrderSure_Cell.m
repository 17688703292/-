//
//  XZXPaymentOrderSure_Cell.m
//  Slumbers
//
//  Created by RedSky on 2019/2/22.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XZXPaymentOrderSure_Cell.h"

@implementation XZXPaymentOrderSure_Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.SureBtn.layer.masksToBounds = YES;
    self.SureBtn.layer.cornerRadius  = 15.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)Sure_Action:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(PayMoney)]) {
        
        [self.delegate PayMoney];
    }
    
}
@end
