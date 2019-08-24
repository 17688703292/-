//
//  XZXMine_MyOrderCell.m
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXMine_MyOrderCell.h"

@implementation XZXMine_MyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.goodImage.clipsToBounds = YES;
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)LoadDataRefreshUI:(XZXMineOrderModel *)model GoodDetailModel:(XZXMineOrderGoodDetailModel *)OrderGoodDetailModel{
    
    [self.goodImage sd_setImageWithURL:kImageUrl(OrderGoodDetailModel.storeId,OrderGoodDetailModel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
    self.goodname.text = OrderGoodDetailModel.goodsName;
    
    NSMutableArray *arry_str = [NSMutableArray array];
    
    NSMutableArray *array_color = [NSMutableArray array];
    NSMutableArray *array_font = [NSMutableArray array];
    
    for (NSString *str in arry_str) {
        [array_color addObject:[UIColor lightGrayColor]];
        [array_font addObject:@"17.0"];
    }
    
    
    
    [arry_str addObject:[NSString stringWithFormat:@"¥  %@",[NSString reviseString:OrderGoodDetailModel.goodsPrice]]];
    [array_color addObject:kThemeColor];
    [array_font addObject:@"20.0"];
    
    [arry_str addObject:[NSString stringWithFormat:@"   积分：%@ ",[OrderGoodDetailModel.goodsScore isKindOfClass:[NSString class]]?OrderGoodDetailModel.goodsScore:@"0"]];
    [array_color addObject:[UIColor darkGrayColor]];
    [array_font addObject:@"14.0"];
    /**
     积分商品。不需要展示积分
     **/
    
    if ([OrderGoodDetailModel.crowdType isKindOfClass:[NSString class]]) {
        if ([OrderGoodDetailModel.crowdType integerValue] == 3 ||
            [OrderGoodDetailModel.crowdType integerValue] == 4) {
      
            [arry_str insertObject:@" + " atIndex:1];
            [array_color insertObject:kThemeColor atIndex:1];
            [array_font insertObject:@"16.0" atIndex:1];
        
            if (arry_str.count > 2) {
             
                 [arry_str exchangeObjectAtIndex:0 withObjectAtIndex:2];
            }
        }
    }
    self.good_content.attributedText = [NSString changestringArray:arry_str colorArray:array_color fontArray:array_font];
    self.good_num.text = [NSString stringWithFormat:@"X %ld",OrderGoodDetailModel.goodsNum];
}

@end
