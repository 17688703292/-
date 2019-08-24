//
//  CSTextField.m
//  GuTangFinance
//
//  Created by 朱学鸿 on 2018/3/19.
//  Copyright © 2018年 com.carson. All rights reserved.
//

#import "CSTextField.h"

@implementation CSTextField

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 0, self.height-1);
    CGContextAddLineToPoint(ctx, self.width, self.height-1);
    if (self.lineColor == nil) {
        self.lineColor = [UIColor groupTableViewBackgroundColor];
    }
    [self.lineColor setStroke];
    CGContextStrokePath(ctx);
}

@end
