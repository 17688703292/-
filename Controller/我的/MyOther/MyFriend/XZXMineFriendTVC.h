//
//  XZXMineFriendTVC.h
//  BigMarket
//
//  Created by RedSky on 2019/4/29.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXMineFriendModel : NSObject

@property(nonatomic,copy)NSString *memberName;
@property(nonatomic,copy)NSString *memberAvatar;
@property(nonatomic,copy)NSString *invitedTime;
@property(nonatomic,copy)NSString *memberMobile;

@end

@interface XZXMineFriendTVC : XHBaseTableViewController

@end

NS_ASSUME_NONNULL_END
