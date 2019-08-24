//
//  XZXHomeJF3_TC.m
//  BigMarket
//
//  Created by RedSky on 2019/7/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHomeJF3_TC.h"

@implementation XZXHomeJF3_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)left_Action:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(DidSelectLeftBtn:)]) {
        
        [self.delegate DidSelectLeftBtn:true];
    }
}
- (IBAction)right_Action:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(DidSelectLeftBtn:)]) {
        
        [self.delegate DidSelectLeftBtn:false];
    }
}
@end
