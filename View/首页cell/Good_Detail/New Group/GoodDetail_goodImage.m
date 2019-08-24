//
//  GoodDetail_goodImage.m
//  BigMarket
//
//  Created by RedSky on 2019/4/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "GoodDetail_goodImage.h"

@implementation GoodDetail_goodImage

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   // self.good_image.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setPicString:(NSString *)picString
{
    _picString = picString;
    __weak typeof(self) strongSelf = self;
    
    [self.good_image sd_setImageWithURL:kImageUrl(@"", self.picString) placeholderImage:[UIImage imageNamed:LoadPic] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
         [strongSelf changeMaonryByImage:self.good_image.image];
    }];
    

}

-(void)changeMaonryByImage:(UIImage *)image
{
    if (image == nil) return;
    //自适应大小
    //    float showWidth = YGScreenWidth;
    float showHeight = image.size.height/image.size.width * kScreenWidth;
    [self.good_image mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(showHeight);
        [self layoutIfNeeded];
    }];
}
@end
