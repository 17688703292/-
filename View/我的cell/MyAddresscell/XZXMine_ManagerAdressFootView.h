//
//  XZXMine_ManagerAdressFootView.h
//  Slumbers
//
//  Created by RedSky on 2018/12/27.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XZXMine_ManagerAdressFootView;
@protocol XZXMine_ManagerAdressFootViewDelegate<NSObject>

-(void)SelectAddress_Action:(XZXMine_ManagerAdressFootView *)View;

-(void)EditAddress_Action:(XZXMine_ManagerAdressFootView *)View;

-(void)DelectAdress_Action:(XZXMine_ManagerAdressFootView *)View;
@end

@interface XZXMine_ManagerAdressFootView : UIView
@property (weak, nonatomic) IBOutlet UIButton *SelctAddress_Btn;
- (IBAction)SelectAddress_Action:(id)sender;
- (IBAction)EditAddress_Action:(id)sender;
- (IBAction)DelectAdress_Action:(id)sender;
@property (nonatomic,weak)id <XZXMine_ManagerAdressFootViewDelegate>delegate;

@end
