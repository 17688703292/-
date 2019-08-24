//
//  XZXMine_MessageDetailTVC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/4.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseTableViewController.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,Detailtype){
    Message_system = 1,
    Message_Order,
    Message_Check
};

@interface XZXMine_MessageDetailModel : NSObject

@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *time;

@end


@interface XZXMine_MessageDetailTVC : XHBaseTableViewController

@property (nonatomic,assign)NSInteger Message_type;
@end

NS_ASSUME_NONNULL_END
