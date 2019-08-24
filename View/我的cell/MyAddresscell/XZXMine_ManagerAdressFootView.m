//
//  XZXMine_ManagerAdressFootView.m
//  Slumbers
//
//  Created by RedSky on 2018/12/27.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXMine_ManagerAdressFootView.h"

@implementation XZXMine_ManagerAdressFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)SelectAddress_Action:(id)sender {
    XZXMine_ManagerAdressFootView *View = (XZXMine_ManagerAdressFootView *)[sender superview];
    if ([self.delegate respondsToSelector:@selector(SelectAddress_Action:)]) {
        
        [self.delegate SelectAddress_Action:View];
    }
}

- (IBAction)EditAddress_Action:(id)sender {
    
   XZXMine_ManagerAdressFootView *View = (XZXMine_ManagerAdressFootView *)[sender superview];
    if ([self.delegate respondsToSelector:@selector(EditAddress_Action:)]) {
        
        [self.delegate EditAddress_Action:View];
    }
}

- (IBAction)DelectAdress_Action:(id)sender {

   XZXMine_ManagerAdressFootView *View = (XZXMine_ManagerAdressFootView *)[sender superview];
    if ([self.delegate respondsToSelector:@selector(DelectAdress_Action:)]) {
        
        [self.delegate DelectAdress_Action:View];
    }
}


@end
