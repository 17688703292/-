//
//  XZXMineAgentDateCell.m
//  BigMarket
//
//  Created by RedSky on 2019/5/21.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMineAgentDateCell.h"

@implementation XZXMineAgentDateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.calenderView =[[LXCalendarView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth*0.9 , 0)];
    [self addSubview:self.calenderView];
    self.calenderView.currentMonthTitleColor =[UIColor hexStringToColor:@"2c2c2c"];
    self.calenderView.lastMonthTitleColor =[UIColor hexStringToColor:@"8a8a8a"];
    self.calenderView.nextMonthTitleColor =[UIColor hexStringToColor:@"8a8a8a"];
    
    self.calenderView.isHaveAnimation = YES;
    
    self.calenderView.isCanScroll = YES;
    self.calenderView.isShowLastAndNextBtn = YES;
    
    self.calenderView.todayTitleColor =[UIColor greenColor];
    
    self.calenderView.selectBackColor =[UIColor redColor];
    
    self.calenderView.isShowLastAndNextDate = NO;
    
    [self.calenderView dealData];
    
   // self.calenderView.backgroundColor =[UIColor redColor];
    
    
    self.calenderView.selectBlock = ^(NSInteger year, NSInteger month, NSInteger day) {
        NSLog(@"%ld年 - %ld月 - %ld日",year,month,day);
    };
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
