//
//  XHPickerController.h
//  XHKitDemo
//
//  Created by zhu on 2016/11/15.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "XHBaseViewController.h"

typedef NS_ENUM(NSInteger, XHPickerStyle) {
    XHPickerStyleSingle,
    XHPickerStyleMultiple,
    XHPickerStyleWeek,
};

@class XHPickerController;
@protocol XHPickerControllerDelegate <NSObject>
@optional
/**
 单选
 @param controller 选择器
 @param index 选择的下标
 */
- (void)pickerController:(XHPickerController *)controller didSelectedIndex:(NSInteger)index;
/**
 多选
 @param controller 选择器
 @param indexs 选择的下标数组
 */
- (void)pickerController:(XHPickerController *)controller didSelectedIndexs:(NSArray *)indexs;
/**
 自定义cell标题
 */
- (NSString *)pickerTableView:(UITableView *)tableView textForIndexPath:(NSIndexPath *)indexPath;

@end

@interface XHPickerController : XHBaseViewController

@property (nonatomic, copy) NSString *pickerTitle;       ///< 选择的标题
@property (nonatomic, assign) XHPickerStyle pickerStyle; ///< 选择样式
@property (nonatomic, assign) NSInteger selectedIndex;   ///< 单选被选中的下标
@property (nonatomic, strong) NSArray <NSNumber *> *selectedIndexs; ///< 多选被选中的下标数组 NSNumber
@property (nonatomic, weak) id <XHPickerControllerDelegate> delegate;

- (instancetype)initWithObjects:(NSArray *)objects delegate:(id <XHPickerControllerDelegate>)delegate;

- (void)showPicker;

@end

