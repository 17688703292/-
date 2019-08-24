//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "XHExtern.h"
#import "XHTools.h"
#import <YYModel.h>

typedef NS_ENUM(NSInteger, NetworkingType) {
    POST    = 1,
    GET     = 2,
    HEAD    = 3,
    PUT     = 4,
    PATCH   = 5,
    DELETE  = 6
};

typedef NS_ENUM(NSInteger, NetworkingLoadingStyle) {
    NetworkingLoadingStyleIndicator, ///< 菊花样式
    NetworkingLoadingStyleStyleGif,  ///< gif图片样式
};

typedef NS_ENUM (NSInteger, NetworkingAlertSyle) {
    NetworkingAlertSyleText,  ///< 仅文字样式
    NetworkingAlertSyleImage, ///< 图片加文字样式
};

typedef NS_ENUM(NSInteger, NetworkingPorgressStyle) {
    NetworkingPorgressStyleHorizontalBar,      ///< 横向进度条样式
    NetworkingPorgressStyleDeterminate,        ///< 外圈内圈进度条样式
    NetworkingPorgressStyleAnnularDeterminate, ///< 圆形进度条样式
};

@interface XHResponse : NSObject

@property (nonatomic, assign) NSInteger code;     ///< 状态
@property (nonatomic, copy) NSString *message;    ///< 提示信息
@property (nonatomic, strong) NSArray *list;      ///< 列表数据
@property (nonatomic, strong) id data; ///< 对象数据

@end

@interface XHNetworking : NSObject

@property (nonatomic, assign) NetworkingLoadingStyle loadingStyle; ///< 等待指示器样式
@property (nonatomic, assign) NetworkingAlertSyle alertStyle;      ///< 提醒样式

@property (nonatomic, strong) UIImage *successImage; ///< 成功样式图片
@property (nonatomic, strong) UIImage *errorImage;   ///< 错误样式图片
@property (nonatomic, strong) NSArray *gifImages;    ///< gif样式图片数组

@property (nonatomic, copy) void (^tokenFailure)(void);

#pragma mark - Static Methods
/** 单例入口 */
+ (instancetype)defaultNetworking;

/**
 *  POST 显示成功和错误 (验证成功才返回数据)
 *
 *  @param path         API
 *  @param parameters   参数
 *  @param success      成功回调
 */
+ (void)xh_postWithSuccess:(NSString *)path
                parameters:(NSDictionary *)parameters
                   success:(void (^)(XHResponse *responseObject))success;

/**
 *  POST 只显示错误 (验证成功才返回数据)
 *
 *  @param path         API
 *  @param parameters   参数
 *  @param success      成功回调
 */
+ (void)xh_postWithoutSuccess:(NSString *)path
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(XHResponse *responseObject))success;


/**
 * POST 只显示错误 (都会返回数据)
 *
 * @param path          API
 * @param parameters    参数
 * @param showIndicator 是否显示HUD
 * @param response      回调block
 */
+ (void)xh_postAlwaysWithResponse:(NSString *)path
                       parameters:(NSDictionary *)parameters
                    showIndicator:(BOOL)showIndicator
                         response:(void(^)(XHResponse *responseObject))response;

/**
 * 自定义请求类型 只显示错误 (都会返回数据)
 *
 * @param path          API
 * @param parameters    参数
 * @param requestType   请求类型
 * @param showIndicator 是否显示HUD
 * @param response      回调
 */
+ (void)xh_requestAlwaysWithResponse:(NSString *)path
                          parameters:(NSDictionary *)parameters
                         requestType:(NetworkingType)requestType
                       showIndicator:(BOOL)showIndicator
                            response:(void(^)(XHResponse *responseObject))response;

/**
 * 自定义
 *
 * @param path          API
 * @param parameters    参数
 * @param requestType   请求类型
 * @param showIndicator 是否显示HUD
 * @param showSuccess   是否显示成功
 * @param showError     是否显示错误
 * @param errorResponse 错误是否回调
 * @param response      回调block
 */
+ (void)xh_requestPath:(NSString *)path
            parameters:(NSDictionary *)parameters
           requestType:(NetworkingType)requestType
         showIndicator:(BOOL)showIndicator
           showSuccess:(BOOL)showSuccess
             showError:(BOOL)showError
         errorResponse:(BOOL)errorResponse
              response:(void (^)(XHResponse *responseObject))response;

/**
 * 上传文件
 *
 * @param path          API
 * @param parameters    参数
 * @param requestType   请求类型
 * @param progressStyle 进度条样式
 * @param fileData          文件上传回调
 * @param success       回调
 */
+ (void)xh_uploadPath:(NSString *)path
           parameters:(NSDictionary *)parameters
          requestType:(NetworkingType)requestType
        progressStyle:(NetworkingPorgressStyle)progressStyle
             fileData:(void(^)(id<AFMultipartFormData>  _Nonnull formData))fileData
              success:(void (^)(XHResponse *responseObject))success;


/**
 * 下载文件
 *
 * @param urlString     API
 * @param docName       保存Documemt文件夹名
 * @param requestType   请求类型
 * @param progressStyle 进度条样式
 * @param completion    回调
 */
+ (void)xh_downloadUrl:(NSString *)urlString
            toDocument:(NSString *)docName
           requestType:(NetworkingType)requestType
         progressStyle:(NetworkingPorgressStyle)progressStyle
     completionHandler:(void(^)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error))completion;

#pragma mark - OBJ Methods

/**
 *  POST 显示成功和错误 (验证成功才返回数据)
 *
 *  @param path         API
 *  @param parameters   参数
 *  @param success      成功回调
 */
- (void)xh_postWithSuccess:(NSString *)path
                parameters:(NSDictionary *)parameters
                   success:(void (^)(XHResponse *responseObject))success;

/**
 *  POST 只显示错误 (验证成功才返回数据)
 *
 *  @param path         API
 *  @param parameters   参数
 *  @param success      成功回调
 */
- (void)xh_postWithoutSuccess:(NSString *)path
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(XHResponse *responseObject))success;


/**
 * POST 只显示错误 (都会返回数据)
 *
 * @param path          API
 * @param parameters    参数
 * @param showIndicator 是否显示HUD
 * @param response      回调block
 */
- (void)xh_postAlwaysWithResponse:(NSString *)path
                       parameters:(NSDictionary *)parameters
                    showIndicator:(BOOL)showIndicator
                         response:(void(^)(XHResponse *responseObject))response;

/**
 * 自定义请求类型 只显示错误 (都会返回数据)
 *
 * @param path          API
 * @param parameters    参数
 * @param requestType   请求类型
 * @param showIndicator 是否显示HUD
 * @param response      回调
 */
- (void)xh_requestAlwaysWithResponse:(NSString *)path
                          parameters:(NSDictionary *)parameters
                         requestType:(NetworkingType)requestType
                       showIndicator:(BOOL)showIndicator
                            response:(void(^)(XHResponse *responseObject))response;

/**
 * 自定义
 *
 * @param path          API
 * @param parameters    参数
 * @param requestType   请求类型
 * @param showIndicator 是否显示HUD
 * @param showSuccess   是否显示成功
 * @param showError     是否显示错误
 * @param errorResponse 错误是否回调
 * @param response      回调block
 */
- (void)xh_requestPath:(NSString *)path
            parameters:(NSDictionary *)parameters
           requestType:(NetworkingType)requestType
         showIndicator:(BOOL)showIndicator
           showSuccess:(BOOL)showSuccess
             showError:(BOOL)showError
         errorResponse:(BOOL)errorResponse
              response:(void (^)(XHResponse *responseObject))response;

@end

