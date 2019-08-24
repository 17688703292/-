//
//  XZXMine_ScoreListCell.h
//  BigMarket
//
//  Created by RedSky on 2019/4/25.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXMine_ScoreListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *Score;

@end

NS_ASSUME_NONNULL_END
