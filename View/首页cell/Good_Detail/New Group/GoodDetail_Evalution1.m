//
//  GoodDetail_Evalution1.m
//  BigMarket
//
//  Created by RedSky on 2019/4/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "GoodDetail_Evalution1.h"

@implementation GoodDetail_Evalution1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.goodRate.cornerRadius = 2.0;
    self.Bad.cornerRadius = 2.0;
    self.Average.cornerRadius = 2.0;
    self.good.cornerRadius = 2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setMyModel:(XZXShopGoodEvalution_ListModel *)MyModel{
    
    self.goodRate.adjustsFontSizeToFitWidth = YES;
    self.goodRate.text= [NSString stringWithFormat:@"好评率 \n%0.1f%%",[MyModel.countAll floatValue] == 0 ? 100.0:[MyModel.score5 floatValue]/[MyModel.countAll floatValue]*100];
    self.Bad.text = [NSString stringWithFormat:@"差评 \n（%@）",MyModel.score1];
    self.Average.text = [NSString stringWithFormat:@"中评 \n（%@）",MyModel.score3];
    self.good.text =  [NSString stringWithFormat:@"好评 \n（%@）",MyModel.score5];
}

@end
