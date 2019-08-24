//
//  XHPickerController.m
//  XHKitDemo
//
//  Created by zhu on 2016/11/15.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "XHPickerController.h"
#import "UIView+XHConstructor.h"
#import "UIButton+XHConstructor.h"
#import "UIColor+XHHexColor.h"

@interface XHPickerController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *objects;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, strong) NSMutableArray *selectedArray;

@end

static NSString *const XHPickerControllerCell = @"XHPickerControllerCell";

@implementation XHPickerController

- (instancetype)initWithObjects:(NSArray *)objects delegate:(id<XHPickerControllerDelegate>)delegate {
    if (self = [super init]) {
        self.objects = objects;
        self.delegate = delegate;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)setupSubViews {
    UIEdgeInsets safeEdgeInsets;
    if (@available(iOS 11, *)) {
        safeEdgeInsets = self.view.safeAreaInsets;
    } else {
        safeEdgeInsets = UIEdgeInsetsZero;
    }
    
    self.maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedCancelButton)];
    [self.maskView addGestureRecognizer:tap];
    [self.view addSubview:self.maskView];
    
    CGFloat height = self.objects.count > 8 ? 45*8 : self.objects.count*45;
    self.contentHeight = height+50;
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height, self.view.width, self.contentHeight+safeEdgeInsets.bottom)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentView];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    header.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:header];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, self.view.width-120, 30)];
    self.titleLabel.text = self.pickerTitle;
    self.titleLabel.textColor = [UIColor colorWithRed:36/255.0f green:140/255.0f blue:233/255.0f alpha:1];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    
    self.cancelButton = [UIButton buttonWithFrame:CGRectMake(10, 10, 40, 30) title:@"取消" font:[UIFont systemFontOfSize:15] titleColor:[UIColor darkGrayColor] inView:self.contentView];
    [self.cancelButton addTarget:self action:@selector(clickedCancelButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.doneButton = [UIButton buttonWithFrame:CGRectMake(self.view.width-50, 10, 40, 30) title:@"确定" font:[UIFont systemFontOfSize:15] titleColor:[UIColor colorWithRed:36/255.0f green:140/255.0f blue:233/255.0f alpha:1] inView:self.contentView];
    [self.doneButton addTarget:self action:@selector(clickedDoneButton) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.pickerStyle == XHPickerStyleSingle) {
        self.doneButton.hidden = true;
    } else {
        self.doneButton.hidden = false;
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.width, height) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = false;
    [self.contentView addSubview:self.tableView];
    if (height <= 45*8) {
        self.tableView.scrollEnabled = false;
    }
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:XHPickerControllerCell];
    
    [self showAnimation];
}

- (void)showPicker {
    [((UIViewController *)self.delegate) presentViewController:self animated:false completion:nil];
}

- (void)showAnimation {
    UIEdgeInsets safeEdgeInsets;
    if (@available(iOS 11, *)) {
        safeEdgeInsets = self.view.safeAreaInsets;
    } else {
        safeEdgeInsets = UIEdgeInsetsZero;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -self.contentHeight-safeEdgeInsets.bottom);
        self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self.tableView reloadData];
    }];
}

- (void)clickedCancelButton {
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.maskView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:false completion:nil];
    }];
}

- (void)clickedDoneButton {
    if (self.pickerStyle != XHPickerStyleSingle) {
        if (self.pickerStyle == XHPickerStyleWeek) {
            NSMutableArray *arr = [NSMutableArray arrayWithArray:self.selectedArray];
            for (NSNumber *number in arr) {
                if (number.integerValue == 0) {
                    [self.selectedArray removeObject:number];
                }
            }
        }
        [UIView animateWithDuration:0.2 animations:^{
            self.contentView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:false completion:^{
                if ([self.delegate respondsToSelector:@selector(pickerController:didSelectedIndexs:)]) {
                    [self.delegate pickerController:self didSelectedIndexs:self.selectedArray];
                }
            }];
        }];
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XHPickerControllerCell forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryNone;
    id obj = self.objects[indexPath.row];
    if ([obj isKindOfClass:[NSString class]]) {
        cell.textLabel.text = obj;
    } else if ([self.delegate respondsToSelector:@selector(pickerTableView:textForIndexPath:)]) {
        cell.textLabel.text = [self.delegate pickerTableView:tableView textForIndexPath:indexPath];
    }
    
    switch (self.pickerStyle) {
        case XHPickerStyleSingle: {
            if (indexPath.row == self.selectedIndex) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
            break;
        case XHPickerStyleMultiple: {
            for (id obj in self.selectedArray) {
                if ([obj integerValue] == indexPath.row) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }
        }
            break;
        case XHPickerStyleWeek: {
            if (self.selectedIndexs.count >= 7 && indexPath.row == 0) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                for (id obj in self.selectedArray) {
                    if ([obj integerValue] == indexPath.row) {
                        cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    }
                }
            }
        }
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (self.pickerStyle) {
        case XHPickerStyleSingle: {
            if ([self.delegate respondsToSelector:@selector(pickerController:didSelectedIndex:)]) {
                [self.delegate pickerController:self didSelectedIndex:indexPath.row];
            }
            [self clickedCancelButton];
        }
            break;
        case XHPickerStyleMultiple: {
            BOOL selected = false;
            NSInteger row = -1;
            for (NSNumber *number in self.selectedArray) {
                if ([number integerValue] == indexPath.row) {
                    selected = true;
                    row = [self.selectedArray indexOfObject:number];
                }
            }
            if (selected) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self.selectedArray removeObjectAtIndex:row];
            } else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [self.selectedArray addObject:@(indexPath.row)];
            }
        }
            break;
        case XHPickerStyleWeek: {
            if (indexPath.row == 0) {
                if (self.selectedArray.count >= 7) {
                    [self.selectedArray removeAllObjects];
                } else {
                    [self.selectedArray removeAllObjects];
                    for (int i = 0; i <= 7; i ++) {
                        [self.selectedArray addObject:@(i)];
                    }
                }
            }
            else {
                BOOL selected = false;
                NSInteger row = -1;
                for (NSNumber *number in self.selectedArray) {
                    if ([number integerValue] == indexPath.row) {
                        selected = true;
                        row = [self.selectedArray indexOfObject:number];
                    }
                }
                if (selected) {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    [self.selectedArray removeObjectAtIndex:row];
                    [self.selectedArray removeObject:@(0)];
                } else {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    [self.selectedArray addObject:@(indexPath.row)];
                }
                if (self.selectedArray.count == 7) {
                    [self.selectedArray addObject:@(0)];
                }
            }
            [self.tableView reloadData];
        }
            break;
    }
}

#pragma mark - Setter & Getter

- (void)setSelectedIndexs:(NSArray *)selectedIndexs {
    _selectedIndexs = selectedIndexs;
    [self.selectedArray removeAllObjects];
    [self.selectedArray addObjectsFromArray:selectedIndexs];
}

- (NSMutableArray *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}

@end
