//
//  XZXMineSign_dayModel.h
//  BigMarket
//
//  Created by RedSky on 2019/5/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXMineSign_dayModel : NSObject

@property (nonatomic,copy)NSString *score;
@property (nonatomic,copy)NSString *dayTime;
@property (nonatomic,assign)NSInteger isSign;
@end

@interface XZXMineSignTVC : XHBaseTableViewController

@end

NS_ASSUME_NONNULL_END
