//
//  XZX_GoodList_JFTV.h
//  BigMarket
//
//  Created by RedSky on 2019/7/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface XZX_GoodList_JFModel : NSObject

@property (nonatomic,assign)BOOL IsSelectLeft;
//agentAcore + lowerLevelScore = 红积分
@property (nonatomic,copy)   NSString *agentAcore;
@property (nonatomic,copy)   NSString *lowerLevelScore;
@property (nonatomic,copy)   NSString *blueScore;
@property (nonatomic,strong) NSMutableArray *scoreBuy;
@property (nonatomic,strong) NSMutableArray *scoreExchange;

@end


@interface XZX_GoodList_JFTV : XHBaseTableViewController



@end

NS_ASSUME_NONNULL_END
