//
//  XZXMine_MessageListTVC.h
//  BigMarket
//
//  Created by RedSky on 2019/4/26.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXMine_MessageListModel : NSObject

@property (nonatomic,assign)NSInteger flag;//0、未读 1、已读
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *systemContent;
@property (nonatomic,copy)NSString *systemTime;//系统时间
@property (nonatomic,copy)NSString *Time;//时间
@end


@interface XZXMine_MessageListTVC : XHBaseTableViewController

@end

NS_ASSUME_NONNULL_END
