//
//  XHTagsView.h
//  XHKitDemo
//
//  Created by zhu on 2016/10/2.
//  Copyright © 2016 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+XHConstructor.h"

typedef NS_ENUM(NSInteger, XHTagStyle) {
    XHTagStyleNormal,
    XHTagStyleARC,
    XHTagStyleColorful,
    XHTagStyleBorder,
    XHTagStyleARCBorder,
    XHTagStyleRank,
};

@class XHTagsView;
@protocol XHTagsViewDelegate <NSObject>

- (void)tagView:(XHTagsView *)tagView didClickedTag:(NSString *)text atIndex:(NSInteger)index;

@end

@interface XHTagsView : UIView

- (instancetype)initWithFrame:(CGRect)frame withTags:(NSArray *)tags;

@property (nonatomic, strong) UIFont *tagsFont;
@property (nonatomic, assign) XHTagStyle tagStyle;
@property (nonatomic, weak) id <XHTagsViewDelegate> delegate;

@end
