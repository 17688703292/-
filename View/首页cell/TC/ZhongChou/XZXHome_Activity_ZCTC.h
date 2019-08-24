//
//  XZXHome_Activity_ZCTC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/12.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXHome_goodModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXHome_Activity_ZCTC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *goodIntroduce_lab;
@property (weak, nonatomic) IBOutlet UILabel *content_lab;
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *Support_lab;
@property (weak, nonatomic) IBOutlet UILabel *supportStatu_lab;
@property (weak, nonatomic) IBOutlet UILabel *SupportRate_lab;
@property (weak, nonatomic) IBOutlet UIProgressView *Support_pro;

@property (nonatomic,strong) XZXHome_goodModel *MyModel;
@end

NS_ASSUME_NONNULL_END
