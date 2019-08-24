//
//  XZXMineFootCC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/24.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMineFootCC.h"

@implementation XZXMineFootCC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)More_Action:(id)sender {
    
    
    XZXMineFootCC *cell = (XZXMineFootCC *)[[sender superview] superview];
    if ([self.delegate respondsToSelector:@selector(MoreAction:)]) {
        [self.delegate MoreAction:cell];
    }
}
@end
