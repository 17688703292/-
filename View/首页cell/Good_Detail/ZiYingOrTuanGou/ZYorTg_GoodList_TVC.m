//
//  ZYorTg_GoodList_TVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "ZYorTg_GoodList_TVC.h"

@implementation ZYorTg_GoodList_TVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.SureBtn.cornerRadius = 5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMyModel:(XZXHome_Activity_GoodModel *)MyModel{
    
    
    self.goodName.text = MyModel.goodsName;
    
    self.goodContent.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@" ¥ %@",[NSString reviseString:MyModel.goodsPrice]],[NSString stringWithFormat:@"  积分：%@",[MyModel.score isKindOfClass:[NSString class]] ? MyModel.score :@"0"]] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"15.0",@"13.0"]];
    [self.goodImage sd_setImageWithURL:kImageUrl(MyModel.storeId,MyModel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
}

- (IBAction)sure_Action:(UIButton *)sender {
    
    ZYorTg_GoodList_TVC *cell = (ZYorTg_GoodList_TVC *)[[sender superview] superview];
    if ([self.delegate respondsToSelector:@selector(DidSelectSureBtn:)]) {
        [self.delegate DidSelectSureBtn:cell];
    }
}
@end
