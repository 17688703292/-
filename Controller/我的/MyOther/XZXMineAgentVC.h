//
//  XZXMineAgentVC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/21.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXCalendarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXMineAgentModel : NSObject

@property (nonatomic,strong) NSDictionary *province;
@property (nonatomic,strong) NSDictionary *city;
@property (nonatomic,strong) NSDictionary *area;

@property (nonatomic,copy) NSString *up;//收入
@property (nonatomic,copy) NSString *down;//支出
@property (nonatomic,copy) NSString *date;//当前月份
@property (nonatomic,strong) NSMutableArray *list;//当前月份下的积分列表
@property (nonatomic,copy) NSString *currentMoney;//当月分红
@property (nonatomic,copy) NSString *agentAcore;//代理积分剩余
@property (nonatomic,copy) NSString *agentAcoreTotal;//代理积分所有
@property (nonatomic,copy) NSString *lowerLevelScore;//推广
@property (nonatomic,copy) NSString *lowerLevelScoreTotal;//推广



@end

@interface XZXMineAgentVC : XHBaseViewController

@property (weak, nonatomic) IBOutlet UITableView *CustomerTableView;

@end

NS_ASSUME_NONNULL_END
