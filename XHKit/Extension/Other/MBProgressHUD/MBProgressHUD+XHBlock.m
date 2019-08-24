//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "MBProgressHUD+XHBlock.h"
#import "XHHudManager.h"

@implementation MBProgressHUD (XHBlock)

+ (instancetype)xh_showHudToView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    [self setupHud:hud];
    hud.contentColor = [XHHudManager defaultManager].textColor;
    return hud;
}

+ (instancetype)xh_showHudWithMessage:(NSString *)message toView:(UIView *)view completion:(void (^)(void))completion {
    if (!message) {
        return nil;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    [self setupHud:hud];
    hud.label.text = [NSString stringWithFormat:@"%@",message];
    hud.label.numberOfLines = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([XHHudManager defaultManager].showInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
        [MBProgressHUD hideHUDForView:view animated:YES];
    });
    return hud;
}

+ (instancetype)xh_showToastHudWithMessage:(NSString *)message toView:(UIView *)view completion:(void (^)(void))completion {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    [self setupHud:hud];
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([XHHudManager defaultManager].showInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
        [MBProgressHUD hideHUDForView:view animated:YES];
    });
    return hud;
}

+ (instancetype)xh_showImageHud:(UIImage *)image withMessage:(NSString *)message toView:(UIView *)view comletion:(void (^)(void))completion {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.detailsLabel.text = [NSString stringWithFormat:@"\n%@", message];
    [self setupHud:hud];
    hud.square = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([XHHudManager defaultManager].showInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
        [MBProgressHUD hideHUDForView:view animated:YES];
    });
    return hud;
}

+ (instancetype)xh_showAnnularDeterminateHudWithMessage:(NSString *)message toView:(UIView *)view {

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    [self setupHud:hud];
    hud.label.text = [NSString stringWithFormat:@"\n%@",message];
    hud.label.numberOfLines = 0;
    hud.square = YES;
    hud.contentColor = [XHHudManager defaultManager].progressColor;
    return hud;
 
}

+ (instancetype)xh_showDeterminateHudWithMessage:(NSString *)message toView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    [self setupHud:hud];
    hud.label.text = [NSString stringWithFormat:@"\n%@",message];
    hud.label.numberOfLines = 0;
    hud.contentColor = [XHHudManager defaultManager].progressColor;
    hud.square = YES;
    return hud;
}

+ (instancetype)xh_showDeterminateHorizontalBarHudWithMessage:(NSString *)message toView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    [self setupHud:hud];
    hud.label.text = [NSString stringWithFormat:@"\n%@",message];
    hud.label.numberOfLines = 0;
    hud.contentColor = [XHHudManager defaultManager].progressColor;
    return hud;
}

+ (instancetype)xh_showGIFHudToView:(UIView *)view {
    return [self xh_showGifHudWithImages:[XHHudManager defaultManager].gifImages toView:view];
}

+ (instancetype)xh_showGifHudWithImages:(NSArray *)images toView:(UIView *)view {
    return [self xh_showGifHudWithImages:images toView:view backgroundColor:[UIColor clearColor]];
}

+ (instancetype)xh_showGifHudWithImages:(NSArray *)images toView:(UIView *)view backgroundColor:(UIColor *)backgroundColor {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundColor = backgroundColor;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.animationDuration = [XHHudManager defaultManager].animationDuration;
    imageView.animationImages = images;
    hud.customView = imageView;
    [imageView startAnimating];
    return hud;
}

+ (void)setupHud:(MBProgressHUD *)hud {
    hud.minSize = [XHHudManager defaultManager].minSize;
    hud.backgroundView.style = [XHHudManager defaultManager].backgroundStyle;
    hud.backgroundView.color = [XHHudManager defaultManager].backGroundColor;
    hud.backgroundView.blurEffectStyle = [XHHudManager defaultManager].backgroundBlurEffectStyle;
    hud.bezelView.style = [XHHudManager defaultManager].bezelStyle;
    hud.bezelView.blurEffectStyle = [XHHudManager defaultManager].bezelBlurEffectStyle;
    hud.bezelView.color = [XHHudManager defaultManager].bezelColor;
    hud.label.textColor = [XHHudManager defaultManager].textColor;
    hud.label.font = [XHHudManager defaultManager].font;
    hud.detailsLabel.font = [XHHudManager defaultManager].font;
    hud.detailsLabel.textColor = [XHHudManager defaultManager].textColor;
}

@end
