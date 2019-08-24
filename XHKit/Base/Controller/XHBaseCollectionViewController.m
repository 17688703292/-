//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "XHBaseCollectionViewController.h"
#import "XHMacro.h"

@interface XHBaseCollectionViewController ()

@property (nonatomic, assign) BOOL didLayoutSubViews;

@end

@implementation XHBaseCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.showsVerticalScrollIndicator = false;
    self.collectionView.backgroundColor = kConfig(XHBaseBackgroundColor);
    
    if (self.navigationController.viewControllers.count > 1) {
        UIImage *image = [kConfig(XHNavigationBackImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(leftItemClicked:)];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    // 控制器手势返回
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self loadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (!self.didLayoutSubViews) {
        self.didLayoutSubViews = true;
        [self setupSubViews];
        [self makeConstraints];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.didLayoutSubViews = false;
}

#pragma mark - 重写辅助方法
- (void)setupSubViews {
}

- (void)makeConstraints {
}

- (void)loadData {
}

#pragma mark - 添加导航右键
- (UIBarButtonItem *)addRightItemWithTitle:(NSString *)title titleColor:(UIColor *)color {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked:)];
    rightItem.tintColor = color;
    NSMutableArray *rightBarButtonItems = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    [rightBarButtonItems addObject:rightItem];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    return rightItem;
}

- (UIBarButtonItem *)addRightItemWithIconName:(NSString *)iconName {
    UIImage *image = [[UIImage imageNamed:iconName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClicked:)];
    NSMutableArray *rightBarButtonItems = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    [rightBarButtonItems addObject:rightItem];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    return rightItem;
}

- (void)rightItemClicked:(UIBarButtonItem *)buttonItem {
    [self rightButtonItemOnClicked:[self.navigationItem.rightBarButtonItems indexOfObject:buttonItem]];
}

- (void)rightButtonItemOnClicked:(NSInteger)index {
    
}

#pragma mark - 添加导航左键

- (UIBarButtonItem *)addLeftItemWithTitle:(NSString *)title titleColor:(UIColor *)color {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClicked:)];
    leftItem.tintColor = color;
    NSMutableArray *leftBarButtonItems = [NSMutableArray arrayWithArray:self.navigationItem.leftBarButtonItems];
    [leftBarButtonItems addObject:leftItem];
    self.navigationItem.leftBarButtonItems = leftBarButtonItems;
    return leftItem;
}

- (UIBarButtonItem *)addLeftItemWithIconName:(NSString *)iconName {
    UIImage *image = [[UIImage imageNamed:iconName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(leftItemClicked:)];
    NSMutableArray *leftBarButtonItems = [NSMutableArray arrayWithArray:self.navigationItem.leftBarButtonItems];
    [leftBarButtonItems addObject:leftItem];
    self.navigationItem.leftBarButtonItems = leftBarButtonItems;
    return leftItem;
}

- (void)leftItemClicked:(UIBarButtonItem *)buttonItem {
    [self leftButtonItemOnClicked:[self.navigationItem.leftBarButtonItems indexOfObject:buttonItem]];
}

- (void)leftButtonItemOnClicked:(NSInteger )index {
    if (index == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Setter
- (NSMutableArray *)dataArray {
    if(!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


- (void)AddReturnTopBtnIconImageName:(NSString *)ImageName frame:(CGRect)frame blcok:(void (^)(void))Begain{
    
    if (!_ReturnTopBtn) {
        _ReturnTopBtn = [[UIButton alloc]initWithFrame:frame];
        
        [_ReturnTopBtn setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
        [[UIApplication sharedApplication].keyWindow addSubview:_ReturnTopBtn];
        [_ReturnTopBtn addTarget:self action:@selector(ReturnTop_Action) forControlEvents:UIControlEventTouchDown];
    }
}

-(void)ReturnTop_Action{
    
    
    if (self.Begain) {
        self.Begain();
    }
}

@end
