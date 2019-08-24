//
//  XZXHome_ProduceListTC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/11.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>
#import "AutoScrollLabel.h"

NS_ASSUME_NONNULL_BEGIN



@class XZXHome_ProduceListTC;
@protocol XZXHome_ProduceListTCDelegate<NSObject>

-(void)DidSelectAdvertisementIndex:(NSInteger )index;
@end

@interface XZXHome_ProduceListTC : UITableViewCell<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *AdvertisementView;
@property (nonatomic,strong) NSMutableArray *dataSourceUrl;
@property (nonatomic,strong) NSMutableArray *dataSourceTitle;
@property (nonatomic,strong) NSMutableArray *dataSourceLink;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollview;
@property (nonatomic,weak) id <XZXHome_ProduceListTCDelegate>delegate;

@property (nonatomic,assign)CGFloat Adv_height;

@end

NS_ASSUME_NONNULL_END
