
//
//  XZXHome_Activity_ZCTC.m
//  BigMarket
//
//  Created by RedSky on 2019/7/12.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_Activity_ZCTC.h"

@implementation XZXHome_Activity_ZCTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     self.backgroundColor = kBackgroundColor;
    self.BackView.cornerRadius = 5.0;
    self.goodImage.cornerRadius = 5.0;
    //self.content_lab.attributedText = [NSString changestringArray:@[@"洗乐洗衣套装\n",@"洗衣干净清香 默认防皱\n\n",@"¥ 2999 ",@"积分：50"] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor],kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"15.0",@"13.0",@"15.0",@"13.0"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMyModel:(XZXHome_goodModel *)MyModel{
    
 
    self.goodName.text = MyModel.goodsName;
    self.goodIntroduce_lab.text = MyModel.goodsJingle;
    [self.goodImage sd_setImageWithURL:kImageUrl(MyModel.storeId, MyModel.goodsImage)];
    self.content_lab.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",MyModel.goodsPrice]] colorArray:@[kThemeColor] fontArray:@[@"15.0"]];
    self.Support_lab.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%ld",[MyModel.currentOnePeople integerValue] + [MyModel.currentFullPeople integerValue]],@"/",[NSString stringWithFormat:@"%@人",MyModel.fullPaymentPeople]] colorArray:@[kThemeColor,[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"14.0",@"13.0",@"12.0"]];
    self.Support_pro.progress = ([MyModel.currentOnePeople integerValue] + [MyModel.currentFullPeople integerValue])/[MyModel.fullPaymentPeople floatValue];

    self.SupportRate_lab.text = [NSString stringWithFormat:@"%0.1f%%",([MyModel.currentOnePeople integerValue] + [MyModel.currentFullPeople integerValue])/[MyModel.fullPaymentPeople floatValue]*100];
    
    
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
