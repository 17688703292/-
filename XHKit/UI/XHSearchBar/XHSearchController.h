//
//  XHSearchController.h
//  XHKitDemo
//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHTagsView.h"

@class XHSearchController;
@protocol XHSearchControllerDelegate <NSObject>
@optional
/**
 开始搜索
 @param keyword 搜索关键字
 */
- (void)searchController:(XHSearchController *)controller didSearchWithKeyword:(NSString *)keyword;

- (NSInteger)numberOfSectionsInsearchController:(XHSearchController *)controller;
- (NSInteger)searchController:(XHSearchController *)controller numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)searchController:(XHSearchController *)controller cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIView *)searchController:(XHSearchController *)controller viewForFooterInSection:(NSInteger)section;
- (UIView *)searchController:(XHSearchController *)controller viewForHeaderInSection:(NSInteger)section;
- (CGFloat)searchController:(XHSearchController *)controller heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)searchController:(XHSearchController *)controller heightForHeaderInSection:(NSInteger)section;
- (CGFloat)searchController:(XHSearchController *)controller heightForFooterInSection:(NSInteger)section;
- (void)searchController:(XHSearchController *)controller didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

typedef NS_ENUM(NSInteger, XHSearchStyle) {
    XHSearchStyleHot,
    XHSearchStyleHistory,
};

@interface XHSearchController : UIViewController

@property (nonatomic, weak) UIViewController <XHSearchControllerDelegate> *delegate;
@property (nonatomic, assign) XHTagStyle tagStyle;        ///< 热门关键字的样式
@property (nonatomic, assign) XHSearchStyle searchStyle;  ///< 搜索样式
@property (nonatomic, strong) UIColor *barBackgroudColor; ///< 背景色
@property (nonatomic, strong) UIColor *barTintColor;      ///< 编辑颜色
@property (nonatomic, strong) NSArray *hotKeywords;       ///< 热门关键字
@property (nonatomic, strong) UITableView *tableView;

@end

@interface XHHistoryCell : UITableViewCell

@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, copy) void (^deleteHistory)(NSString *historySearch);

@end
