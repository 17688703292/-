//
//  XZXShopOrderDetail_goodCell.m
//  DoorLock
//
//  Created by RedSky on 2019/3/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXShopOrderDetail_goodCell.h"

@implementation XZXShopOrderDetail_goodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMyModel:(XZXShopGood_UploadOrder_GoodModel *)MyModel{
    
   
 
    [self.headImage sd_setImageWithURL:kImageUrl(MyModel.storeId,MyModel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
    self.label1.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%@\n",MyModel.goodsName],[MyModel.GuiGe_str length] == 0 ?@"":@"", MyModel.goodsPromotionType == 60?@"":[NSString stringWithFormat:@"\n积分：%ld",MyModel.score]] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor],kThemeColor] fontArray:@[@"17.0",@"14.0",@"14.0"]];
    
    NSString  *goodprice = [NSString reviseString:MyModel.goodsPrice];
    if (MyModel.goodsPromotionType == 20 ||
        MyModel.goodsPromotionType == 30 ||
        MyModel.goodsPromotionType == 60) {
        
        goodprice =  [NSString reviseString:MyModel.goodsPromotionPrice];
    }
    self.lable2.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@\n\n",goodprice],[NSString stringWithFormat:@"X %@",[NSString stringWithFormat:@"%@",MyModel.goodsNum]]] colorArray:@[kThemeColor,[UIColor blackColor]] fontArray:@[@"19.0",@"14.0"]];
    
}

@end
