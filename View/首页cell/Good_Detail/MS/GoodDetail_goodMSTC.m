//
//  GoodDetail_goodMSTC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/16.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "GoodDetail_goodMSTC.h"

@implementation GoodDetail_goodMSTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.title.text = @"限时秒杀";
    self.hourImage.cornerRadius = 15;
    self.mineImage.cornerRadius = 15;
    self.secondImage.cornerRadius = 15;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
