//
//  XZXClass_TC.h
//  Slumbers
//
//  Created by RedSky on 2019/3/19.
//  Copyright © 2019 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXClass_leftModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XZXClass_TC : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (nonatomic,strong) XZXClass_leftModel *Model;
@end

NS_ASSUME_NONNULL_END
