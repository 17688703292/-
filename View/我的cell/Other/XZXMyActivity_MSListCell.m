//
//  XZXMyActivity_MSListCell.m
//  BigMarket
//
//  Created by RedSky on 2019/5/22.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMyActivity_MSListCell.h"

@implementation XZXMyActivity_MSListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.hour.cornerRadius = 12.5;
    self.mine.cornerRadius = 12.5;
    self.second.cornerRadius = 12.5;
    self.endLabel.cornerRadius =  12.5;
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
