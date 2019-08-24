//
//  AppDelegate.m
//  BigMarket
//
//  Created by RedSky on 2019/3/20.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "AppDelegate.h"
#import "XZXLoginVC.h"
#import "XZXHomepageTVC.h"
#import "XZXClassVC.h"
#import "XZXShopCarListVC.h"
#import "XZXMineTVC.h"
#import <Bugly/Bugly.h>
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "XHLaunchAd.h"
#import "XZXPayResultVC.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<WXApiDelegate,JPUSHRegisterDelegate,UITabBarControllerDelegate>

@property (nonatomic,strong)UILabel *AppLunchTitle;

@property (nonatomic,strong) NSTimer *LoadIntroducePic_time;
@property (nonatomic,assign) NSInteger LoadIntroducePic_second;
@property (nonatomic,strong) UIImageView *LoadIntroducePic_Image;
@property (nonatomic,strong) UILabel *LoadIntroducePic_label;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    NSLog(@"%@", [[NSBundle mainBundle] pathForAuxiliaryExecutable:@""]);
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoadIntroducePic) name:@"LoadIntroducePic" object:nil];
    
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchScreen];

    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = 8;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"ios_qidongye.gif";
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    imageAdconfiguration.GIFImageCycleOnce = NO;
    //网络图片缓存机制(只对网络图片有效)
    imageAdconfiguration.imageOption = XHLaunchAdImageRefreshCached;
    //图片填充模式
    imageAdconfiguration.contentMode = ShowFinishAnimateFadein;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    // imageAdconfiguration.openModel = @"http://www.it7090.com";
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateNone;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeRoundProgressTime;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;

    //设置要添加的子视图(可选)
    //imageAdconfiguration.subViews = ...

    self.AppLunchTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreenHeight - 30, kScreenWidth, 20)];
    self.AppLunchTitle.backgroundColor = [UIColor clearColor];
    self.AppLunchTitle.textColor = [UIColor whiteColor];
    self.AppLunchTitle.textAlignment = NSTextAlignmentCenter;
    imageAdconfiguration.subViews = @[self.AppLunchTitle];

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    self.AppLunchTitle.text = [NSString stringWithFormat:@"V %@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];

#if 0
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(animationLabel) object:nil];
    
      [thread start];
    
     //初始化字符串，为我们最后显示内容
#endif
    

    //显示图片开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
    
    [self.window makeKeyAndVisible];
    [self setupKeyboardManager];
    [self GetUserInformation];
    
    [self initRootViewController];
    [Bugly startWithAppId:@"ff974fe948"];
    [WXApi registerApp:@"wx5a456d7e0d49db12"];

    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    [JPUSHService setupWithOption:launchOptions appKey:@"f679d6dfaaeaf197f96de187"
                          channel:@"App Store"
                 apsForProduction:1
            advertisingIdentifier:nil];

    return YES;
}


/**
 *  广告显示完成
 */
-(void)xhLaunchShowFinish:(XHLaunchAd *)launchAd
{
    
    if (kUser.token.length) {
        //如果已经登陆，展示新功能
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadIntroducePic" object:nil];
    }
  
    NSLog(@"广告显示完成");
    
}
//线程的代码体，执行休眠

-(void)animationLabel

{
    NSString *content = @"新系统门户致辞 \n\n 一群人\n一个平台\n一种新模式\n一个伟大梦想\n一个信念中国梦\n振兴民族互联网\n成就更多平凡人\n倡导消费国贸\n荣耀民族品牌\n打开财富之门\n您注定由消费者转变为消费商";
    
        for (int i=0; i<content.length; i++) {
        
                //每次给Label显示的文字是从最前边到i+1个

                [self performSelectorOnMainThread:@selector(refreshUI:) withObject:[content substringWithRange:NSMakeRange(0, ++i)]  waitUntilDone:YES];
        
                [NSThread sleepForTimeInterval:0.08];
        
            }
    
    
}

//执行主线程修改UI

-(void)refreshUI:(NSString *)contentStr

{
    
     self.AppLunchTitle.text = contentStr;
    
}

- (void)setupKeyboardManager {
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
}

- (void)initRootViewController {

    if (kUser.token.length) {
   
        self.window.rootViewController = self.tabBarController;
    } else {
        

        XZXLoginVC *loginVC = kStoryboradController(@"Login", @"XZXLoginVCID");
        XHBaseNavigationController *loginNav = [[XHBaseNavigationController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController = loginNav;

    }
}

- (CYLTabBarController *)tabBarController {
    if (!_tabBarController) {
        
        
        //首页
        XZXHomepageTVC *homepageTVC    = kStoryboradController(@"Homepage", @"XZXHomepageTVCID");
        XHBaseNavigationController *homepageNav = [[XHBaseNavigationController alloc] initWithRootViewController:homepageTVC];
        NSDictionary *homepageDict = @{CYLTabBarItemTitle : @"首页",
                                       CYLTabBarItemImage : @"shouye_weixuanzhong",
                                       CYLTabBarItemSelectedImage : @"shouye_xuanzhong",};
        
        // 分类
        XZXClassVC *ClassTVC    = kStoryboradController(@"Class", @"XZXClassVCID");
        XHBaseNavigationController *ClassNav = [[XHBaseNavigationController alloc] initWithRootViewController:ClassTVC];
        NSDictionary *ClassDict = @{CYLTabBarItemTitle : @"分类",
                                    CYLTabBarItemImage : @"fenlei_weixuanzhong",
                                    CYLTabBarItemSelectedImage : @"fenlei_xuanzhong",};
        
        // 购物车
        XZXShopCarListVC *ShopCarTVC    = kStoryboradController(@"ShopCar", @"XZXShopCarListVCID");
        XHBaseNavigationController *ShopCarNav = [[XHBaseNavigationController alloc] initWithRootViewController:ShopCarTVC];
        NSDictionary *ShopCarDict = @{CYLTabBarItemTitle : @"购物车",
                                      CYLTabBarItemImage : @"gouwuche_weixuanzhong",
                                      CYLTabBarItemSelectedImage : @"gouwuche_xuanzhong",};
        // 我的
        XZXMineTVC *mineTVC    = kStoryboradController(@"Mine", @"XZXMineTVCID");
        XHBaseNavigationController *mineNav = [[XHBaseNavigationController alloc] initWithRootViewController:mineTVC];
        NSDictionary *mineDict = @{CYLTabBarItemTitle : @"我的",
                                   CYLTabBarItemImage : @"wode_weixuanzhong",
                                   CYLTabBarItemSelectedImage : @"wode_xuanzhong",};
        
        NSArray *controllers = @[homepageNav,ClassNav,ShopCarNav,mineNav];
        NSArray *items       = @[homepageDict,ClassDict,ShopCarDict,mineDict];
        
        self.tabBarController = [[CYLTabBarController alloc]initWithViewControllers:controllers tabBarItemsAttributes:items];
        self.tabBarController.delegate = self;
        //self.tabBarController = [[CYLTabBarController alloc] initWithViewControllers:controllers tabBarItemsAttributes:items imageInsets:UIEdgeInsetsMake(-5, 0, 0, 0) titlePositionAdjustment:UIOffsetZero];
        UITabBarItem *item = [UITabBarItem appearance];
        [item setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13], NSForegroundColorAttributeName: kGray} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13], NSForegroundColorAttributeName: kThemeColor} forState:UIControlStateSelected];
    }
    return _tabBarController;
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    
    if (tabBarController.selectedIndex == 0) {
        /**
         回到分类首页
         */
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReturnFisrtClass" object:nil];
    }
}
//
//-(void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control{
//
//
//    if ([control isEqual:[XZXHomepageTVC class]]) {
//        /**
//         回到分类首页
//         */
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReturnFisrtClass" object:nil];
//    }
//}

- (void)GetUserInformation{
    
    
    [kUser GetInfo:[UserDefault objectForKey:UserInfo_default]];
    [JPUSHService setAlias:[NSString stringWithFormat:@"%ld",kUser.member_id] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    NSLog(@"%@",iAlias);
                    if (iResCode == 0) {
                            NSLog(@"添加别名成功");
                        }
                } seq:1];
}

- (void)saveUserInformation:(NSDictionary *)Info{
    
    NSMutableDictionary *mudic = [NSMutableDictionary dictionaryWithDictionary:Info];
    for (NSString *key in [mudic allKeys]) {
        if ([[mudic valueForKey:key] isKindOfClass:[NSNull class]]) {
            
            [mudic setValue:@"" forKey:key];
        }
    }
    
    [UserDefault setObject:mudic forKey:UserInfo_default];
    [UserDefault synchronize];
    
}
- (void)RemoveUserInformation{
    
    [kUser cleanInfo];
    [UserDefault removeObjectForKey:UserInfo_default];
    [UserDefault synchronize];
    self.tabBarController = nil;
    [self initRootViewController];
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    if (iResCode == 0) {
                            NSLog(@"删除别名成功");
                        }
                } seq:1];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 支付
-(void) onReq:(BaseReq*)reqonReq{
    
    //[WXApi sendResp:@""];
}

-(void) onResp:(BaseResp*)resp{
    
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp *response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:kPaySuccessNotification object:@"0"];
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
    }
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    [WXApi handleOpenURL:url delegate:self];
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kPaySuccessNotification object:resultDic];
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    [WXApi handleOpenURL:url delegate:self];
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kPaySuccessNotification object:resultDic];
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}


-(void)LoadIntroducePic{
    
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = false;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LoadIntroducePic" object:nil];
    self.LoadIntroducePic_Image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xinyemian"]];
    self.LoadIntroducePic_Image.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.LoadIntroducePic_Image.backgroundColor = [UIColor orangeColor];
    self.LoadIntroducePic_Image.contentMode = UIViewContentModeScaleAspectFill;
    [[UIApplication sharedApplication].keyWindow addSubview:self.LoadIntroducePic_Image];
    self.LoadIntroducePic_second = 1;
    self.LoadIntroducePic_label = [[UILabel alloc]init];
    [self.LoadIntroducePic_Image addSubview:self.LoadIntroducePic_label];
    [self.LoadIntroducePic_label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.LoadIntroducePic_Image.mas_right).offset(-10);
        make.top.mas_equalTo(self.LoadIntroducePic_Image.mas_top).offset(64);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [UIView transitionWithView:_window duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        self.LoadIntroducePic_Image.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
    self.LoadIntroducePic_label.textAlignment = NSTextAlignmentCenter;
    self.LoadIntroducePic_label.cornerRadius = 20;
    self.LoadIntroducePic_label.layer.borderColor = [UIColor whiteColor].CGColor;
    self.LoadIntroducePic_label.textColor = [UIColor whiteColor];
    self.LoadIntroducePic_label.layer.borderWidth = 3.0;
    self.LoadIntroducePic_label.text = [NSString stringWithFormat:@"%ld",(long)self.LoadIntroducePic_second];
    self.LoadIntroducePic_time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(HidenLoadIntroducePic) userInfo:nil repeats:YES];
    
}

-(void)HidenLoadIntroducePic{
    
    --self.LoadIntroducePic_second;
    if (self.LoadIntroducePic_second <= 0) {
        
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled = true;
        [UIView transitionWithView:_window duration:1 options:UIViewAnimationOptionTransitionNone animations:^{
            self.LoadIntroducePic_Image.alpha = 0;
        } completion:^(BOOL finished) {
            [self.LoadIntroducePic_Image removeFromSuperview];
        }];
        [self.LoadIntroducePic_time invalidate];
        self.LoadIntroducePic_time = nil;
    }else{
        
        self.LoadIntroducePic_label.text = [NSString stringWithFormat:@"%ld",(long)self.LoadIntroducePic_second];
    }
    
}
@end
