//
//  XZXPayResultHeadCC.m
//  BigMarket
//
//  Created by RedSky on 2019/6/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXPayResultHeadCC.h"

@implementation XZXPayResultHeadCC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.ViewOrder_Btn.cornerRadius = 15.0f;
    self.ViewOrder_Btn.layer.borderColor = kThemeColor.CGColor;
    self.ViewOrder_Btn.layer.borderWidth = 1.0f;
    
    self.BackBtn.cornerRadius = 15.0f;
}

- (IBAction)ViewOrder_Action:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ViewOrder_delegate)]) {
        
        [self.delegate ViewOrder_delegate];
    }
}

- (IBAction)Back_Action:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(Back_delegate)]) {
        
        [self.delegate Back_delegate];
    }
}
@end
