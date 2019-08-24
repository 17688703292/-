//
//  XZXStoreHeadView.m
//  BigMarket
//
//  Created by RedSky on 2019/5/28.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXStoreHeadView.h"

@implementation XZXStoreHeadView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewMore_Action)];

    [self addGestureRecognizer:tap];
}

-(void)ViewMore_Action{
 
    if (self.ViewMoreBlock) {
        
        self.ViewMoreBlock();
    }
}

@end
