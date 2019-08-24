//
//  XZXMine_ScoreListCell3.m
//  BigMarket
//
//  Created by RedSky on 2019/6/6.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMine_ScoreListCell3.h"

@implementation XZXMine_ScoreListCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectDate_Action:(id)sender {

    if ([self.delegate respondsToSelector:@selector(selectDate_ActionDelegate)]) {
        [self.delegate selectDate_ActionDelegate];
    }
}
@end
