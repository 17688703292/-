//
//  XZXHome_Activity_ZYorTG_CC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_Activity_ZYorTG_CC.h"

@implementation XZXHome_Activity_ZYorTG_CC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tagStr.cornerRadius = 10.0f;
    
    self.cornerRadius = 10.0;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = kBackgroundColor_yun.CGColor;
    self.clipsToBounds = YES;
}

-(void)setMyModel:(XZXHome_goodModel *)MyModel{
    
   
    switch ([MyModel.goodsPromotionType integerValue]) {
        case TuanGou_t:
            {
               self.tagStr.text = @"  团购";
            }
            break;
        case ZiYing_t:
        {
            self.tagStr.text = @"  自营";
        }
            break;
        default:
            break;
    }
    
    self.goodName.text = MyModel.goodsName;
    self.content.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:MyModel.goodsPrice]],[NSString stringWithFormat:@"\n积分：%@",[MyModel.score isKindOfClass:[NSString class]] ? MyModel.score :@"0"]] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"14.0",@"13.0"]];
   
    
    self.headImage.clipsToBounds = YES;
   
    [self.headImage sd_setImageWithURL:kImageUrl(MyModel.storeId,MyModel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
}
@end
