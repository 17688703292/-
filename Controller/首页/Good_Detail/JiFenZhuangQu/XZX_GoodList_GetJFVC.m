//
//  XZX_GoodList_GetJFVC.m
//  BigMarket
//
//  Created by RedSky on 2019/8/8.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZX_GoodList_GetJFVC.h"

@interface XZX_GoodList_GetJFVC ()
@property (weak, nonatomic) IBOutlet UIImageView *BackImage;

@end

@implementation XZX_GoodList_GetJFVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"赚积分";
    NSString *imageName = @"jifen_4";;
    if (is_iPhone4 == YES) {
        
        imageName = @"jife_1";
    }else if (is_iPhone5 == YES){
        
           imageName = @"jifen_2";
    }else if (is_iPhone6 == YES){
        
           imageName = @"jifen_4";
    }else if (is_iPhone6P == YES){
        
           imageName = @"jifen_3";
    }else if (is_iPhoneX == YES){
        
           imageName = @"jifen_5";
    }else if (is_iPhoneXS_Max == YES){
        
           imageName = @"jifen_6";
    }else if (is_iPhoneXR == YES){
        
           imageName = @"jifen_7";
    }
    self.BackImage.image = [UIImage imageNamed:imageName];
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
     
                           forBarPosition:UIBarPositionAny
     
                               barMetrics:UIBarMetricsDefault];   // 设置navigationBar的颜色为透明的
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.navigationController.navigationBar setTranslucent:YES];
   // [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]]
}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent = false;
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
