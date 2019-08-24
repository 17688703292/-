//
//  XZXMineOrderVC.m
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXMineOrderVC.h"
#import "XZXAllOrderTVC.h"
#import "XZXWaittingSendTVC.h"
#import "XZXWattingPaymentTVC.h"
#import "XZXWattingReceiveTVC.h"
#import "XZXWattingEvalution.h"
#import "XZXCancelTVC.h"

@interface XZXMineOrderVC ()

@property (nonatomic, strong) NSArray *titleDatas;
@property (nonatomic,strong) XZXAllOrderTVC *OrderTVC;
@property (nonatomic,strong) XZXWaittingSendTVC *SendTVC;
@property (nonatomic,strong) XZXWattingPaymentTVC *PaymentTVC;
@property (nonatomic,strong) XZXWattingReceiveTVC *ReceiveTVC;
@property (nonatomic,strong) XZXWattingEvalution *Evalution;
@property (nonatomic,strong) XZXCancelTVC *CancelTVC;

@end

@implementation XZXMineOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"全部订单";
    //[self AddRightItem];
    
}
-(void)viewDidAppear:(BOOL)animated{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - WMPageController
- (instancetype)init {
    if (self = [super init]) {
        self.menuViewStyle = WMMenuViewStyleLine;
        //设置WMPageController每个标题的宽度
        self.menuItemWidth = kScreenWidth/4;
        self.pageAnimatable = YES;
        //设置WMPageController选中的标题的颜色
        self.titleColorNormal = [UIColor darkGrayColor];
        self.titleColorSelected = kThemeColor;
    }
    return self;
}
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titleDatas.count;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, 50, self.view.width, self.view.height-50);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    menuView.backgroundColor = kWhite;
    return CGRectMake(0, 0.5, kScreenWidth, 49.5);
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titleDatas[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    
    if (index == AllOrder_VC) {
        return self.OrderTVC;
    }
    else if(index == WattingPayment_VC) {
        
        return self.PaymentTVC;
    }else if (index == WattingSend_VC){
        
        return self.SendTVC;
    }else if (index == WattingReceive_VC){
        
        return self.ReceiveTVC;
    }else if (index == Finish_VC){
        
        return self.Evalution;
    }else{
        
        return self.OrderTVC;
    }
}


#pragma mark - Setter
- (NSArray *)titleDatas {
    if(!_titleDatas) {
        _titleDatas = @[@"全部订单", @"待付款",@"待发货",@"待收货",@"未/已评价"];
    }
    return _titleDatas;
}

-(XZXAllOrderTVC *)OrderTVC{
    if (!_OrderTVC) {
        _OrderTVC = [XZXAllOrderTVC new];
    }
    return _OrderTVC;
}

-(XZXWaittingSendTVC *)SendTVC{
    if (!_SendTVC) {
        _SendTVC = [XZXWaittingSendTVC new];
    }
    return _SendTVC;
}

-(XZXWattingPaymentTVC *)PaymentTVC{
    if (!_PaymentTVC) {
        _PaymentTVC = [XZXWattingPaymentTVC new];
    }
    return _PaymentTVC;
}

-(XZXWattingReceiveTVC *)ReceiveTVC{
    if (!_ReceiveTVC) {
        _ReceiveTVC = [XZXWattingReceiveTVC new];
    }
    return _ReceiveTVC;
}

-(XZXWattingEvalution *)Evalution{
    if (!_Evalution) {
        _Evalution = [XZXWattingEvalution new];
    }
    return _Evalution;
}

-(XZXCancelTVC *)CancelTVC{
    if (!_CancelTVC) {
        _CancelTVC = [XZXCancelTVC new];
    }
    return _CancelTVC;
    
}
-(void)AddRightItem{
    
    UIImage *image = [[UIImage imageNamed:@"sousuo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClicked:)];
    NSMutableArray *rightBarButtonItems = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    [rightBarButtonItems addObject:rightItem];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    
}
- (void)rightItemClicked:(UIBarButtonItem *)buttonItem {
    
    [MBProgressHUD xh_showHudWithMessage:@"搜索" toView:self.view completion:^{
        
    }];
}
@end
