//
//  XZXHom_AdvertisementCell.h
//  Slumbers
//
//  Created by RedSky on 2018/12/19.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>
#import "AutoScrollLabel.h"

@class XZXHom_AdvertisementCell;
@protocol XZXHom_AdvertisementCellDelegate<NSObject>

-(void)DidSelectAdvertisementIndex:(NSInteger )index;
@end

@interface XZXHom_AdvertisementCell : UITableViewCell<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *labaImage;
@property (weak, nonatomic) IBOutlet UIView *AdvertisementView;

@property (weak, nonatomic) IBOutlet AutoScrollLabel *Adver_word;

@property (nonatomic,strong) NSMutableArray *dataSourceUrl;
@property (nonatomic,strong) NSMutableArray *dataSourceTitle;
@property (nonatomic,strong) NSMutableArray *dataSourceLink;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollview;
@property (nonatomic,weak) id <XZXHom_AdvertisementCellDelegate>delegate;

@property (nonatomic,assign)CGFloat Adv_height;
@end
