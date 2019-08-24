//
//  XZXStoreHeadView.h
//  BigMarket
//
//  Created by RedSky on 2019/5/28.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZXStoreHeadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *ViewMoreBtn;

@property (nonatomic,copy)void (^ViewMoreBlock)(void);

@end

NS_ASSUME_NONNULL_END
