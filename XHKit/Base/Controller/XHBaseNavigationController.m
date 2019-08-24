//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "XHBaseNavigationController.h"
#import "XHMacro.h"

@interface XHBaseNavigationController ()

@end

@implementation XHBaseNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        [self setupDefault];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setupDefault {
    self.navigationBar.barTintColor = kConfig(XHNavigationColor);
    self.navigationBar.tintColor = kConfig(XHNavigationColor);
    self.navigationBar.translucent = false;
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: kConfig(XHNavigationTitleColor), NSFontAttributeName: kConfig(XHNavigationTitleFont)}];
}

@end
