//
//  XZXShopGoodSelectNum.m
//  Slumbers
//
//  Created by RedSky on 2018/12/26.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXShopGoodSelectNum.h"

@implementation XZXShopGoodSelectNum

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)Add_Action:(id)sender {
 

 if (self.goodsPromotionType != MiaoSha_t) {
            self.GoodNum.text = [NSString stringWithFormat:@"%ld",++self.selectGoodNum];
           }
            if (self.ChangeGoodNum) {
                self.ChangeGoodNum(self.selectGoodNum);
            }
}

- (IBAction)Reduce_Action:(id)sender {
    if (self.selectGoodNum >= 2) {
        
        if (self.goodsPromotionType != MiaoSha_t) {
             self.GoodNum.text = [NSString stringWithFormat:@"%ld",--self.selectGoodNum];
        }
        if (self.ChangeGoodNum) {
            self.ChangeGoodNum(self.selectGoodNum);
        }
    }
}

@end
