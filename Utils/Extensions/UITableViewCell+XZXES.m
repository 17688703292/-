//
//  UITableViewCell+XZXES.m
//  Slumbers
//
//  Created by zhu on 2018/12/8.
//  Copyright © 2018 zhu. All rights reserved.
//

#import "UITableViewCell+XZXES.h"
#import <objc/runtime.h>

NSString const *UITableViewCellModelKey = @"UITableViewCellModelKey";

@implementation UITableViewCell (XZXES)

- (void)setModel:(id)model {
    objc_setAssociatedObject(self, &UITableViewCellModelKey, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)model {
    return objc_getAssociatedObject(self, &UITableViewCellModelKey);
}

@end
