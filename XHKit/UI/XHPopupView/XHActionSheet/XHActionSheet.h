//
//  XHActionSheet.h
//  XHKitDemo
//
//  Created by zhu on 2016/11/15.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHActionSheet : UIViewController

+ (void)showWithTitle:(NSArray <NSString *>*)titles presentController:(UIViewController *)controller selectedCallback:(void(^)(NSInteger index))callback;

@end
