//
//  XZX_GoodList_MSTVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZX_GoodList_MSTVC.h"

@implementation XZX_GoodList_MSTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.SureBtn.cornerRadius = 5.0;
    [self.progressStau setTrackTintColor:[UIColor colorWithRed:253/255.0 green:219/255.0 blue:219/255.0 alpha:1]];
    [self.progressStau setTintColor:kThemeColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)Sure_Action:(id)sender {
    
    XZX_GoodList_MSTVC *cell = (XZX_GoodList_MSTVC *)[[sender superview] superview];
 
    if ([self.delegate respondsToSelector:@selector(DidSelectGood:)]) {
        [self.delegate DidSelectGood:cell];
    }
}


-(void)setMyModel:(XZX_Good_MSModel *)MyModel{
    
    [self.HeadInage sd_setImageWithURL:kImageUrl(MyModel.storeId,MyModel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
    self.Name.text = MyModel.goodsName;
    self.content.text = MyModel.goodsJingle;
    self.price.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:MyModel.goodsPromotionPrice]],[NSString stringWithFormat:@"  积分：%@",[MyModel.score isKindOfClass:[NSString class]] ? MyModel.score :@"0"]] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"15.0",@"14.0"]];
    CGFloat progressStau = [MyModel.activitySellCount floatValue]/[MyModel.count floatValue];
    [self.progressStau setProgress:progressStau];
    
    self.progressStauLabel.text = [NSString stringWithFormat:@"%0.1f%%",progressStau*100];
}

@end
