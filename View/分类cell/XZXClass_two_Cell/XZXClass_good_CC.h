//
//  XZXClass_good_CC.h
//  BigMarket
//
//  Created by RedSky on 2019/4/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXClass_two_good_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXClass_good_CC : UICollectionViewCell
@property (nonatomic,strong) XZXClass_two_good_Model *Model;
@property (weak, nonatomic) IBOutlet UIImageView *good_image;
@property (weak, nonatomic) IBOutlet UILabel *good_Introduce;
@property (weak, nonatomic) IBOutlet UILabel *good_name;
@property (weak, nonatomic) IBOutlet UILabel *good_price;
@property (weak, nonatomic) IBOutlet UILabel *good_integral;
@property (weak, nonatomic) IBOutlet UILabel *tagStr;
@property (weak, nonatomic) IBOutlet UILabel *saleNumLabel;
@end

NS_ASSUME_NONNULL_END
