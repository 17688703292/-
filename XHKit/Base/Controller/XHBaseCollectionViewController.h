//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHBaseCollectionViewController : UICollectionViewController

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger total;


/** 设置子视图重写 */
- (void)setupSubViews;
/** 添加约束重写 */
- (void)makeConstraints;
/** 请求数据重写 */
- (void)loadData;


/**添加置顶按钮*/
@property (nonatomic,strong)UIButton *ReturnTopBtn;
@property (nonatomic,copy)void (^Begain)(void);
#pragma mark BarButtonItem

/**
 添加导航图片右键
 @param iconName 图片名
 */
- (UIBarButtonItem *)addRightItemWithIconName:(NSString *)iconName;

/**
 添加导航文字右键
 @param title 左键标题
 @param color 文字颜色
 */
- (UIBarButtonItem *)addRightItemWithTitle:(NSString *)title titleColor:(UIColor *)color;

/**
 重写右键点击事件
 @param index 对应rightButtonItem角标
 */
- (void)rightButtonItemOnClicked:(NSInteger)index;

/**
 添加导航图片左键
 @param iconName 图片名
 */
- (UIBarButtonItem *)addLeftItemWithIconName:(NSString *)iconName;

/**
 添加导航文字左键
 @param title 左键标题
 @param color 文字颜色
 */
- (UIBarButtonItem *)addLeftItemWithTitle:(NSString *)title titleColor:(UIColor *)color;

/**
 重写左键点击事件
 @param index 对应leftButtonItem角标
 */
- (void)leftButtonItemOnClicked:(NSInteger )index;

/**
 添加置顶按钮
 */
- (void)AddReturnTopBtnIconImageName:(NSString *)ImageName frame:(CGRect )frame blcok:(void (^)(void))Begain;

@end

