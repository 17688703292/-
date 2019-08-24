//
//  ZC_GoodList_TC.m
//  BigMarket
//
//  Created by RedSky on 2019/7/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "ZC_GoodList_TC.h"

@implementation ZC_GoodList_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.BackView.cornerRadius = 5.0;
    self.goodImage.cornerRadius = 5.0;
     UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
     UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    
     effectview.frame = CGRectMake(0, 0, kScreenWidth, self.frame.size.height);
    [self.GoodImage_SuperBig addSubview:effectview];
    self.GoodImage_Big.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setMyModel:(XZX_GoodList_ZCModel *)MyModel{
    
    NSString *goodImage_Big_Str = MyModel.goodsImagesList.count > 0 ? [[MyModel.goodsImagesList objectAtIndex:0] valueForKey:@"goodsImage"] :MyModel.goodsImage;
    [self.GoodImage_SuperBig sd_setImageWithURL:kImageUrl(MyModel.storeId, goodImage_Big_Str)];
    [self.GoodImage_Big sd_setImageWithURL:kImageUrl(MyModel.storeId, goodImage_Big_Str)];
    [self.goodImage sd_setImageWithURL:kImageUrl(MyModel.storeId, MyModel.goodsImage)];
    self.goodName_lab.text = MyModel.goodsName;
    self.support_lab.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%ld",[MyModel.currentOnePeople integerValue]+[MyModel.currentFullPeople integerValue]],@"人支持"] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"15.0",@"13.0"]];
    self.goodprice_lab.attributedText = [NSString changestringArray:@[@"¥ ",MyModel.goodsPrice] colorArray:@[kThemeColor,kThemeColor] fontArray:@[@"13.0",@"16.0"]];
    
    self.progress_pro.progress = ([MyModel.currentOnePeople integerValue]+[MyModel.currentFullPeople integerValue])/[MyModel.fullPaymentPeople floatValue];
    self.progress_lab.text = [NSString stringWithFormat:@"%0.0f%%",([MyModel.currentOnePeople integerValue]+[MyModel.currentFullPeople integerValue])/[MyModel.fullPaymentPeople floatValue]*100];
    
}
@end
