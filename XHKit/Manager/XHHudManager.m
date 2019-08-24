//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "XHHudManager.h"

@implementation XHHudManager

+ (instancetype)defaultManager {
    static XHHudManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[XHHudManager alloc] init];
            [manager defaultStyle];
        }
    });
    return manager;
}

- (void)defaultStyle {
    self.showInterval = 1.5;
    self.backgroundStyle = MBProgressHUDBackgroundStyleSolidColor;
    self.backgroundBlurEffectStyle = UIBlurEffectStyleExtraLight;
    self.backGroundColor = [UIColor clearColor];
    self.bezelStyle = MBProgressHUDBackgroundStyleSolidColor;
    self.bezelBlurEffectStyle = UIBlurEffectStyleExtraLight;
    self.bezelColor = [[UIColor grayColor] colorWithAlphaComponent:0.8f];
    self.progressColor = [UIColor whiteColor];
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:15.f];
    self.animationDuration = 0.2f;
}

- (void)setGifImageNames:(NSArray *)gifImageNames {
    _gifImageNames = gifImageNames;
    NSMutableArray *images = [NSMutableArray array];
    for (NSString *imageName in gifImageNames) {
        [images addObject:[UIImage imageNamed:imageName]];
    }
    self.gifImages = images;
}

@end
