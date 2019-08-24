//
//  XZXMyRechargeSuccessVC.m
//  DoorLock
//
//  Created by RedSky on 2019/3/5.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMyRechargeSuccessVC.h"

@interface XZXMyRechargeSuccessVC ()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)Back_Action:(id)sender;

@end

@implementation XZXMyRechargeSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"充值成功";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Back_Action:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
