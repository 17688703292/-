//
//  XZXShopEvalution_TC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/5.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXShopEvalution_TC.h"

@implementation XZXShopEvalution_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.BackImage.cornerRadius = 5;
    self.headImage.cornerRadius = self.headImage.frame.size.height/2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMyModel:(XZXShopGoodEvalution_Model *)MyModel{
    
    if (MyModel.gevalIsanonymous == true) {
        
        self.headImage.image = [UIImage imageNamed:LoadPic];
        self.name.text = @"****";
    }else{
        
         [self.headImage sd_setImageWithURL:kImageUrl(@"",MyModel.gevalFrommemberImage) placeholderImage:[UIImage imageNamed:LoadPic]];
        self.name.text = MyModel.gevalFrommembername;
    }
    
    self.content.text = MyModel.gevalContent;
   
}
@end
