//
//  XZXMine_ZCTC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/26.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXMine_ZCTC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *ZC_statu;
@property (weak, nonatomic) IBOutlet UILabel *goodName_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodContent_lab;
@property (weak, nonatomic) IBOutlet UILabel *support_lab;
@property (weak, nonatomic) IBOutlet UILabel *rate_lab;
@property (weak, nonatomic) IBOutlet UILabel *Money_lab;
@property (weak, nonatomic) IBOutlet UILabel *lastday_lab;
@property (weak, nonatomic) IBOutlet UIProgressView *progress_pro;

@end

NS_ASSUME_NONNULL_END
