//
//  XZXClass_CC.m
//  Slumbers
//
//  Created by RedSky on 2019/3/19.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XZXClass_CC.h"

@implementation XZXClass_CC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.GoodImage.cornerRadius = 5.0;
   
}

-(void)setModel:(XZXClass_rightModel *)Model{
    
    self.name.text = Model.gcName;
    //null闪退
    //[self.GoodImage sd_setImageWithURL:kImageUrl(Model.gcThumb) placeholderImage:[UIImage imageNamed:LoadPic]];
    self.GoodImage.cornerRadius = 5.0;
    [self.GoodImage sd_setImageWithURL:kImageUrl(@"",Model.gcThumb) placeholderImage:[UIImage imageNamed:LoadPic]];
}
@end
