//
//  XZXShopCarListheadCell.m
//  BigMarket
//
//  Created by RedSky on 2019/4/23.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXShopCarListheadCell.h"

@implementation XZXShopCarListheadCell


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DidSelectStore_tap:)];
    
    [self addGestureRecognizer:tap];
}


- (IBAction)Select_Action:(UIButton *)sender {
    
   
    if ([self.delegate respondsToSelector:@selector(DidSelectStor:)]) {
        [self.delegate DidSelectStor:sender.tag];
    }
}

-(void)DidSelectStore_tap:(UITapGestureRecognizer *)ges{
    
    if ([self.delegate respondsToSelector:@selector(EnterStore:)]) {
        [self.delegate EnterStore:ges];
    }
}
@end
