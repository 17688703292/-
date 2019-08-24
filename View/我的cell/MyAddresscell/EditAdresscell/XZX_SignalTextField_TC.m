//
//  XZX_SignalTextField_CC.m
//  BigMarket
//
//  Created by RedSky on 2019/4/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZX_SignalTextField_TC.h"

@implementation XZX_SignalTextField_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.Input_Message.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIndexRow:(NSInteger)indexRow{
    
    if (indexRow == 0) {
        self.Input_Message.placeholder = @"收货人";
    }else if (indexRow == 1){
        self.Input_Message.placeholder = @"手机号码";
    }else if (indexRow == 3){
        self.Input_Message.placeholder = @"详细地址：如道路、门牌号、小区、楼栋号、单元室";
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([self.delegate respondsToSelector:@selector(Input_Message_SignalTextField_Delegate:TextField:)]) {
        [self.delegate Input_Message_SignalTextField_Delegate:textField.tag TextField:textField.text];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
   
    if ([self.delegate respondsToSelector:@selector(Input_Message_SignalTextField_Delegate:TextField:)]) {
        [self.delegate Input_Message_SignalTextField_Delegate:textField.tag TextField:textField.text];
    }
    return YES;
}


@end
