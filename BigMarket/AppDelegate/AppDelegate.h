//
//  AppDelegate.h
//  BigMarket
//
//  Created by RedSky on 2019/3/20.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) CYLTabBarController *tabBarController;

- (void)initRootViewController;
- (void)GetUserInformation;
- (void)saveUserInformation:(NSDictionary *)Info;
- (void)RemoveUserInformation;

@end

