//
//  XZXHome_Activity2List_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXHome_goodModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXHome_Activity2List_TC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *HeadImage;
@property (weak, nonatomic) IBOutlet UILabel *GoodName;
@property (weak, nonatomic) IBOutlet UILabel *GoodIntroduce;
@property (weak, nonatomic) IBOutlet UILabel *goodContent;
@property (weak, nonatomic) IBOutlet UIButton *SureBtn;
- (IBAction)Sure_Action:(id)sender;

@property (nonatomic,strong)XZXHome_goodModel *MyModel;
@end

NS_ASSUME_NONNULL_END
