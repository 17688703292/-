//
//  XHMenuView.h
//  XHMenuDemo
//
//  Created by Carson on 2017/8/28.
//  Copyright © 2017年 Carson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHMenuModel.h"

//selected
typedef void(^BlockSelectedMenu)(NSInteger menuRow);

@interface XHMenuView : UIView
/**
 *  文字
 */
@property (nonatomic, copy) NSArray *titleArray;
/**
 *  图片
 */
@property (nonatomic, copy) NSArray *imageArray;
/** 
 *  图文Model
 */
@property (nonatomic, copy) NSArray<XHMenuModel *> *menuArray;
/**
 *  蒙层背景color
 */
@property (nonatomic, strong) UIColor *coverBgColor;
/**
 *  主样式color
 */
@property (nonatomic, strong) UIColor *menuBgColor;
/**
 *  cell 分割线 color
 */
@property (nonatomic, strong) UIColor *menuCellLineColor;
/**
 *  cell 文字字体
 */
@property (nonatomic, strong) UIFont *menuCellFont;
/**
 *  cel高度
 */
@property (nonatomic, assign) CGFloat menuCellHeight;
/**
 *  是否隐藏cell分割线
 */
@property (nonatomic, assign) BOOL hideCellLine;
/**
 *  table最大高度限制
 *  默认：5 * cellHeight
 */
@property (nonatomic, assign) CGFloat menuMaxHeight;
/** 
 *  小三角高度
 *  45°等腰三角形
 */
@property (nonatomic, assign) CGFloat triangleHeight;
/** 
 *  Menu样式
 */
@property (nonatomic, assign) XHMenuStyle menuStyle;
/**
 *  click
 */
@property (nonatomic, copy) BlockSelectedMenu blockSelectedMenu;
/**
 *  anchorView：下拉依赖视图[推荐初始化]
 *  箭头指向依赖视图
 *  titleArray:文字
 *  imageArray:icon
 *  menuArray:图文Model
 */
+ (instancetype)pullMenuAnchorView:(UIView *)anchorView;
+ (instancetype)pullMenuAnchorView:(UIView *)anchorView titleArray:(NSArray *)titleArray;
+ (instancetype)pullMenuAnchorView:(UIView *)anchorView titleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray;
+ (instancetype)pullMenuAnchorView:(UIView *)anchorView menuArray:(NSArray<XHMenuModel *> *)menuArray;

/**
 *  anchorView：下拉依赖绝对坐标
 *  指定坐标下拉
 *  箭头指向点
 *  titleArray:文字
 *  imageArray:icon
 *  menuArray:图文Model
 */
+ (instancetype)pullMenuAnchorPoint:(CGPoint)anchorPoint;
+ (instancetype)pullMenuAnchorPoint:(CGPoint)anchorPoint titleArray:(NSArray *)titleArray;
+ (instancetype)pullMenuAnchorPoint:(CGPoint)anchorPoint titleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray;
+ (instancetype)pullMenuAnchorPoint:(CGPoint)anchorPoint menuArray:(NSArray<XHMenuModel *> *)menuArray;
@end
