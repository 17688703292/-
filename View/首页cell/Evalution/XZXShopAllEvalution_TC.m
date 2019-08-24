//
//  XZXShopAllEvalution_TC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/6.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXShopAllEvalution_TC.h"

@implementation XZXShopAllEvalution_TC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImage.cornerRadius = self.headImage.frame.size.height/2.0;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_Image:)];
    [self.content_Image addGestureRecognizer:tap];
    self.content_Image.userInteractionEnabled = YES;
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
        
        if ([MyModel.gevalFrommemberImage isKindOfClass:[NSString class]]) {
            
            [self.headImage sd_setImageWithURL:kImageUrl(@"", MyModel.gevalFrommemberImage) placeholderImage:[UIImage imageNamed:LoadPic]];
        }else{
            
            self.headImage.image = [UIImage imageNamed:LoadPic];
        }
        
        self.name.text = MyModel.gevalFrommembername;
    }
    
    self.content.text = MyModel.gevalContent;
    self.time.text = MyModel.gevalAddtime;
    if ([MyModel.gevalImage isKindOfClass:[NSString class]]) {
          [self.content_Image sd_setImageWithURL:[NSURL URLWithString:[MyModel.gevalImage containsString:@"://"] ? MyModel.gevalImage : [NSString stringWithFormat:@"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/%@",MyModel.gevalImage]] placeholderImage:[UIImage imageNamed:LoadPic]];
        self.content_Image.hidden = false;
        [self.content_Image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
        }];
    }else{
        [self.content_Image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        self.content_Image.hidden = true;
    }
}

-(void)tap_Image:(UITapGestureRecognizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(View_MaxPic:)]) {
        [self.delegate View_MaxPic:tap];
    }
}

@end
