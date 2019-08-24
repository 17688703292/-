//
//  XZXShopGoodsDetailImage.h
//  Slumbers
//
//  Created by RedSky on 2018/12/25.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXShopGoodsDetailImageModel.h"
@interface XZXShopGoodsDetailImage : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *HeadImage;
@property (weak, nonatomic) IBOutlet UILabel *GoodName;
@property (weak, nonatomic) IBOutlet UILabel *good_price;
@property (weak, nonatomic) IBOutlet UILabel *good_jifeng;

@property (nonatomic,strong)XZXShopGoodsDetailImageModel *Imagemodel;
@end
