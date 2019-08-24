//
//  XZXGOODdetail_AdTC.h
//  BigMarket
//
//  Created by RedSky on 2019/6/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>
#import "AutoScrollLabel.h"

NS_ASSUME_NONNULL_BEGIN
@class XZXGOODdetail_AdTC;

@protocol XZXGOODdetail_AdTCDelegate<NSObject>

-(void)DidSelectAdvertisementIndex:(NSInteger )index;
@end


@interface XZXGOODdetail_AdTC : UITableViewCell<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *AdvertisementView;

@property (nonatomic,strong) NSMutableArray *dataSourceUrl;
@property (nonatomic,strong) NSMutableArray *dataSourceTitle;
@property (nonatomic,strong) NSMutableArray *dataSourceLink;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollview;
@property (nonatomic,weak) id <XZXGOODdetail_AdTCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
