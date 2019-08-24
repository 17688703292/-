//
//  XZXShopOrderDetail_good2Cell.m
//  DoorLock
//
//  Created by RedSky on 2019/3/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXShopOrderDetail_good2Cell.h"

@implementation XZXShopOrderDetail_good2Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.Input_content.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.InputcontentBlock) {
        
        self.InputcontentBlock(textField.text);
    }
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

@end
