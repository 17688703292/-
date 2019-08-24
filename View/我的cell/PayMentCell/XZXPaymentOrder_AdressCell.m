//
//  XZXPaymentOrder_AdressCell.m
//  Slumbers
//
//  Created by RedSky on 2019/2/22.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XZXPaymentOrder_AdressCell.h"

@implementation XZXPaymentOrder_AdressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setMyModel:(XZXMine_AreaListModel *)MyModel{
    NSString *receiver = [NSString string];
    if ([MyModel.trueName length] > 0) {
        
        receiver = [NSString stringWithFormat:@"收货人：%@ ",MyModel.trueName];
    }else if ([MyModel.receiver length] > 0){
        
        receiver = [NSString stringWithFormat:@"收货人：%@ ",MyModel.receiver];
    }else if ([MyModel.receiverName length] > 0){
        
        receiver = [NSString stringWithFormat:@"收货人：%@ ",MyModel.receiverName];
    }
  
    CGSize titlesize = [receiver sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]}];
    
    [self.Adress_name mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.Adress_image.mas_right).offset(10);
        make.width.mas_equalTo(titlesize.width);
        make.height.mas_equalTo(20);
    }];
    
    self.Adress_name.text = receiver;
    self.Adress_info.text = [NSString stringWithFormat:@"%@ %@\n",MyModel.areaInfo,MyModel.address];
    self.Adress_Tetelphone.text = MyModel.mobPhone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}

@end
