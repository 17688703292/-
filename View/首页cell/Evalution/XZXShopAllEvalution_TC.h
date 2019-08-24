//
//  XZXShopAllEvalution_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/6.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXShopGoodEvalution_Model.h"

NS_ASSUME_NONNULL_BEGIN

@protocol XZXShopAllEvalutionDelegate <NSObject>

-(void)View_MaxPic:(UITapGestureRecognizer *)tap;

@end

@interface XZXShopAllEvalution_TC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *content_Image;

@property (nonatomic,strong) XZXShopGoodEvalution_Model *MyModel;
@property (nonatomic,weak)id<XZXShopAllEvalutionDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
