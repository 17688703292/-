//
//  XZXHomeJF1_TC.m
//  BigMarket
//
//  Created by RedSky on 2019/7/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHomeJF1_TC.h"

@implementation XZXHomeJF1_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)left_action:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(HomeJF1_DidselectLeft:)]) {
        
        [self.delegate HomeJF1_DidselectLeft:true];
    }
}
- (IBAction)right_action:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(HomeJF1_DidselectLeft:)]) {
        
        [self.delegate HomeJF1_DidselectLeft:false];
    }
}
@end
