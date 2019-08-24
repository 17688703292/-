//
//  XZXMyAgentGoodListCCCollectionViewCell.m
//  BigMarket
//
//  Created by RedSky on 2019/5/23.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMyAgentGoodListCCCollectionViewCell.h"

@implementation XZXMyAgentGoodListCCCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setMyModel:(XZXMyAgentGoodListModel *)MyModel{
    [self.headImage sd_setImageWithURL:kImageUrl(MyModel.storeId, MyModel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
    self.name.text = MyModel.goodsName;
    self.content.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:MyModel.goodsPrice]],[NSString stringWithFormat:@"  积分：%@",[MyModel.score isKindOfClass:[NSString class]] ? MyModel.score : @"0"]] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"17.0",@"14.0"]];
    
    if (MyModel.goodsPromotionType == 70) {
        
        self.tagStr.text = @"省";
    }else if (MyModel.goodsPromotionType == 80){
       
        self.tagStr.text = @"市";
    }else if (MyModel.goodsPromotionType == 90){
        
        self.tagStr.text = @"县";
    }
    
}

- (IBAction)AddCar:(id)sender {
    
    XZXMyAgentGoodListCCCollectionViewCell *cell = (XZXMyAgentGoodListCCCollectionViewCell *)[[sender superview] superview];
    if ([self.delegate respondsToSelector:@selector(DidselectMoreBtn:)]) {
        [self.delegate DidselectMoreBtn:cell];
    }
}
@end
