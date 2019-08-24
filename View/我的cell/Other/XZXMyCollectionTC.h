//
//  XZXMyCollectionTC.h
//  BigMarket
//
//  Created by RedSky on 2019/4/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXMyCollectionTC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *Time;
@property (weak, nonatomic) IBOutlet UILabel *goodContent;

@end

NS_ASSUME_NONNULL_END
