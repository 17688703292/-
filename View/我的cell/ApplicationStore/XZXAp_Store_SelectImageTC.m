//
//  XZXAp_Store_SelectImageTC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/8.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXAp_Store_SelectImageTC.h"

@implementation XZXAp_Store_SelectImageTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seletImage:)];
    [self.SelectImage addGestureRecognizer:tap];
    self.SelectImage.userInteractionEnabled = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMyModel:(XZXAp_Store_ImageModel *)MyModel{
   
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:MyModel.title];
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:kThemeColor range:[MyModel.title rangeOfString:@"*"]];
    self.title.attributedText = attrStr;
    if ([MyModel.image isKindOfClass:[UIImage class]]) {
        self.SelectImage.image = MyModel.image;
    }else{
        self.SelectImage.image = [UIImage imageNamed:@"tianjiatupian"];
    }
}

-(void)seletImage:(UITapGestureRecognizer *)tap{

    CGPoint point = [tap locationInView:(UITableView *)[self superview]];
    if ([self.SelectImageTCDelegate respondsToSelector:@selector(DidselectImage:)]) {
        [self.SelectImageTCDelegate DidselectImage:point];
    }
    
}
@end
