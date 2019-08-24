//
//  XZXShopGoodsDetailImage.m
//  Slumbers
//
//  Created by RedSky on 2018/12/25.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXShopGoodsDetailImage.h"

@implementation XZXShopGoodsDetailImage

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code


}

-(void)setImagemodel:(XZXShopGoodsDetailImageModel *)Imagemodel{
    
    
    NSString *price = [NSString stringWithFormat:@"¥ %@",[NSString reviseString:Imagemodel.price]];

    self.good_price.textColor = kThemeColor;
    self.good_jifeng.textColor = kThemeColor;
    
    self.good_price.text = price;
    self.GoodName.text = Imagemodel.pro_name;
    //self.good_jifeng.text = [NSString stringWithFormat:@"积分:%@",Imagemodel.integral];
    [self.HeadImage sd_setImageWithURL:kImageUrl(Imagemodel.storeId,Imagemodel.image) placeholderImage:[UIImage imageNamed:LoadPic]];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
