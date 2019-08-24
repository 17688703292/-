//
//  XZXAp_Store_SelectImageTC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/8.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXAp_Store_ImageModel.h"
NS_ASSUME_NONNULL_BEGIN


@protocol XZXAp_Store_SelectImageTCDelegate <NSObject>

-(void)DidselectImage:(CGPoint )Point;

@end

@interface XZXAp_Store_SelectImageTC : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *SelectImage;

@property (nonatomic,strong)XZXAp_Store_ImageModel *MyModel;
@property (nonatomic,weak)id <XZXAp_Store_SelectImageTCDelegate>SelectImageTCDelegate;
@end

NS_ASSUME_NONNULL_END
