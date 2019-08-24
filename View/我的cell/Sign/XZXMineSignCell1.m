//
//  XZXMineSignCell1.m
//  BigMarket
//
//  Created by RedSky on 2019/5/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMineSignCell1.h"

@implementation XZXMineSignCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.Sign_backView.cornerRadius = kScreenWidth*0.48/4.0;
    self.Sign_backView2.cornerRadius = kScreenWidth*0.48/2.0*0.9/2.0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapSign)];
    self.Sign_backView2.userInteractionEnabled = YES;
    [self.Sign_backView2 addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)TapSign{
    
    if ([self.delegate respondsToSelector:@selector(DidSelectSign)]) {
      
        [self.delegate DidSelectSign];
    }
}
@end
