//
//  XZXAp_Product_updata.m
//  BigMarket
//
//  Created by RedSky on 2019/6/2.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXAp_Product_updata.h"
#import "XZXAp_VC.h"

@interface XZXAp_Product_updata ()

@end

@implementation XZXAp_Product_updata

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"添加对应的产品编号";
    self.uploadBtn.cornerRadius = 5.0;
    [self.productNmae creatLeftTitle:@"填写编号"];
    [self.productNum creatLeftTitle:@"填写名称"];
}



- (IBAction)Upload_Action:(id)sender {
    //    acCode
    //    acDescription
    
    if ([self.productNmae.text length] > 0 &&
        [self.productNum.text length] > 0) {
     

        
        [XHNetworking xh_postWithoutSuccess:[NSString stringWithFormat:@"%@agentCode/agentCode",Store_ServiceIP] parameters:@{@"acCode":self.productNum.text,@"acDescription":@""} success:^(XHResponse *responseObject) {
          
            
            if (responseObject.code == 200) {
                
                [XHNetworking xh_postWithoutSuccess:[NSString stringWithFormat:@"%@store/addStore",Store_ServiceIP] parameters:@{@"memberName":@(kUser.member_id),@"storeName":self.productNum.text,@"memberId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
                  
                    if (responseObject.code == 200) {
                        
                        [XHNetworking xh_postWithoutSuccess:[NSString stringWithFormat:@"%@store/selectByMemberId",Store_ServiceIP] parameters:@{@"memberId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
                            if (responseObject.code == 200) {
                                XZXAp_VC *vc = kStoryboradController(@"ApplicationStore", @"XZXAp_VCID");
                                [self.navigationController pushViewController:vc animated:YES];
                            }
                        }];
                    }
                    
                }];
            }
        }];
    }

}
@end
