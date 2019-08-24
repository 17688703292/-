//
//  XZXAp_Product_Fair.m
//  BigMarket
//
//  Created by RedSky on 2019/6/2.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXAp_Product_Fair.h"
#import "XZXAp_StoreShow.h"
#import "XZXMineTVC.h"


@interface XZXAp_Product_Fair ()

@end

@implementation XZXAp_Product_Fair

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"厂家资质审核";
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
- (IBAction)upload_Action:(id)sender {
    
    //重新上传厂家资质
    [XHNetworking xh_postWithoutSuccess:[NSString stringWithFormat:@"%@store/getStoreByMemberId",Store_ServiceIP] parameters:@{@"memberId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
        
        if (responseObject.code == 200) {
            
            XZXAp_StoreShow *show =kStoryboradController(@"ApplicationStore", @"XZXAp_StoreShowID");
            show.VC_type = upload_message;
            show.hidesBottomBarWhenPushed = YES;
            show.storeNameStr = [responseObject.data valueForKey:@"storeName"];
            show.storeId = [responseObject.data valueForKey:@"storeId"];
            [self.navigationController pushViewController:show animated:YES];
        }
    }];
}
@end
