//
//  XZXHome_Activity_ZCCC.m
//  BigMarket
//
//  Created by RedSky on 2019/7/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_Activity_ZCCC.h"

@implementation XZXHome_Activity_ZCCC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     self.cornerRadius = 5.0;
    self.goodImage.cornerRadius = 5.0;
}

-(void)setMyModel:(XZXHome_goodModel *)MyModel{
    
    
    self.goodName_lab.text = MyModel.goodsName;
    [self.goodImage sd_setImageWithURL:kImageUrl(MyModel.storeId, MyModel.goodsImage)];
    self.Content_lab.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@\n",MyModel.goodsPrice]] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"15.0"]];
    self.support_lab.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%ld",[MyModel.currentOnePeople integerValue] + [MyModel.currentFullPeople integerValue]],@"/",[NSString stringWithFormat:@"%@人",MyModel.fullPaymentPeople]] colorArray:@[kThemeColor,[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"14.0",@"13.0",@"12.0"]];
    self.support_pro.progress = ([MyModel.currentOnePeople integerValue] + [MyModel.currentFullPeople integerValue])/[MyModel.fullPaymentPeople floatValue];
    self.supportRate_lab.text = [NSString stringWithFormat:@"%0.1f%%",([MyModel.currentOnePeople integerValue] + [MyModel.currentFullPeople integerValue])/[MyModel.fullPaymentPeople floatValue]*100];
    NSInteger rate_t = ([MyModel.currentOnePeople integerValue] + [MyModel.currentFullPeople integerValue])/[MyModel.fullPaymentPeople integerValue]*100;
    if (rate_t >= 0 && rate_t < 100) {
        
        self.supportStatu_lab.text = @"";
    }else if (rate_t >= 100 && rate_t< 200){
        
        self.supportStatu_lab.text = @" 人气 ";
    }else if (rate_t >=200 && rate_t < 300){
        
        self.supportStatu_lab.text = @" 热 ";
    }else if (rate_t >= 300){
        
        self.supportStatu_lab.text = @" 爆 ";
    }
}

@end
