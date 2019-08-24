//
//  XZXMine_MyOrderFootView.h
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XZXMine_MyOrderFootView;
@protocol XZXMine_MyOrderFootViewDelegate<NSObject>

-(void)MyOrder_LeftBtn:(XZXMine_MyOrderFootView *)view;

-(void)MyOrder_RightBtn:(XZXMine_MyOrderFootView *)view;
@end

@interface XZXMine_MyOrderFootView : UIView
@property (weak, nonatomic) IBOutlet UIView *Backview;
@property (weak, nonatomic) IBOutlet UIButton *LeftBtn;

- (IBAction)LeftBtn_Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *RightBtn;
- (IBAction)RightBtn_Action:(id)sender;
@property (nonatomic,weak)id <XZXMine_MyOrderFootViewDelegate>delegate;
@end
