//
//  XHSearchController.m
//  XHKitDemo
//
//  Created by zhu on 2016/11/15.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "XHSearchController.h"

static NSString *const XHHistoryUserDefaults = @"XHHistoryUserDefaults";

@interface XHSearchController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, XHTagsViewDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) XHTagsView *tagsView;
@property (nonatomic, strong) UIView *searchBackgroundView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIColor *statusBarColor;
@property (nonatomic, assign) BOOL isSearch;
@property (nonatomic, assign) BOOL didLayoutSubViews;
@property (nonatomic, strong) NSMutableArray *historySearchs;
@property (nonatomic, strong) UIButton *showClearButton;
@property (nonatomic, strong) UIView *clearView;

@end

static NSString *const historyCellIdentifier = @"historyCellIdentifier";

@implementation XHSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange) name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (!self.didLayoutSubViews) {
        self.didLayoutSubViews = true;
        [self setupSubViews];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController) {
        UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
        self.statusBarColor = statusBar.backgroundColor;
        statusBar.backgroundColor = self.barBackgroudColor;
        [self.navigationController setNavigationBarHidden:true animated:false];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:false animated:false];
        UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
        statusBar.backgroundColor = self.statusBarColor;
    }
}

- (void)setupSubViews {
    UIEdgeInsets safeEdgeInsets;
    if (__builtin_available(iOS 11, *)) {
        safeEdgeInsets = self.view.safeAreaInsets;
    } else {
        safeEdgeInsets = UIEdgeInsetsZero;
    }
    self.searchBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, safeEdgeInsets.top, self.view.frame.size.width, 44)];
    self.searchBackgroundView.backgroundColor = self.barBackgroudColor;
    [self.view addSubview:self.searchBackgroundView];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(self.view.frame.size.width-50, 7, 35, 30);
    self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:self.barTintColor forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(clickedCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBackgroundView addSubview:self.cancelButton];
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 7, self.view.frame.size.width-65, 30)];
    self.searchTextField.font = [UIFont systemFontOfSize:15];
    self.searchTextField.textColor = self.barTintColor;
    self.searchTextField.tintColor = self.barTintColor;
    self.searchTextField.backgroundColor = [UIColor whiteColor];
    self.searchTextField.layer.cornerRadius = 5;
    self.searchTextField.clipsToBounds = true;
    self.searchTextField.delegate = self;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.searchTextField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.searchBackgroundView addSubview:self.searchTextField];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, 16, 16)];
    iconView.image = [UIImage imageNamed:@"xh_icon_search"];
    [paddingView addSubview:iconView];
    self.searchTextField.leftView = paddingView;
    self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
    self.searchTextField.inputAccessoryView = nil;
    [self.searchTextField becomeFirstResponder];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, safeEdgeInsets.top+44, self.view.frame.size.width, self.view.frame.size.height-safeEdgeInsets.top-44) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[XHHistoryCell class] forCellReuseIdentifier:historyCellIdentifier];
    [self.view addSubview:self.tableView];
    
    if (self.searchStyle == XHSearchStyleHistory) {
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45)];
        self.headerView.clipsToBounds = true;
        UILabel *historyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, self.view.width-10, 15)];
        historyLabel.font = [UIFont systemFontOfSize:15];
        historyLabel.textColor = [UIColor darkGrayColor];
        historyLabel.text = @"历史搜索";
        self.showClearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.showClearButton.frame = CGRectMake(self.view.width-30, 17.5, 20, 20);
        [self.showClearButton addTarget:self action:@selector(showClear) forControlEvents:UIControlEventTouchUpInside];
        [self.showClearButton setImage:[UIImage imageNamed:@"xh_search_clear"] forState:UIControlStateNormal];
        [self.headerView addSubview:self.showClearButton];
        
        [self.headerView addSubview:historyLabel];
        self.tableView.tableHeaderView = self.headerView;
        
        self.clearView.frame = CGRectMake(self.view.width, 17.5, 100, 20);
        [self.headerView addSubview:self.clearView];
    }
    else {
        self.tagsView = [[XHTagsView alloc] initWithFrame:CGRectMake(0, 35, self.view.width, 0) withTags:self.hotKeywords];
        self.tagsView.tagStyle = self.tagStyle;
        self.tagsView.delegate = self;
        
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 70+self.tagsView.height)];
        self.headerView.clipsToBounds = true;
        UILabel *hotLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 15)];
        hotLabel.font = [UIFont systemFontOfSize:15];
        hotLabel.textColor = [UIColor darkGrayColor];
        hotLabel.text = @"热门搜索";
        [self.headerView addSubview:hotLabel];
        
        [self.headerView addSubview:self.tagsView];
        
        UILabel *historyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 45+self.tagsView.height, self.view.width-10, 15)];
        historyLabel.font = [UIFont systemFontOfSize:15];
        historyLabel.textColor = [UIColor darkGrayColor];
        historyLabel.text = @"历史搜索";
        self.showClearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.showClearButton.frame = CGRectMake(self.view.width-30, 42.5+self.tagsView.height, 20, 20);
        [self.showClearButton setImage:[UIImage imageNamed:@"xh_search_clear"] forState:UIControlStateNormal];
        [self.showClearButton addTarget:self action:@selector(showClear) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:self.showClearButton];
        [self.headerView addSubview:historyLabel];
        self.tableView.tableHeaderView = self.headerView;
        
        self.clearView.frame = CGRectMake(self.view.width, 42.5+self.tagsView.height, 100, 20);
        [self.headerView addSubview:self.clearView];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.historySearchs = [NSMutableArray arrayWithArray:[userDefaults objectForKey:XHHistoryUserDefaults]];
    [self.tableView reloadData];
}

- (void)keyboardChange {
    self.searchTextField.inputAccessoryView = nil;
    [self.searchTextField reloadInputViews];
}

- (void)clickedCancelButton {
    [self.searchTextField resignFirstResponder];
    [self.delegate.navigationController popViewControllerAnimated:false];
    [self dismissViewControllerAnimated:false completion:nil];
}

- (void)showClear {
    self.showClearButton.hidden = true;
    [UIView animateWithDuration:0.2 animations:^{
        self.clearView.transform = CGAffineTransformIdentity;
        self.clearView.transform = CGAffineTransformMakeTranslation(-110, 0);
    }];
}

- (void)clearHistory {
    [self.historySearchs removeAllObjects];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.historySearchs forKey:XHHistoryUserDefaults];
    [userDefaults synchronize];
    [self.tableView reloadData];
    [self clearHistoryCancel];
}

- (void)clearHistoryCancel {
    [UIView animateWithDuration:0.2 animations:^{
        self.clearView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.showClearButton.hidden = false;
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    self.isSearch = true;
    self.headerView.height = 0;
    [self.historySearchs addObject:textField.text];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.historySearchs forKey:XHHistoryUserDefaults];
    [userDefaults synchronize];
    
    if ([self.delegate respondsToSelector:@selector(searchController:didSearchWithKeyword:)]) {
        [self.delegate searchController:self didSearchWithKeyword:textField.text];
    }
    return true;
}

- (void)textFieldEditingChanged:(UITextField *)textField {
    if (textField.text.length == 0) {
        self.isSearch = false;
        if (self.searchStyle == XHSearchStyleHistory) {
            self.headerView.height = 45;
        } else {
            self.headerView.height = 70+self.tagsView.frame.size.height;
        }
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isSearch) {
        if ([self.delegate respondsToSelector:@selector(numberOfSectionsInsearchController:)]) {
            return [self.delegate numberOfSectionsInsearchController:self];
        }
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSearch) {
        if ([self.delegate respondsToSelector:@selector(searchController:numberOfRowsInSection:)]) {
            return [self.delegate searchController:self numberOfRowsInSection:section];
        }
        return 0;
    }
    return self.historySearchs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isSearch) {
        if ([self.delegate respondsToSelector:@selector(searchController:cellForRowAtIndexPath:)]) {
            return [self.delegate searchController:self cellForRowAtIndexPath:indexPath];
        }
    }
    XHHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:historyCellIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = self.historySearchs[indexPath.row];
    cell.deleteHistory = ^(NSString *historySearch) {
        [self.historySearchs removeObject:historySearch];
        [self.tableView reloadData];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isSearch) {
        if ([self.delegate respondsToSelector:@selector(searchController:heightForRowAtIndexPath:)]) {
            return [self.delegate searchController:self heightForRowAtIndexPath:indexPath];
        }
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.isSearch) {
        if ([self.delegate respondsToSelector:@selector(searchController:heightForHeaderInSection:)]) {
            return [self.delegate searchController:self heightForHeaderInSection:section];
        }
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.isSearch) {
        if ([self.delegate respondsToSelector:@selector(searchController:heightForFooterInSection:)]) {
            return [self.delegate searchController:self heightForFooterInSection:section];
        }
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.isSearch) {
        if ([self.delegate respondsToSelector:@selector(searchController:viewForHeaderInSection:)]) {
            return [self.delegate searchController:self viewForHeaderInSection:section];
        }
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.isSearch) {
        if ([self.delegate respondsToSelector:@selector(searchController:viewForFooterInSection:)]) {
            return [self.delegate searchController:self viewForFooterInSection:section];
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.isSearch) {
        if ([self.delegate respondsToSelector:@selector(searchController:didSelectRowAtIndexPath:)]) {
            return [self.delegate searchController:self didSelectRowAtIndexPath:indexPath];
        }
    } else {
        [self.view endEditing:YES];
        self.isSearch = true;
        self.headerView.height = 0;
        self.searchTextField.text = self.historySearchs[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(searchController:didSearchWithKeyword:)]) {
            [self.delegate searchController:self didSearchWithKeyword:self.historySearchs[indexPath.row]];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - XHTagsViewDelegate
- (void)tagView:(XHTagsView *)tagView didClickedTag:(NSString *)text atIndex:(NSInteger)index {
    [self.view endEditing:YES];
    self.isSearch = true;
    self.headerView.height = 0;
    self.searchTextField.text = text;
    if ([self.delegate respondsToSelector:@selector(searchController:didSearchWithKeyword:)]) {
        [self.delegate searchController:self didSearchWithKeyword:text];
    }
}

- (UIView *)clearView {
    if (!_clearView) {
        _clearView = [[UIView alloc] init];
        _clearView.backgroundColor = [UIColor whiteColor];
        UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        clearButton.frame = CGRectMake(0, 0, 60, 20);
        clearButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [clearButton setTitle:@"全部清除" forState:UIControlStateNormal];
        [clearButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [clearButton addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventTouchUpInside];
        [_clearView addSubview:clearButton];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(60, 3, 1, 14)];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_clearView addSubview:line];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(60, 0, 40, 20);
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(clearHistoryCancel) forControlEvents:UIControlEventTouchUpInside];
        [_clearView addSubview:cancelButton];
    }
    return _clearView;
}

@end


@implementation XHHistoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.iconButton.userInteractionEnabled = false;
        [self.iconButton setImage:[UIImage imageNamed:@"xh_search_history"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.iconButton];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 12, 200, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:self.titleLabel];
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteButton setImage:[UIImage imageNamed:@"xh_search_close"] forState:UIControlStateNormal];
        [self.deleteButton addTarget:self action:@selector(clickedDeleteButton) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.deleteButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconButton.frame = CGRectMake(10, 12, 20, 20);
    self.titleLabel.frame = CGRectMake(40, 12, self.width-80, 20);
    self.deleteButton.frame = CGRectMake(self.width-30, 12, 20, 20);
}

- (void)clickedDeleteButton {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *history = [NSMutableArray arrayWithArray:[userDefaults objectForKey:XHHistoryUserDefaults]];
    [history removeObject:self.titleLabel.text];
    [userDefaults setObject:history forKey:XHHistoryUserDefaults];
    [userDefaults synchronize];
    if (self.deleteHistory) {
        self.deleteHistory(self.titleLabel.text);
    }
}



@end
