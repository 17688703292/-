//
//  XZXAp_Store_Success.m
//  BigMarket
//
//  Created by RedSky on 2019/6/2.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXAp_Store_Success.h"
#import "XZXAp_Store_uploadFile.h"
#import "XZXMineTVC.H"

@interface XZXAp_Store_Success ()

@property (nonatomic,copy) NSString *dowmloadStr;

@end

@implementation XZXAp_Store_Success

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"审核成功";
    self.uploadBtn.cornerRadius = 15.0;
    // Do any additional setup after loading the view.
    self.urlStr.userInteractionEnabled = YES;
    self.productNum.text = [NSString stringWithFormat:@"产品编号：%@",self.productNumStr];
    [XHNetworking xh_postWithoutSuccess:[NSString stringWithFormat:@"%@manufacturer/uplodeFile",Store_ServiceIP] parameters:@{} success:^(XHResponse *responseObject) {
        
        if (responseObject.code == 200) {
            self.dowmloadStr = responseObject.data;
            self.urlStr.attributedText = [NSString changestringArray:@[@"合同下载链接\n",responseObject.data] colorArray:@[[UIColor lightGrayColor],[UIColor blueColor]] fontArray:@[@"17.0",@"15.0"]];
        }
    }];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapUlr)];
    [self.urlStr addGestureRecognizer:tap];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)tapUlr{
    
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.dowmloadStr] options:@{} completionHandler:^(BOOL success) {
        
    }];
}
-(void)leftButtonItemOnClicked:(NSInteger)index{
    
    for (UIViewController *VC in self.navigationController.viewControllers) {
        if ([VC isKindOfClass:[XZXMineTVC class]]) {
            [self.navigationController popToViewController:VC animated:YES];
        }
    }
}

- (IBAction)DownLoad_Action:(id)sender {

   

}


- (IBAction)upload_Action:(id)sender {
    
    XZXAp_Store_uploadFile *one = kStoryboradController(@"ApplicationStore", @"XZXAp_Store_uploadFileID");
    one.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:one animated:YES];
}
@end
