//
//  XZXHome_Activity_ZCCC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXHome_goodModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXHome_Activity_ZCCC : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *goodName_lab;
@property (weak, nonatomic) IBOutlet UILabel *Content_lab;
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *support_lab;
@property (weak, nonatomic) IBOutlet UILabel *supportStatu_lab;
@property (weak, nonatomic) IBOutlet UILabel *supportRate_lab;
@property (weak, nonatomic) IBOutlet UIProgressView *support_pro;

@property (nonatomic,strong) XZXHome_goodModel *MyModel;
@end

NS_ASSUME_NONNULL_END
