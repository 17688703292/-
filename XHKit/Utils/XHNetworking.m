//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "XHNetworking.h"
#import "MBProgressHUD+XHBlock.h"
#import "AppDelegate.h"
#import <objc/runtime.h>
#import "XHMacro.h"

@implementation XHNetworking

+ (instancetype)defaultNetworking {
    static XHNetworking *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[XHNetworking alloc] init];
            instance.successImage = kConfig(XHResponseSuccessImage);
            instance.errorImage = kConfig(XHResponseErrorImage);
        }
    });
    return instance;
}

+ (void)xh_postWithSuccess:(NSString *)path
                parameters:(NSDictionary *)parameters
                   success:(void (^)(XHResponse *responseObject))success {
    [self xh_requestPath:path parameters:parameters requestType:POST showIndicator:YES showSuccess:YES showError:YES errorResponse:NO response:success];
}

+ (void)xh_postWithoutSuccess:(NSString *)path
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(XHResponse *responseObject))success {
    [self xh_requestPath:path parameters:parameters requestType:POST showIndicator:YES showSuccess:NO showError:YES errorResponse:NO response:success];
}

+ (void)xh_postAlwaysWithResponse:(NSString *)path
                       parameters:(NSDictionary *)parameters
                    showIndicator:(BOOL)showIndicator
                         response:(void(^)(XHResponse *responseObject))response {
    [self xh_requestAlwaysWithResponse:path parameters:parameters requestType:POST showIndicator:showIndicator response:response];
}

+ (void)xh_requestAlwaysWithResponse:(NSString *)path
                          parameters:(NSDictionary *)parameters
                         requestType:(NetworkingType)requestType
                       showIndicator:(BOOL)showIndicator
                            response:(void(^)(XHResponse *responseObject))response {
    [self xh_requestPath:path parameters:parameters requestType:requestType showIndicator:showIndicator showSuccess:NO showError:YES errorResponse:YES response:response];
}

+ (void)xh_requestPath:(NSString *)path
            parameters:(NSDictionary *)parameters
           requestType:(NetworkingType)requestType
         showIndicator:(BOOL)showIndicator
           showSuccess:(BOOL)showSuccess
             showError:(BOOL)showError
         errorResponse:(BOOL)errorResponse
              response:(void (^)(XHResponse *responseObject))response {
    [[XHNetworking defaultNetworking] xh_requestPath:path parameters:parameters requestType:requestType showIndicator:showIndicator showSuccess:showSuccess showError:showError errorResponse:errorResponse response:response];
}

+ (void)xh_uploadPath:(NSString *)path
           parameters:(NSDictionary *)parameters
          requestType:(NetworkingType)requestType
        progressStyle:(NetworkingPorgressStyle)progressStyle
             fileData:(void(^)(id<AFMultipartFormData>  _Nonnull formData))fileData
              success:(void (^)(XHResponse *responseObject))success {
    
    MBProgressHUD *hud = [MBProgressHUD xh_showAnnularDeterminateHudWithMessage:@"正在上传" toView:[UIApplication sharedApplication].keyWindow];
    //显示状态栏小菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    //初始化请求地址
    NSString* urlPath = @"";
    if ([path containsString:@"://"]) {
        /**    非后台网址 */
        urlPath = path;
    } else {
        /**    后台API */
        urlPath = [NSString stringWithFormat:@"%@%@", kConfig(XHBaseUrl), path];
    }
    NSLog(@"\nURL = %@ \n请求参数 = %@", urlPath, parameters);
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    /**    网络请求超时 */
    sessionManager.requestSerializer.timeoutInterval = 60;
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json",@"text/javascript", nil];
    
    [sessionManager POST:urlPath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (fileData) fileData(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        hud.progressObject = uploadProgress;
        if (uploadProgress.finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:true];
            });
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[XHNetworking defaultNetworking] validateResponse:responseObject showSuccess:YES showError:YES errorResponse:NO response:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:true];
        });
        [[XHNetworking defaultNetworking] validateError:error response:success];
    }];
}

+ (void)xh_downloadUrl:(NSString *)urlString
            toDocument:(NSString *)docName
           requestType:(NetworkingType)requestType
         progressStyle:(NetworkingPorgressStyle)progressStyle
     completionHandler:(void(^)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error))completion {
    MBProgressHUD *hud = nil;
    NSString *message = @"正在下载";
    
    if (progressStyle == NetworkingPorgressStyleDeterminate) {
        hud = [MBProgressHUD xh_showDeterminateHudWithMessage:message toView:[UIApplication sharedApplication].keyWindow];
    }
    else if (progressStyle == NetworkingPorgressStyleAnnularDeterminate) {
        hud = [MBProgressHUD xh_showAnnularDeterminateHudWithMessage:message toView:[UIApplication sharedApplication].keyWindow];
    }
    else {
        hud = [MBProgressHUD xh_showDeterminateHorizontalBarHudWithMessage:message toView:[UIApplication sharedApplication].keyWindow];
    }
    //显示状态栏小菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSessionDownloadTask *downloadTask =
    [manager downloadTaskWithRequest:request
                            progress:^(NSProgress * _Nonnull downloadProgress) {
                                // 下载进度
                                hud.progressObject = downloadProgress;
                                if (downloadProgress.finished) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [hud hideAnimated:true];
                                    });
                                }
                            }
                         destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                             //保存的文件路径
                             NSString *fileName = [urlString lastPathComponent];
                             NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                             NSString *basePath = [NSString stringWithFormat:@"%@/%@",docDir, docName];
                             NSString *fullPath = [[self getSavePathWithBasePath:basePath] stringByAppendingPathComponent:fileName];
                             return [NSURL fileURLWithPath:fullPath];
                         }
                   completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                       // 隐藏菊花
                       [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                       [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
                       if (error) {
                           // 失败
                           UIImage *errorImage = [XHNetworking defaultNetworking].errorImage;
                           [MBProgressHUD xh_showImageHud:errorImage withMessage:@"下载失败" toView:[UIApplication sharedApplication].keyWindow comletion:nil];
                       }
                       else {
                           // 成功
                           UIImage *successImage = [XHNetworking defaultNetworking].successImage;
                           [MBProgressHUD xh_showImageHud:successImage withMessage:@"下载完成" toView:[UIApplication sharedApplication].keyWindow comletion:^{
                               if (completion) {
                                   completion(response, filePath, error);
                               }
                           }];
                       }
                   }];
    [downloadTask resume];
}

//获取保存目录
+ (NSString *)getSavePathWithBasePath:(NSString *)basePath
{
    NSString *document = basePath;
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:document isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:document withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return document;
}

#pragma mark - OBJ
- (void)xh_postWithSuccess:(NSString *)path
                parameters:(NSDictionary *)parameters
                   success:(void (^)(XHResponse *responseObject))success {
    [self xh_requestPath:path parameters:parameters requestType:POST showIndicator:YES showSuccess:YES showError:YES errorResponse:NO response:success];
}

- (void)xh_postWithoutSuccess:(NSString *)path
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(XHResponse *responseObject))success {
    [self xh_requestPath:path parameters:parameters requestType:POST showIndicator:YES showSuccess:NO showError:YES errorResponse:NO response:success];
}

- (void)xh_postAlwaysWithResponse:(NSString *)path
                       parameters:(NSDictionary *)parameters
                    showIndicator:(BOOL)showIndicator
                         response:(void(^)(XHResponse *responseObject))response {
    [self xh_requestAlwaysWithResponse:path parameters:parameters requestType:POST showIndicator:showIndicator response:response];
}

- (void)xh_requestAlwaysWithResponse:(NSString *)path
                          parameters:(NSDictionary *)parameters
                         requestType:(NetworkingType)requestType
                       showIndicator:(BOOL)showIndicator
                            response:(void(^)(XHResponse *responseObject))response {
    [self xh_requestPath:path parameters:parameters requestType:requestType showIndicator:showIndicator showSuccess:NO showError:YES errorResponse:YES response:response];
}

- (void)xh_requestPath:(NSString *)path
            parameters:(NSDictionary *)parameters
           requestType:(NetworkingType)requestType
         showIndicator:(BOOL)showIndicator
           showSuccess:(BOOL)showSuccess
             showError:(BOOL)showError
         errorResponse:(BOOL)errorResponse
              response:(void (^)(XHResponse *responseObject))response {
    //显示状态栏小菊花
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    if (showIndicator) {
        if (self.loadingStyle == NetworkingLoadingStyleStyleGif) {
            NSArray *images = self.gifImages ? self.gifImages : [XHNetworking defaultNetworking].gifImages;
            [MBProgressHUD xh_showGifHudWithImages:images toView:[UIApplication sharedApplication].keyWindow];
        } else {
            //[MBProgressHUD showHUDAddedTo:[XHTools currentViewController].view animated:YES];
            [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        }
    }
    //初始化请求地址
    NSString* urlPath = @"";
    if ([path containsString:@":"]) {
        urlPath = path; /** 非后台网址 */
    } else {
        //4个8
            // urlPath = [NSString stringWithFormat:@"%@%@", kConfig(XHBaseUrl), path]; /** 正式服API */
           //  urlPath = [NSString stringWithFormat:@"%@%@", TestServiceIP, path];/** 测试服API */
              urlPath = [NSString stringWithFormat:@"%@%@", LocalIP, path]; /** 本地API */
    }
    NSLog(@"\nURL = %@ \n请求参数 = %@", urlPath, parameters);
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.requestSerializer.timeoutInterval = 10;
    //sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json",@"text/javascript", nil];
    
    if (requestType == GET) {
        [sessionManager GET:urlPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self validateResponse:responseObject showSuccess:showSuccess showError:showError errorResponse:errorResponse response:response];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self validateError:error response:response];
        }];
    }
    else {
        [sessionManager POST:urlPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self validateResponse:responseObject showSuccess:showSuccess showError:showError errorResponse:errorResponse response:response];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self validateError:error response:response];
        }];
    }
}

#pragma mark - Validate

// 验证
- (void)validateResponse:(id)responseObject showSuccess:(BOOL)showSuccess showError:(BOOL)showError errorResponse:(BOOL)errorResponse response:(void (^)(XHResponse *))response {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:LoadViewResult object:nil userInfo:@{@"Result":@"Success"}];
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    
    NSLog(@"\nresponseObject = %@", responseObject);
    // 响应对象
    XHResponse *obj = [XHResponse new];
    obj.code = [responseObject[@"code"] integerValue];
    obj.message = responseObject[@"errorMsg"];
    obj.list = responseObject[@"list"];
    obj.data = responseObject[@"data"];
    
    switch ([responseObject[@"code"] integerValue]) {
        case 200: { // 成功
            if (showSuccess) {
                
                if (self.alertStyle == NetworkingAlertSyleImage) {
                    UIImage *successImage = self.successImage ? self.successImage : [XHNetworking defaultNetworking].successImage;
                    [MBProgressHUD xh_showImageHud:successImage withMessage:obj.message toView:[UIApplication sharedApplication].keyWindow comletion:^{
                        
                    }];
                }
                else
                {
                    [MBProgressHUD xh_showHudWithMessage:obj.message toView:[UIApplication sharedApplication].keyWindow completion:^{
                 
                    }];
                }
            }
            if (response) response(obj);
        }
            break;
        case 300: { // token失效
            if (self.alertStyle == NetworkingAlertSyleImage) {
                UIImage *errorImage = self.errorImage ? self.errorImage : [XHNetworking defaultNetworking].errorImage;
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TokenInvalid" object:nil];
                
                
            }
            else {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TokenInvalid" object:nil];
                
            }
            if (self.tokenFailure) self.tokenFailure();
        }
            break;
        case 400:
        {
            
            [UIAlertController xh_AlertWithTitle:@"温馨提醒" message:@"登录已过期，请重新登录" doneCompletionOneBtn:^{
                
                [kAppDelegate RemoveUserInformation];
                [kAppDelegate initRootViewController];
            }];
        }
            break;
        default: {
            if (showError) {
                if (self.alertStyle == NetworkingAlertSyleImage) {
                    UIImage *errorImage = self.errorImage ? self.errorImage : [XHNetworking defaultNetworking].errorImage;
                    
                    [MBProgressHUD xh_showImageHud:errorImage withMessage:obj.message toView:[UIApplication sharedApplication].keyWindow comletion:nil];
                }
                else {
                    [MBProgressHUD xh_showHudWithMessage:obj.message toView:[UIApplication sharedApplication].keyWindow completion:nil];
                }
            }
            if (errorResponse) {
                if (response) response(obj);
            }
        }
            break;
    }
}

- (void)validateError:(NSError *)error response:(void (^)(XHResponse *))response {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    NSLog(@"网络请求失败Error: %@", error);
    if (response) response(nil);
    [[NSNotificationCenter defaultCenter] postNotificationName:LoadViewResult object:nil userInfo:@{@"Result":@"Fair"}];
    
    [MBProgressHUD xh_showHudWithMessage:@"请求失败，请查看网络" toView:[UIApplication sharedApplication].keyWindow completion:^{
        
    }];
}

@end


@implementation XHResponse

- (NSString *)description {
    return [NSString stringWithFormat:@"\n%@", [self yy_modelDescription]];
}

@end
