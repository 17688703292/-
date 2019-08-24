//
//  XZXEvalution_Field_TC.m
//  BigMarket
//
//  Created by RedSky on 2019/4/30.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXEvalution_Field_TC.h"

@implementation XZXEvalution_Field_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.TextField.placeholder = @"请输入您的描述";
    self.TextField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if (self.GetContent) {
        self.GetContent(textView.text);
    }
}
@end
