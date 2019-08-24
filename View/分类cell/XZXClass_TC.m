//
//  XZXClass_TC.m
//  Slumbers
//
//  Created by RedSky on 2019/3/19.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XZXClass_TC.h"

@implementation XZXClass_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.name.layer.masksToBounds = true;
    self.name.layer.cornerRadius  = 70*0.5/2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(XZXClass_leftModel *)Model{
    
    self.backgroundColor = kBackgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.name.text = Model.gcName;
    self.name.backgroundColor = [UIColor clearColor];
    self.name.textColor = kBlack;
}

@end
