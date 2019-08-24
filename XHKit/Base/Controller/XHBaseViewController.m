//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "XHBaseViewController.h"
#import "XHMacro.h"

@interface XHBaseViewController ()

@property (nonatomic, assign) BOOL didLayoutSubViews;
@property (nonatomic,strong) UIView *LoadFairView;

@end

@implementation XHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kConfig(XHBaseBackgroundColor);

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

#pragma mark 视图加载数据失败
-(void)LoadViewresult:(NSNotification *)notification{
    
    NSDictionary *dic = notification.userInfo;
    if ([[dic valueForKey:@"Result"] isEqualToString:@"Fair"]) {
        
        if (!_LoadFairView && self.NeedErrorView == true) {
            _LoadFairView = [[UIView alloc]initWithFrame:self.view.bounds];
            _LoadFairView.backgroundColor = kBackgroundColor;
            [self.view addSubview:self.LoadFairView];
            UIButton *button = [[UIButton alloc]init];
            [self.LoadFairView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.LoadFairView);
                make.centerY.mas_equalTo(self.LoadFairView).offset(-kScreenWidth/6.0);
                make.width.mas_equalTo(kScreenWidth/6.0);
                make.height.mas_equalTo(kScreenWidth/6.0);
            }];
            [button setTitle:@"重新加载..." forState:UIControlStateNormal];
            [button setTintColor:[UIColor blueColor]];
            [button addTarget:self action:@selector(AgainLoadData) forControlEvents:UIControlEventTouchDown];
        }
        _LoadFairView.hidden = false;
    }else{
        
        if (_LoadFairView && self.NeedErrorView == true) {
            _LoadFairView.hidden = true;
        }
        
    }
}

-(void)AgainLoadData{
    
    if (self.AgainLoadDataBlock) {
        self.AgainLoadDataBlock();
    }
    
}

#pragma mark - 重写辅助方法
/**
 子视图相关可以写到方法里面
 */
- (void)setupSubViews {
}
/**
 子视图的约束可以写到里面，safeArea特别注意要写到里面
 */
- (void)makeConstraints {
}
/**
 加载数据
 */
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
- (UIBarButtonItem *)addSignalRightItemWithTitle:(NSString *)title titleColor:(UIColor *)color {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked:)];
    rightItem.tintColor = color;
    self.navigationItem.rightBarButtonItem = rightItem;
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


- (UIBarButtonItem *)addLeftItemWithTitle:(NSString *)title WithImage:(NSString *)ImageName titleColor:(UIColor *)color{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/7.0,self.navigationController.navigationBar.frame.size.height)];
    
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/7.0, self.navigationController.navigationBar.frame.size.height*0.8)];
    headImage.image = [UIImage imageNamed:ImageName];
    [view addSubview:headImage];
    
    headImage.contentMode = UIViewContentModeCenter;
    
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height*0.8, kScreenWidth/7.0, self.navigationController.navigationBar.frame.size.height*0.1)];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13.0];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    leftItem.tintColor = color;
    self.navigationItem.leftBarButtonItem = leftItem;
    return leftItem;
}

- (UIBarButtonItem *)addRightItemWithTitle:(NSString *)title WithImage:(NSString *)ImageName titleColor:(UIColor *)color{
    
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/7.0,self.navigationController.navigationBar.frame.size.height)];
    
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/7.0, self.navigationController.navigationBar.frame.size.height*0.8)];
    headImage.image = [UIImage imageNamed:ImageName];
    [view addSubview:headImage];
    
    headImage.contentMode = UIViewContentModeCenter;
    
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height*0.8, kScreenWidth/7.0, self.navigationController.navigationBar.frame.size.height*0.1)];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13.0];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    rightItem.tintColor = color;
    self.navigationItem.rightBarButtonItem = rightItem;
    return rightItem;
}

- (void)leftItemClicked:(UIBarButtonItem *)buttonItem {
    [self leftButtonItemOnClicked:[self.navigationItem.leftBarButtonItems indexOfObject:buttonItem]];
}

- (void)leftButtonItemOnClicked:(NSInteger )index {
    if (index == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
