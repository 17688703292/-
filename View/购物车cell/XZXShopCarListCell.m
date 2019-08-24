//
//  XZXShopCarListCell.m
//  Slumbers
//
//  Created by RedSky on 2018/12/25.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXShopCarListCell.h"

@implementation XZXShopCarListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.HeadImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setGoodModel:(XZXShopCarList_GoodVCModel *)GoodModel{
    
    [self.HeadImage sd_setImageWithURL:kImageUrl(GoodModel.storeId,GoodModel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
    self.GoodsName.text = GoodModel.goodsName;
    self.GoodsPrice.adjustsFontSizeToFitWidth = YES;
    self.GoodsPrice.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:GoodModel.goodsPrice]],[NSString stringWithFormat:@"\n积分：%@",[GoodModel.score isKindOfClass:[NSString class]] ? GoodModel.score :@"0"]] colorArray:@[kThemeColor,[UIColor blackColor]] fontArray:@[@"16.0",@"14.0"]];
    self.GoodsNum.text = [NSString stringWithFormat:@"%ld",GoodModel.goodsNum];
    self.SelectSignalGoodBtn.selected = GoodModel.selectGood == 1? YES : NO;
}

- (IBAction)SelectSignalGood_Action:(id)sender {

    XZXShopCarListCell *cell = (XZXShopCarListCell *)[[sender superview] superview];
    if ([self.delegate respondsToSelector:@selector(SelectSignalGood:)]) {
        [self.delegate SelectSignalGood:cell];
    }
    
}

- (IBAction)ReduceGood_Action:(id)sender {
    
   XZXShopCarListCell *cell = (XZXShopCarListCell *)[[sender superview] superview];
    if ([self.delegate respondsToSelector:@selector(ReduceGood:)]) {
        [self.delegate ReduceGood:cell];
    }
}

- (IBAction)AdGood_Action:(id)sender {
    
   XZXShopCarListCell *cell = (XZXShopCarListCell *)[[sender superview] superview];
    if ([self.delegate respondsToSelector:@selector(AdGood:)]) {
        [self.delegate AdGood:cell];
    }
}
@end
