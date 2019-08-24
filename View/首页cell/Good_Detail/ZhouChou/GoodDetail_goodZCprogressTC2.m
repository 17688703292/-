//
//  GoodDetail_goodZCprogressTC2.m
//  BigMarket
//
//  Created by RedSky on 2019/7/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "GoodDetail_goodZCprogressTC2.h"

@implementation GoodDetail_goodZCprogressTC2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMyModel:(XZX_GoodDetail_CommonModel *)MyModel{
 
    
    self.JoinPeople_lab.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%ld",[MyModel.currentFullPeople integerValue] + [MyModel.currentOnePeople integerValue]],@"次"] colorArray:@[[UIColor blackColor],[UIColor blackColor]] fontArray:@[@"15.0",@"11.0"]];
    self.AllpayPeople_lab.attributedText = [NSString changestringArray:@[MyModel.currentFullPeople,@"人"] colorArray:@[[UIColor blackColor],[UIColor blackColor]] fontArray:@[@"15.0",@"11.0"]];
    self.AllMoney_lab.attributedText = [NSString changestringArray:@[MyModel.crowdTotalMoney,@"元"] colorArray:@[[UIColor blackColor],[UIColor blackColor]] fontArray:@[@"15.0",@"11.0"]];
    
    
    if (MyModel.activityEndDate == 0) {
        
        self.LastDay_lab.attributedText = [NSString changestringArray:@[@"0",@"天"] colorArray:@[[UIColor blackColor],[UIColor blackColor]] fontArray:@[@"15.0",@"11.0"]];
    }else{
        
        
        BOOL result = [[XHTools getNowTimeTimestamp_HaoMiao] compare:MyModel.activityEndDate]==NSOrderedAscending;
        
        if (result == 1) {
            
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comp_day = [calendar components:NSCalendarUnitDay
                                                 fromDate:[XHTools ConvertStrToTimeDate:[XHTools getNowTimeTimestamp_HaoMiao]]
                                                   toDate:[XHTools ConvertStrToTimeDate:MyModel.activityEndDate]
                                                  options:NSCalendarWrapComponents];
            if (comp_day.day != 0) {
                //天
                 self.LastDay_lab.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%ld",comp_day.day],@"天"] colorArray:@[[UIColor blackColor],[UIColor blackColor]] fontArray:@[@"15.0",@"11.0"]];
                
            }else{
                
                //时
                NSDateComponents *comp_hour = [calendar components:NSCalendarUnitHour
                                                          fromDate:[XHTools ConvertStrToTimeDate:[XHTools getNowTimeTimestamp_HaoMiao]]
                                                            toDate:[XHTools ConvertStrToTimeDate:MyModel.activityEndDate]
                                                           options:NSCalendarWrapComponents];
                //分
                NSDateComponents *comp_minute = [calendar components:NSCalendarUnitMinute
                                                            fromDate:[XHTools ConvertStrToTimeDate:[XHTools getNowTimeTimestamp_HaoMiao]]
                                                              toDate:[XHTools ConvertStrToTimeDate:MyModel.activityEndDate]
                                                             options:NSCalendarWrapComponents];
                if (comp_hour.hour != 0) {
                    
                    self.LastDay_lab.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%ld",comp_hour.hour],@"时",[NSString stringWithFormat:@"%ld",comp_minute.minute%60],@"分"] colorArray:@[[UIColor blackColor],[UIColor blackColor],[UIColor blackColor],[UIColor blackColor]] fontArray:@[@"15.0",@"11.0",@"15.0",@"11.0"]];
                }else{
                    

                    if (comp_minute.minute != 0) {
                        
                           self.LastDay_lab.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%ld",comp_minute.minute],@"分"] colorArray:@[[UIColor blackColor],[UIColor blackColor]] fontArray:@[@"15.0",@"11.0"]];
                    }else{
                        //秒
                        NSDateComponents *comp_second = [calendar components:NSCalendarUnitSecond
                                                                    fromDate:[XHTools ConvertStrToTimeDate:[XHTools getNowTimeTimestamp_HaoMiao]]
                                                                      toDate:[XHTools ConvertStrToTimeDate:MyModel.activityEndDate]
                                                                     options:NSCalendarWrapComponents];
                        if (comp_second.second != 0) {
                            
                            self.LastDay_lab.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%ld",comp_second.second],@"秒"] colorArray:@[[UIColor blackColor],[UIColor blackColor]] fontArray:@[@"15.0",@"11.0"]];
                        }else{
                            
                             self.LastDay_lab.attributedText = [NSString changestringArray:@[@"已结束",@""] colorArray:@[[UIColor blackColor],[UIColor blackColor]] fontArray:@[@"15.0",@"11.0"]];
                        }
                    }
                }
            }
        }else{
            
             self.LastDay_lab.attributedText = [NSString changestringArray:@[@"已结束",@""] colorArray:@[[UIColor blackColor],[UIColor blackColor]] fontArray:@[@"15.0",@"11.0"]];
        }
    }
}

@end
