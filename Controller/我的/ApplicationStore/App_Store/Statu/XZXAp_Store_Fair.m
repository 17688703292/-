//
//  XZXAp_Store_Fair.m
//  BigMarket
//
//  Created by RedSky on 2019/6/2.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXAp_Store_Fair.h"
#import "XZXAp_Store_OneVC.h"
#import "XZXMineTVC.h"

@interface XZXAp_Store_Fair ()

@end

@implementation XZXAp_Store_Fair

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addRightItemWithTitle:@"重新申请" titleColor:[UIColor whiteColor]];
    self.title = @"审核失败";
}


-(void)leftButtonItemOnClicked:(NSInteger)index{
    
    for (UIViewController *VC in self.navigationController.viewControllers) {
        if ([VC isKindOfClass:[XZXMineTVC class]]) {
            [self.navigationController popToViewController:VC animated:YES];
        }
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)rightButtonItemOnClicked:(NSInteger)index{
    
    XZXAp_Store_OneVC *one = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_OneVCID");
    one.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:one animated:YES];
}

- (IBAction)Updata_Action:(id)sender {
    
    XZXAp_Store_OneVC *vc = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_OneVCID");
    [self.navigationController pushViewController:vc animated:YES];
}
@end
