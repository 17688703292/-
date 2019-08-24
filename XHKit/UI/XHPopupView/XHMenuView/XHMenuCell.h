//
//  XHMenuCell.h
//  XHMenuDemo
//
//  Created by Carson on 2017/8/30.
//  Copyright © 2017年 Carson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHMenuModel.h"

@interface XHMenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *menuImageView;
@property (weak, nonatomic) IBOutlet UILabel *menuTitleLab;

/** 
 *  model
 */
@property (nonatomic, strong) XHMenuModel *menuModel;
/** 
 * 最后一栏cell
 */
@property (nonatomic, assign) BOOL isFinalCell;
/**
 *  pullMenu样式
 */
@property (nonatomic, assign) XHMenuStyle menuStyle;
/**
 *  cell 分割线 color
 */
@property (nonatomic, strong) UIColor *menuCellLineColor;
/**
 *  是否隐藏cell分割线
 */
@property (nonatomic, assign) BOOL hideCellLine;
/**
 *  cell背景色
 */
@property (nonatomic, strong) UIColor *cellColor;
/**
 *  cell 文字字体
 */
@property (nonatomic, strong) UIFont *menuCellFont;

@end
