//
//  XZXMineCustomerTVC.m
//  BigMarket
//
//  Created by RedSky on 2019/6/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMineCustomerTVC.h"
#import "UINavigationBar+Awesome.h"

@interface XZXMineCustomerTVC ()

@end

@implementation XZXMineCustomerTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"客服";
    self.bottomImage.cornerRadius = 5.0;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, kScreenWidth*0.8, kScreenWidth*0.8*0.285);  // 设置显示的frame
    gradientLayer.colors =@[(id)[UIColor hexStringToColor:@"ffc958"].CGColor,(id)[UIColor hexStringToColor:@"ffa30d"].CGColor];   // 设置渐变颜色
    //    gradientLayer.locations = @[@0.0, @0.2, @0.5];    // 颜色的起点位置，递增，并且数量跟颜色数量相等
    gradientLayer.startPoint = CGPointMake(0, 0);   //
    gradientLayer.endPoint = CGPointMake(1, 0);     //
    [self.bottomImage.layer addSublayer:gradientLayer];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CallPhone)];
    [self.bottomImage addGestureRecognizer:tap];
    self.bottomImage.userInteractionEnabled = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent = YES;
    
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
    
                               forBarPosition:UIBarPositionAny
    
                                   barMetrics:UIBarMetricsDefault];   // 设置navigationBar的颜色为透明的
    
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
        [self.navigationController.navigationBar setTranslucent:YES];
        [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}

-(void)viewWillDisappear:(BOOL)animated{
     self.navigationController.navigationBar.translucent = YES;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)CallPhone{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://0745-2280636"]];
}

@end
