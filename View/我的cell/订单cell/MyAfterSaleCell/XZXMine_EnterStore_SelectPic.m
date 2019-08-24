//
//  XZXMine_EnterStore_SelectPic.m
//  Slumbers
//
//  Created by RedSky on 2019/2/18.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XZXMine_EnterStore_SelectPic.h"

@implementation XZXMine_EnterStore_SelectPic

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)DelectImage_Action:(id)sender {
    
    XZXMine_EnterStore_SelectPic *cell = (XZXMine_EnterStore_SelectPic *)[[sender superview] superview];
    if (self.DelectPicBlock) {
        self.DelectPicBlock(cell);
    }
}
@end
