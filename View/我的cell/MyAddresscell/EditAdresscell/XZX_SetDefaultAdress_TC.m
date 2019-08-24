//
//  XZX_SetDefaultAdress_TC.m
//  BigMarket
//
//  Created by RedSky on 2019/4/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZX_SetDefaultAdress_TC.h"

@implementation XZX_SetDefaultAdress_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.DefaultAddress_IsOn.userInteractionEnabled = false;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)switch_Action:(id)sender {
    
    UISwitch *IsDefault_switch = sender;
    if ([self.delegate respondsToSelector:@selector(SwitchAction_XZX_SetDefaultAdress_TC:)]) {
        [self.delegate SwitchAction_XZX_SetDefaultAdress_TC:IsDefault_switch.on];
    }
}
@end
