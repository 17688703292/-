//
//  XZXHome_Activity_ZYorTG2_CC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_Activity_ZYorTG2_CC.h"

@implementation XZXHome_Activity_ZYorTG2_CC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImage.clipsToBounds = YES;
    self.cornerRadius = 10.0;
}


-(void)setMyModel:(XZXHome_goodModel *)MyModel{
    
    self.goodName.text = MyModel.goodsName;
    self.content.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:MyModel.goodsPrice]],[NSString stringWithFormat:@"\n积分：%@",[MyModel.score isKindOfClass:[NSString class]] ? MyModel.score :@"0"]] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"14.0",@"13.0"]];
    self.headImage.clipsToBounds = YES;
    [self.headImage sd_setImageWithURL:kImageUrl(MyModel.storeId,MyModel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
}
@end
