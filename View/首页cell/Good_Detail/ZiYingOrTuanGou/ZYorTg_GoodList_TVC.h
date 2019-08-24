//
//  ZYorTg_GoodList_TVC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXHome_Activity_GoodModel.h"

NS_ASSUME_NONNULL_BEGIN


@class ZYorTg_GoodList_TVC;

@protocol ZYorTg_GoodList_TVCDelegate <NSObject>

-(void)DidSelectSureBtn:(ZYorTg_GoodList_TVC *)cell;

@end


@interface ZYorTg_GoodList_TVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *goodContent;
@property (weak, nonatomic) IBOutlet UIButton *SureBtn;
- (IBAction)sure_Action:(UIButton *)sender;

@property (nonatomic,strong) XZXHome_Activity_GoodModel *MyModel;
@property (nonatomic,weak) id<ZYorTg_GoodList_TVCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
