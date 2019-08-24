//
//  XZXHome_Activity_MS_CC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_Activity_MS_CC.h"

@implementation XZXHome_Activity_MS_CC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImage.cornerRadius = 4.0;
    self.cornerRadius = 10.0;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = kBackgroundColor.CGColor;
}

-(void)setMyModel:(XZXHome_goodModel *)MyModel{
    self.headImage.clipsToBounds = YES;
   
    [self.headImage sd_setImageWithURL:kImageUrl(MyModel.storeId,MyModel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
    self.proName.text = MyModel.goodsName;
    
    self.Content.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:MyModel.goodsPromotionPrice]],[NSString stringWithFormat:@"  积分：%@",[MyModel.score isKindOfClass:[NSString class]] ? MyModel.score:@"0"]] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"13.0",@"11.0"]];

}

@end
