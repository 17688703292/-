//
//  XZXClass_good_CC.m
//  BigMarket
//
//  Created by RedSky on 2019/4/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXClass_good_CC.h"

@implementation XZXClass_good_CC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization cod
   // self.good_integral.layer.masksToBounds = true;
    //self.good_integral.layer.cornerRadius  = 3.0f;
//    self.good_integral.layer.borderColor   = kThemeColor.CGColor;
//    self.good_integral.layer.borderWidth   = 1.0;
     self.cornerRadius = 10.0;
     self.tagStr.cornerRadius = 10.0f;
     self.good_integral.cornerRadius = 15.0;
     self.good_integral.layer.borderColor = kThemeColor.CGColor;
     self.good_integral.layer.borderWidth = 1.0;
    
}

-(void)setModel:(XZXClass_two_good_Model *)Model{
        self.saleNumLabel.text = [NSString stringWithFormat:@"销量：%ld",Model.goodsSalenum];
        self.tagStr.hidden = true;
   
    self.saleNumLabel.text = [NSString stringWithFormat:@"销量：%ld",Model.goodsSalenum];
    self.good_price.text     = [NSString stringWithFormat:@"  ¥ %@",[NSString reviseString:Model.goodsPrice]];
    if ([Model.goodsPromotionType integerValue] == MiaoSha_t) {
        self.tagStr.hidden = false;
        self.tagStr.text = @"  秒杀";
        self.saleNumLabel.text = [NSString stringWithFormat:@"销量：%ld",Model.activitySellCount];
        self.good_price.text     = [NSString stringWithFormat:@"  ¥ %@",[NSString reviseString:Model.goodsPromotionPrice]];
    }else if ([Model.goodsPromotionType integerValue] == TuanGou_t){
        self.tagStr.hidden = false;
        self.tagStr.text = @"  团购";
    }
    else if ([Model.goodsPromotionType integerValue] == ZiYing_t || [Model.storeId integerValue] == 1 ||
             Model.isOwnShop == 1){
        self.tagStr.hidden = false;
        self.tagStr.text = @"  自营";
    }
    else if ([Model.goodsPromotionType integerValue] == ZhongChou_t){
        self.tagStr.hidden = false;
        self.tagStr.text = @"  众筹";
    }else if ([Model.goodsPromotionType integerValue] == ReMai_t){
       
        self.tagStr.hidden = false;
        self.tagStr.text = @"  榜单";
    }else if ([Model.goodsPromotionType integerValue] == JiFen_t){
       
        self.tagStr.hidden = false;
        self.tagStr.text = @"  积分";
        
    }

    [self.good_image sd_setImageWithURL:kImageUrl(Model.storeId,Model.goodsImage) placeholderImage:[UIImage imageNamed:@"good"]];
    self.good_Introduce.text = [NSString stringWithFormat:@"  %@",[Model.storeName isKindOfClass:[NSString class]] ? Model.storeName : @""];
    self.good_name.text      = [NSString stringWithFormat:@"  %@",Model.goodsName];
   
    self.good_integral.text  = [NSString stringWithFormat:@"积分： %@",[Model.score isKindOfClass:[NSString class]] ? Model.score : @"0"];
   
}

@end
