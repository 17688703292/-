//
//  XZXHomepageTVC1.h
//  BigMarket
//
//  Created by RedSky on 2019/6/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXHomeHeadViewClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXHomepageTVC : XHBaseViewController

@property (weak, nonatomic) IBOutlet UIView *classView;
@property (weak, nonatomic) IBOutlet UITableView *CustomerTableViewCell;

@property (nonatomic,strong) XZXHomeHeadViewClass *classView_Main;
@end

NS_ASSUME_NONNULL_END
