//
//  XZXWebViewController.m
//  Slumbers
//
//  Created by RedSky on 2018/12/22.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXWebViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKUserScript.h>
#import <WebKit/WKUserContentController.h>
#import <WebKit/WKWebViewConfiguration.h>

@interface XZXWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@end

@implementation XZXWebViewController
{
    
     WKWebView *downWebview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (![self.TopTitle isEqualToString:@"详情"]) {
   
         [self addRightItemWithIconName:@"pingfen_weixuanzhong"];
    }
        self.navigationItem.title = _TopTitle;
   
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    
    downWebview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) configuration:wkWebConfig];
    
   // downWebview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    downWebview.navigationDelegate = self;
    downWebview.UIDelegate = self;

    NSURL* url = [NSURL URLWithString:self.url];
    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    [downWebview loadRequest:request];
    [downWebview goBack];
    [downWebview goForward];
    [self.view addSubview:downWebview];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
