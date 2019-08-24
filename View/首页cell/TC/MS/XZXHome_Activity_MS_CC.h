//
//  XZXHome_Activity_MS_CC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXHome_goodModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXHome_Activity_MS_CC : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *proName;
@property (weak, nonatomic) IBOutlet UILabel *Content;

@property (nonatomic,strong)XZXHome_goodModel *MyModel;
@end

NS_ASSUME_NONNULL_END
