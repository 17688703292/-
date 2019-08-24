//
//  OtherViewController.m
//  BigMarket
//
//  Created by RedSky on 2019/6/5.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "OtherViewController.h"
#import "UINavigationBar+Awesome.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    if ([self.ImageStr length] > 0) {
        
        if ([self.ImageStr containsString:@"http"]) {
            
            [self.BackImage sd_setImageWithURL:kImageUrl(@"", self.ImageStr) placeholderImage:[UIImage imageNamed:@"img_kaifazhong"]];
        }else{
            
            self.BackImage.image = [UIImage imageNamed:self.ImageStr];
        }
    }else{
        
        self.BackImage.image = [UIImage imageNamed:@"img_kaifazhong"];
    }
  
    self.content.text = [self.contentStr length] > 0 ? self.contentStr : @"敬请期待";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // self.navigationController.navigationBar.hidden = YES;
//
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//
//                           forBarPosition:UIBarPositionAny
//
//                               barMetrics:UIBarMetricsDefault];   // 设置navigationBar的颜色为透明的
//
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//
//    [self.navigationController.navigationBar setTranslucent:YES];
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];

}
-(void)viewWillDisappear:(BOOL)animated{
    
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.translucent = false;
//
}
@end
