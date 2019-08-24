//
//  XZXAp_Store_InputTC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/8.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXAp_Store_InputTC.h"

@implementation XZXAp_Store_InputTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.InputText.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMyModel:(XZXAp_Store_TextModel *)MyModel{
    
    [self.InputText creatLeftTitle:MyModel.title];
    self.InputText.placeholder = [MyModel.content length] == 0 ? MyModel.placehold: MyModel.content;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    XZXAp_Store_InputTC *cell = (XZXAp_Store_InputTC *)[[textField superview] superview];
    
    if ([self.InputTCDelegate respondsToSelector:@selector(InputContent:Cell:)]) {
    
        [self.InputTCDelegate InputContent:textField.text Cell:cell];
    }
    return YES;
}
@end
