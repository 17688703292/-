//
//  AutoScrollLabel.m
//  Slumbers
//
//  Created by RedSky on 2019/4/13.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "AutoScrollLabel.h"

@implementation AutoScrollLabel

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        [self commonInit];
    }
    return self;
    
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self commonInit];
    }
    return self;
}


- (void)commonInit {
    
    self.scrollSpeed = 80 ;
    self.pauseInterval = 3;
    
    self.scrollEnabled = NO ;
    
    self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    
    [self addSubview:self.textLabel];
    
}

- (void)startScrollIfNeed {
    [self.textLabel sizeToFit] ;
    self.contentSize = self.textLabel.bounds.size ;
    
    // 需要滚动
    if (self.textLabel.bounds.size.width>self.bounds.size.width) {
        [self animationScroll];
    }
    
    
}
- (void)animationScroll {
    
    self.contentOffset = CGPointMake(-self.bounds.size.width, 0);
    
    [UIView animateWithDuration:self.textLabel.frame.size.width/self.scrollSpeed delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.contentOffset = CGPointMake(self.textLabel.frame.size.width - self.bounds.size.width, 0);
        
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(animationScroll) withObject:nil afterDelay:self.pauseInterval];
        
    }];
    
    
}

@end
