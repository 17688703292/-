//
//  XZXSearchHeadView.m
//  BigMarket
//
//  Created by RedSky on 2019/6/12.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXSearchHeadView.h"

@implementation XZXSearchHeadView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kBackgroundColor;
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-60, self.frame.size.height)];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.numberOfLines = 0;
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.textColor = [UIColor grayColor];
        [self addSubview:_titleLab];
   
        
        _operationBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-60, 0, 60, self.frame.size.height)];
         [_operationBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
        [self addSubview:_operationBtn];
        [_operationBtn addTarget:self action:@selector(operation_Action) forControlEvents:UIControlEventTouchDown];
        
    }
    return self;
}

-(void)operation_Action{
    
    if (self.OperationBlcok) {
        self.OperationBlcok();
    }
}
@end
