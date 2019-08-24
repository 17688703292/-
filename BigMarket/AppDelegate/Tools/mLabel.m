//
//  mLabel.m
//  BigMarket
//
//  Created by RedSky on 2019/6/16.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "mLabel.h"

@implementation mLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressCellHandle:)];
        [self addGestureRecognizer:longPressGesture];
    }
    return self;
}


-(void)longPressCellHandle:(UILongPressGestureRecognizer *)gesture
{
    [self becomeFirstResponder];
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(menuCopyBtnPressed:)];
    
    menuController.menuItems = @[copyItem];
    
    [menuController setTargetRect:gesture.view.frame inView:gesture.view.superview];
    
    [menuController setMenuVisible:YES animated:YES];
    
    [UIMenuController sharedMenuController].menuItems=nil;
    
}


-(void)menuCopyBtnPressed:(UIMenuItem *)menuItem
{
    [UIPasteboard generalPasteboard].string = self.text;
    
}


-(BOOL)canBecomeFirstResponder

{
    return YES;
}


-(BOOL)canPerformAction:(SEL)action withSender:(id)sender

{
    if (action == @selector(menuCopyBtnPressed:)) {
        
        return YES;
    }
    return NO;
}

@end
