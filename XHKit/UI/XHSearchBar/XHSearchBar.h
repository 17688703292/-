//
//  XHSearchBar.m
//  XHKitDemo
//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHSearchController.h"

@class XHSearchBar;
@protocol XHSearchBarDelegate <NSObject>

- (void)searchBar:(XHSearchBar *)searchBar willTurnToSearchController:(XHSearchController *)controller;

@end

@interface XHSearchBar : UIView

@property (nonatomic, copy) NSString *placeholder;        ///< 提示语
@property (nonatomic, strong) UIColor *barBackgroudColor; ///< 背景色
@property (nonatomic, strong) UIColor *barTintColor;      ///< 编辑颜色
@property (nonatomic, strong) NSArray *hotKeywords;       ///< 热门关键字
@property (nonatomic, assign) XHTagStyle tagStyle;        ///< 热门关键字的样式
@property (nonatomic, assign) XHSearchStyle searchStyle;  ///< 搜索样式

@property (nonatomic, weak) id <XHSearchBarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder delegate:(id <XHSearchBarDelegate>)delegate;

@end
