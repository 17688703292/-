//
//  XZXSignalInputTextFieldTC.m
//  BigMarket
//
//  Created by RedSky on 2019/6/18.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXSignalInputTextFieldTC.h"


@implementation XZXSignalInputTextFieldTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.InputTextField) {
        self.InputTextField(textField.text, (XZXSignalInputTextFieldTC *)[[textField superview]superview]);
    }
}

@end
