//
//  XZXAp_VC.m
//  BigMarket
//
//  Created by RedSky on 2019/6/2.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXAp_VC.h"
#import "XZXAp_Store_OneVC.h"
@interface XZXAp_VC ()

@end

@implementation XZXAp_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"申请开店";
    [self addRightItemWithTitle:@"申请" titleColor:[UIColor whiteColor]];
    self.view.backgroundColor  = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
}

-(void)rightButtonItemOnClicked:(NSInteger)index{
    
    XZXAp_Store_OneVC *one = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_OneVCID");
    one.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:one animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
