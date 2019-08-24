//
//  XZXHom_CarouselAdvertisementCell.h
//  BigMarket
//
//  Created by RedSky on 2019/6/9.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQFlowView.h"
#import "HQImagePageControl.h"
NS_ASSUME_NONNULL_BEGIN


@class XZXHom_CarouselAdvertisementCell;
@protocol XZXHom_CarouselAdvertisementCellDelegate<NSObject>

-(void)DidSelectAdvertisementIndex:(NSInteger )index;
@end


@interface XZXHom_CarouselAdvertisementCell : UITableViewCell<HQFlowViewDelegate,HQFlowViewDataSource>

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *advArray;
/**
 *  轮播图
 */
@property (nonatomic, strong) HQImagePageControl *pageC;
@property (nonatomic, strong) HQFlowView *pageFlowView;
@property (nonatomic, strong) UIScrollView *scrollView; // 轮播图容器

@property (nonatomic,weak) id <XZXHom_CarouselAdvertisementCellDelegate>delegate;
//初始化卡片轮播图
-(void)Carousel;
@end

NS_ASSUME_NONNULL_END
