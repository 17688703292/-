//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import "UIAlertController+XHBlock.h"
#import "XHTools.h"

@implementation UIAlertController (XHBlock)


+ (UIAlertController *)xh_AlertWithTitle:(NSString *)title message:(NSString *)message doneCompletionOneBtn:(void(^)(void))completion{
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    // 确定
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (completion) {
            completion();
        }
    }];
    [alertController addAction:doneAction];
    [doneAction setValue:[UIColor colorWithRed:36/255.0f green:140/255.0f blue:233/255.0f alpha:1] forKey:@"_titleTextColor"];
    [[XHTools currentViewController] presentViewController:alertController animated:YES completion:nil];
    return alertController;
    
}


+ (UIAlertController *)xh_AlertWithTitle:(NSString *)title message:(NSString *)message doneCompletion:(void (^)(void))completion {
    // 取消
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    [cancelAction setValue:[UIColor darkGrayColor] forKey:@"_titleTextColor"];
    // 确定
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (completion) {
            completion();
        }
    }];
    [alertController addAction:doneAction];
    [doneAction setValue:[UIColor colorWithRed:36/255.0f green:140/255.0f blue:233/255.0f alpha:1] forKey:@"_titleTextColor"];
    [[XHTools currentViewController] presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

+ (UIAlertController *)xh_AlertWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSArray *)titles clickCallback:(void (^)(NSInteger))callback {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < titles.count; i ++) {
        [alertController addAction:[UIAlertAction actionWithTitle:titles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (callback) {
                callback(i);
            }
        }]];
    }
    [[XHTools currentViewController] presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

@end
