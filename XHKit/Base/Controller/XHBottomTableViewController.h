//
//  XHBottomViewController.h
//  XHKitDemo
//
//  Created by zhu on 2018/11/15.
//  Copyright © 2018 zhu. All rights reserved.
//

#import "XHBaseViewController.h"

@interface XHBottomTableViewController : XHBaseViewController

@property (nonatomic, strong) UIView *bottomView;   ///< 底部视图
@property (nonatomic, assign) CGFloat bottomHeight; ///< 底部高度
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end
