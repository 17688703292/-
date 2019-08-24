//
//  XZXMine_MyOrderFootView.m
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXMine_MyOrderFootView.h"

@implementation XZXMine_MyOrderFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    [super awakeFromNib];
    self.LeftBtn.layer.masksToBounds = true;
    self.LeftBtn.layer.cornerRadius  = 15.0f;
    self.LeftBtn.layer.borderColor   = kBackgroundColor.CGColor;
    self.LeftBtn.layer.borderWidth   = 1.0;
    
    self.RightBtn.layer.masksToBounds = true;
    self.RightBtn.layer.cornerRadius  = 15.0f;
    self.RightBtn.layer.borderColor   = [UIColor redColor].CGColor;
    self.RightBtn.layer.borderWidth   = 1.0;
}


- (IBAction)LeftBtn_Action:(id)sender {
    
    XZXMine_MyOrderFootView *view = (XZXMine_MyOrderFootView *)[[sender superview]superview];
    if ([self.delegate respondsToSelector:@selector(MyOrder_LeftBtn:)]) {
        [self.delegate MyOrder_LeftBtn:view];
    }
    
}
- (IBAction)RightBtn_Action:(id)sender {
 XZXMine_MyOrderFootView *view = (XZXMine_MyOrderFootView *)[[sender superview]superview];
    if ([self.delegate respondsToSelector:@selector(MyOrder_RightBtn:)]) {
        [self.delegate MyOrder_RightBtn:view];
    }
}
@end
