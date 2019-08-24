//
//  XZXEvalution_ThreeButton_TC.m
//  BigMarket
//
//  Created by RedSky on 2019/4/30.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXEvalution_ThreeButton_TC.h"

@implementation XZXEvalution_ThreeButton_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)good_Action:(id)sender {
    
    XZXEvalution_ThreeButton_TC *cell = (XZXEvalution_ThreeButton_TC *)[[sender superview] superview];
    if ([self.delegate respondsToSelector:@selector(selectEvalutionLevel:cell:)]) {
        [self.delegate selectEvalutionLevel:5 cell:cell];
    }
}
- (IBAction)Medium_Action:(id)sender {
    XZXEvalution_ThreeButton_TC *cell = (XZXEvalution_ThreeButton_TC *)[[sender superview] superview];
    if ([self.delegate respondsToSelector:@selector(selectEvalutionLevel:cell:)]) {
        [self.delegate selectEvalutionLevel:3 cell:cell];
    }
}
- (IBAction)poor_Action:(id)sender {
    XZXEvalution_ThreeButton_TC *cell = (XZXEvalution_ThreeButton_TC *)[[sender superview] superview];
    if ([self.delegate respondsToSelector:@selector(selectEvalutionLevel:cell:)]) {
        [self.delegate selectEvalutionLevel:1 cell:cell];
    }
}
@end
