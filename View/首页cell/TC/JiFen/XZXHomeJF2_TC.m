//
//  XZXHomeJF2_TC.m
//  BigMarket
//
//  Created by RedSky on 2019/7/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHomeJF2_TC.h"

@implementation XZXHomeJF2_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_leftView)];
    [self.leftView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap_right = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_rightView)];
    [self.right_view addGestureRecognizer:tap_right];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)tap_leftView{
    
    if ([self.delegate respondsToSelector:@selector(HomeJF2_DidSelectLeft:)]) {
        
        [self.delegate HomeJF2_DidSelectLeft:true];
    }
}

-(void)tap_rightView{
    
    if ([self.delegate respondsToSelector:@selector(HomeJF2_DidSelectLeft:)]) {
        
        [self.delegate HomeJF2_DidSelectLeft:false];
    }
}

@end
