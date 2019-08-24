//
//  GoodDetail_goodImage.h
//  BigMarket
//
//  Created by RedSky on 2019/4/10.
//  Copyright © 2019 RedSky. All rights reserved.
//  商品图片

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodDetail_goodImage : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *good_image;
@property (nonatomic,copy) NSString *picString;

@end

NS_ASSUME_NONNULL_END
