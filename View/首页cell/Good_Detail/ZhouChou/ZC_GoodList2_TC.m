//
//  ZC_GoodList2_TC.m
//  BigMarket
//
//  Created by RedSky on 2019/7/15.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "ZC_GoodList2_TC.h"

@implementation ZC_GoodList2_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.goodImage.cornerRadius = 5.0;
    self.buyBtn.cornerRadius    = 5.0;
    self.buyBtn.layer.borderColor = kBackgroundColor.CGColor;
    self.buyBtn.layer.borderWidth = 1.0;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setMyModel:(XZX_GoodList_ZCModel *)MyModel{
    
 
    [self.goodImage sd_setImageWithURL:kImageUrl(MyModel.storeId, MyModel.goodsImage)];
    self.goodName_lab.text = MyModel.goodsName;
    self.supportPeople_lab.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%ld",[MyModel.currentOnePeople integerValue]+[MyModel.currentFullPeople integerValue]],@"人支持"] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"15.0",@"13.0"]];
    self.price_lab.attributedText = [NSString changestringArray:@[@"¥ ",MyModel.goodsPrice] colorArray:@[kThemeColor,kThemeColor] fontArray:@[@"13.0",@"16.0"]];
    
    self.progress_pro.progress = ([MyModel.currentOnePeople integerValue]+[MyModel.currentFullPeople integerValue])/[MyModel.fullPaymentPeople floatValue];
    self.rate_lab.text = [NSString stringWithFormat:@"%0.0f%%",([MyModel.currentOnePeople integerValue]+[MyModel.currentFullPeople integerValue])/[MyModel.fullPaymentPeople floatValue]*100];
    
    
    if (([MyModel.currentOnePeople integerValue]+[MyModel.currentFullPeople integerValue])/[MyModel.fullPaymentPeople floatValue]*100 >= 100 &&
        ([MyModel.currentOnePeople integerValue]+[MyModel.currentFullPeople integerValue])/[MyModel.fullPaymentPeople floatValue]*100 < 200) {
        
        self.ZC_statu.image = [UIImage imageNamed:@"renqi"];
    }else if (([MyModel.currentOnePeople integerValue]+[MyModel.currentFullPeople integerValue])/[MyModel.fullPaymentPeople floatValue]*100 >= 200 &&
              ([MyModel.currentOnePeople integerValue]+[MyModel.currentFullPeople integerValue])/[MyModel.fullPaymentPeople floatValue]*100 < 300){
        
        self.ZC_statu.image = [UIImage imageNamed:@"remen"];
    }else if (([MyModel.currentOnePeople integerValue]+[MyModel.currentFullPeople integerValue])/[MyModel.fullPaymentPeople floatValue]*100 >= 300){
        
        self.ZC_statu.image = [UIImage imageNamed:@"baopin"];
    }
    
}
@end
