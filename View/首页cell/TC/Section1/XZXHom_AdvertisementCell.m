//
//  XZXHom_AdvertisementCell.m
//  Slumbers
//
//  Created by RedSky on 2018/12/19.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXHom_AdvertisementCell.h"

@implementation XZXHom_AdvertisementCell

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

    
    self.cycleScrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenWidth*0.5) imageURLStringsGroup:self.dataSourceUrl];
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
