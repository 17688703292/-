//
//  XZXHome_ProduceListTC.m
//  BigMarket
//
//  Created by RedSky on 2019/7/11.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXHome_ProduceListTC.h"

@implementation XZXHome_ProduceListTC

-(NSArray *)dataSourceUrl{
    if (!_dataSourceUrl) {
        _dataSourceUrl = [NSMutableArray array];
    }
    return _dataSourceUrl;
}
-(NSArray *)dataSourceLink{
    if (!_dataSourceLink) {
        _dataSourceLink = [NSMutableArray array];
    }
    return _dataSourceLink;
}
-(NSArray *)dataSourceTitle{
    if (!_dataSourceTitle) {
        _dataSourceTitle = [NSMutableArray array];
    }
    return _dataSourceTitle;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    self.cycleScrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenWidth/3) imageURLStringsGroup:self.dataSourceUrl];
    self.cycleScrollview.currentPageDotColor = kThemeColor;
    self.cycleScrollview.delegate = self;
    self.cycleScrollview.autoScrollTimeInterval = 5;
    [self.AdvertisementView addSubview:self.cycleScrollview];
}

-(void)setAdv_height:(CGFloat)Adv_height{
    
    self.cycleScrollview.height = Adv_height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    if ([self.delegate respondsToSelector:@selector(DidSelectAdvertisementIndex:)]) {
        
        [self.delegate DidSelectAdvertisementIndex:index];
    }
    
}

@end

