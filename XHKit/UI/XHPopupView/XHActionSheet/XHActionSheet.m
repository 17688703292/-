//
//  XHActionSheet.m
//  XHKitDemo
//
//  Created by zhu on 2016/11/15.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "XHActionSheet.h"

@interface XHActionSheet () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *dismissView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) void (^callback)(NSInteger index);

@end

static NSString *const CellIdentifier = @"CellIdentifier";

@implementation XHActionSheet

+ (void)showWithTitle:(NSArray<NSString *> *)titles presentController:(UIViewController *)controller selectedCallback:(void (^)(NSInteger))callback {
    XHActionSheet *actionSheet = [[XHActionSheet alloc] initWithTitles:titles selectedCallback:callback];
    [controller presentViewController:actionSheet animated:false completion:nil];
}

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles selectedCallback:(void (^)(NSInteger))callback {
    if (self = [super init]) {
        _titles = [NSMutableArray array];
        [_titles addObject:titles];
        [_titles addObject:@[@"取消"]];
        self.callback = callback;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self setupGestures];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self setupTableView];
}

- (void)setupGestures {
    UITapGestureRecognizer *hideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelOnClicked)];
    [self.dismissView addGestureRecognizer:hideTap];
}

- (void)setupTableView {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.dismissView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    
    UIEdgeInsets safeAreaEdgeInsets;
    if (@available(iOS 11, *)) {
        safeAreaEdgeInsets = self.view.safeAreaInsets;
    } else {
        safeAreaEdgeInsets = UIEdgeInsetsZero;
    }
    CGFloat height = (self.titles.count+1)*50+safeAreaEdgeInsets.bottom+10;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, screenHeight, screenWidth, height)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.scrollEnabled = false;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    [self.view addSubview:self.tableView];
    
    if (@available(iOS 11, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.tableView.frame = CGRectMake(0, screenHeight-height, screenWidth, height);
        self.dismissView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    } completion:nil];
}

- (void)cancelOnClicked {
    self.selectedIndex = -1;
    [self hideActionSheet];
}

- (void)hideActionSheet {
    CGRect frame = self.tableView.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height;
    [UIView animateWithDuration:0.2 animations:^{
        self.dismissView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        self.tableView.frame = frame;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:false completion:^{
            if (self.callback && self.selectedIndex >= 0) {
                self.callback(self.selectedIndex);
            }
        }];
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rows = self.titles[section];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSArray *rows = self.titles[indexPath.section];
    cell.textLabel.text = rows[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    if (indexPath.section == 0) {
        self.selectedIndex = indexPath.row;
    }
    else {
        self.selectedIndex = -1;
    }
    [self hideActionSheet];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        UIEdgeInsets safeAreaEdgeInsets;
        if (@available(iOS 11, *)) {
            safeAreaEdgeInsets = self.view.safeAreaInsets;
        } else {
            safeAreaEdgeInsets = UIEdgeInsetsZero;
        }
        return 50+safeAreaEdgeInsets.bottom;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return 0.1;
}

- (UIView *)dismissView {
    if (!_dismissView) {
        _dismissView = [UIView new];
        [self.view addSubview:_dismissView];
    }
    return _dismissView;
}

@end
