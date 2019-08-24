//
//  XHBottomViewController.m
//  XHKitDemo
//
//  Created by zhu on 2018/11/15.
//  Copyright © 2018 zhu. All rights reserved.
//

#import "XHBottomTableViewController.h"
#import "XHKit.h"

@interface XHBottomTableViewController () <UITableViewDelegate, UITableViewDataSource>


@end

@implementation XHBottomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupSubViews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    self.bottomView = [UIView viewWithFrame:CGRectZero backgroundColor:kGroupGray inView:self.view];
    self.bottomHeight = 50;
}

- (void)setBottomHeight:(CGFloat)bottomHeight {
    _bottomHeight = bottomHeight;
    self.bottomView.frame = CGRectMake(0, self.view.height-bottomHeight-kSafeAreaBottm(self.view), kScreenWidth, bottomHeight+kSafeAreaBottm(self.view));
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, self.view.height-bottomHeight-kSafeAreaBottm(self.view));
}


@end
