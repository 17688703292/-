//
//  XZXMineFriendTC.m
//  BigMarket
//
//  Created by RedSky on 2019/6/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMineFriendTC.h"

@implementation XZXMineFriendTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backImage.cornerRadius = 5.0;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, kScreenWidth*0.8, kScreenWidth*0.8*0.26);  // 设置显示的frame
    gradientLayer.colors =@[(id)[UIColor hexStringToColor:@"fc685b"].CGColor,(id)[UIColor hexStringToColor:@"f74647"].CGColor];   // 设置渐变颜色
    //    gradientLayer.locations = @[@0.0, @0.2, @0.5];    // 颜色的起点位置，递增，并且数量跟颜色数量相等
    gradientLayer.startPoint = CGPointMake(0, 0);   //
    gradientLayer.endPoint = CGPointMake(1, 0);     //
    [self.backImage.layer addSublayer:gradientLayer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
