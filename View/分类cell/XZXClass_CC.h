//
//  XZXClass_CC.h
//  Slumbers
//
//  Created by RedSky on 2019/3/19.
//  Copyright © 2019 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXClass_rightModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XZXClass_CC : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *GoodImage;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (nonatomic,strong)XZXClass_rightModel *Model;
@end

NS_ASSUME_NONNULL_END
