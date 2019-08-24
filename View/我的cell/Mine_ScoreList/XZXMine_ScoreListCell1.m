//
//  XZXMine_ScoreListCell1.m
//  BigMarket
//
//  Created by RedSky on 2019/6/6.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMine_ScoreListCell1.h"

@implementation XZXMine_ScoreListCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.ScoreBtn.cornerRadius = 15.0;
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)ViewProduce_Action:(id)sender {
    if (self.ViewProduceBlock) {
        self.ViewProduceBlock();
    }
}

- (IBAction)BuyProduct_Action:(id)sender {
    if (self.BuyProductBlock) {
        self.BuyProductBlock();
    }
}
@end
