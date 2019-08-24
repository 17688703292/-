//
//  XZXMine_goodCell.m
//  BigMarket
//
//  Created by RedSky on 2019/4/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMine_goodCell.h"

@implementation XZXMine_goodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMyModel:(XZXMineOrderGoodDetailModel *)MyModel{
    [self.goodImage sd_setImageWithURL:kImageUrl(@"",MyModel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
    self.goodName.text = MyModel.goodsName;
    self.goodName.numberOfLines = 0;
    self.goodContent.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:MyModel.goodsPrice]],[NSString stringWithFormat:@"\n积分：%@",MyModel.goodsScore]] colorArray:@[kThemeColor,[UIColor lightGrayColor]] fontArray:@[@"17.0",@"14.0"]];
}
@end
