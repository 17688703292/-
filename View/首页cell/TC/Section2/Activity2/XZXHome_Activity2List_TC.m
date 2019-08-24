//
//  XZXHome_Activity2List_TC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_Activity2List_TC.h"

@implementation XZXHome_Activity2List_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.SureBtn.cornerRadius = 2.0f;
    //self.HeadImage.cornerRadius = 120*0.7/2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMyModel:(XZXHome_goodModel *)MyModel{
    
    [self.HeadImage sd_setImageWithURL:kImageUrl(MyModel.storeId,MyModel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
    self.GoodName.text = MyModel.goodsName;
    self.GoodIntroduce.text = MyModel.goodsJingle;
    self.goodContent.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:MyModel.goodsPrice]],[NSString stringWithFormat:@"   积分：%@",[MyModel.score isKindOfClass:[NSString class]] ? MyModel.score : @"0"]] colorArray:@[kThemeColor,[UIColor blackColor]] fontArray:@[@"16.0",@"14.0"]];
    
}

- (IBAction)Sure_Action:(id)sender {
}
@end
