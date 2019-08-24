//
//  XZXAp_Product_Success.m
//  BigMarket
//
//  Created by RedSky on 2019/6/2.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXAp_Product_Success.h"
#import "XZXAp_Product_updata.h"
#import "XZXMineTVC.h"

@interface XZXAp_Product_Success ()

@end

@implementation XZXAp_Product_Success

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"开店成功";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void)leftButtonItemOnClicked:(NSInteger)index{
    
    for (UIViewController *VC in self.navigationController.viewControllers) {
        if ([VC isKindOfClass:[XZXMineTVC class]]) {
            [self.navigationController popToViewController:VC animated:YES];
        }
    }
}


- (IBAction)addProduct:(id)sender {

    
    XZXAp_Product_updata *one = kStoryboradController(@"ApplicationStore", @"XZXAp_Product_updataID");
    one.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:one animated:YES];
}
@end
