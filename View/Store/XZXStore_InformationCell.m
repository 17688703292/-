//
//  XZXStore_InformationCell.m
//  BigMarket
//
//  Created by RedSky on 2019/5/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXStore_InformationCell.h"

@implementation XZXStore_InformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.storeImage.cornerRadius = kScreenWidth*0.48*0.3*0.5;
    self.favority.cornerRadius = 15.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)favority_Action:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(DidSelectfavority)]) {
        
        [self.delegate DidSelectfavority];
    }
}
@end
