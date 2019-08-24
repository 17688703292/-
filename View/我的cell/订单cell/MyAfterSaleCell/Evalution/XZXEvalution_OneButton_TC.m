//
//  XZXEvalution_OneButton_TC.m
//  BigMarket
//
//  Created by RedSky on 2019/4/30.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXEvalution_OneButton_TC.h"

@implementation XZXEvalution_OneButton_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)Sure_Action:(id)sender {
    
    XZXEvalution_OneButton_TC *cell = (XZXEvalution_OneButton_TC *)[[sender superview] superview];
    if ([self.delegate respondsToSelector:@selector(Sure_Action:)]) {
        
         [self.delegate Sure_Action:cell];
    }
}
@end
