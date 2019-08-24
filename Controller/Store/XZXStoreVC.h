//
//  XZXStoreVC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/25.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface XZXStoreVC : XHBaseViewController

@property (weak, nonatomic) IBOutlet UITableView *CustomerTableView;
@property (weak, nonatomic) IBOutlet UIView *BackView;
@property (weak, nonatomic) IBOutlet UIView *two_View;
@property (weak, nonatomic) IBOutlet UIImageView *two_Image;
@property (weak, nonatomic) IBOutlet UILabel *two_title;
@property (weak, nonatomic) IBOutlet UIView *four_View;
@property (weak, nonatomic) IBOutlet UIImageView *four_Image;
@property (weak, nonatomic) IBOutlet UILabel *four_title;


@property (nonatomic,copy)NSString *storeId;
@end

NS_ASSUME_NONNULL_END
