//
//  GoodDetail_goodMSTC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/16.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodDetail_goodMSTC : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *hourImage;
@property (weak, nonatomic) IBOutlet UILabel *hourTitle;
@property (weak, nonatomic) IBOutlet UIImageView *mineImage;
@property (weak, nonatomic) IBOutlet UILabel *mineTitle;

@property (weak, nonatomic) IBOutlet UIImageView *secondImage;
@property (weak, nonatomic) IBOutlet UILabel *secondTitle;
@end

NS_ASSUME_NONNULL_END
