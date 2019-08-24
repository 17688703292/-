//
//  XZXMyOrderDetail_goodCell.m
//  Slumbers
//
//  Created by RedSky on 2019/3/9.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XZXMyOrderDetail_goodCell.h"

@implementation XZXMyOrderDetail_goodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setOrderGoodDetailModel:(XZXMineOrderGoodDetailModel *)OrderGoodDetailModel{
    
    [self.good_image sd_setImageWithURL:kImageUrl(OrderGoodDetailModel.storeId,OrderGoodDetailModel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
    self.good_name.text = OrderGoodDetailModel.goodsName;
    self.good_num.text = [NSString stringWithFormat:@"X %ld",OrderGoodDetailModel.goodsNum];
    self.good_price.attributedText =  [NSString changestringArray:@[[NSString stringWithFormat:@"\n积分：%@\n",OrderGoodDetailModel.goodsScore],[NSString stringWithFormat:@"¥ %@",[NSString reviseString: OrderGoodDetailModel.goodsPrice]]] colorArray:@[kThemeColor,kThemeColor] fontArray:@[@"15.0",@"17.0"]];
    
}
- (IBAction)Operation_Action:(id)sender {
    
    XZXMyOrderDetail_goodCell *cell = (XZXMyOrderDetail_goodCell *)[[sender superview] superview];
    if ([self.delegte respondsToSelector:@selector(didselectCell:)]) {
        [self.delegte didselectCell:cell];
    }
}
@end
