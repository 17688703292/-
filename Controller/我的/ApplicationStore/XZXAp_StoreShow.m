//
//  XZXAp_StoreShow.m
//  BigMarket
//
//  Created by RedSky on 2019/6/15.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXAp_StoreShow.h"
#import "XZXAp_Store_Success.h"
#import "XZXAp_Store_TwoVC.h"
#import "XZXStoreVC.h"
#import "XZXMineTVC.h"


@interface XZXAp_StoreShow ()

@end

@implementation XZXAp_StoreShow

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"店家";
    self.store_name.text = self.storeNameStr;
    self.storeImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enterStore)];
    [self.storeImage addGestureRecognizer:tap];
#if 0
    if (self.VC_type == upload_message) {
     
        [self addRightItemWithTitle:@"上传资质" titleColor:[UIColor whiteColor]];

    }else if (self.VC_type == upload_contract){
        
        [self addRightItemWithTitle:@"上传合同" titleColor:[UIColor whiteColor]];
        
    }else if (self.VC_type == Finally){
        
        [self addRightItemWithTitle:@"上传资质" titleColor:[UIColor whiteColor]];
        self.storeImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enterStore)];
        [self.storeImage addGestureRecognizer:tap];
    }
#endif
}

-(void)enterStore{
    
    
    XZXStoreVC *VC = kStoryboradController(@"Store", @"XZXStoreVCID");
    VC.hidesBottomBarWhenPushed = YES;
    VC.storeId = self.storeId;
    [self.navigationController pushViewController:VC animated:YES];
    
}

-(void)leftButtonItemOnClicked:(NSInteger)index{

    for (UIViewController *VC in self.navigationController.viewControllers) {
        if ([VC isKindOfClass:[XZXMineTVC class]]) {
            [self.navigationController popToViewController:VC animated:YES];
        }
    }
}

-(void)rightButtonItemOnClicked:(NSInteger)index{
    
    
    if (self.VC_type == upload_message ||
        self.VC_type == Finally) {
        
       
        //成功，上传厂家资质
        XZXAp_Store_TwoVC *one = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_TwoVCID");
        one.hidesBottomBarWhenPushed = YES;
        one.storeId = self.storeId;
      
        [self.navigationController pushViewController:one animated:YES];
    }else if (self.VC_type == upload_contract){
        
    
        XZXAp_Store_Success *succsee = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_SuccessID");
        succsee.productNumStr = self.productNum;
        [self.navigationController pushViewController:succsee animated:YES];
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

@end
