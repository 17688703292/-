//
//  XZXTransportCell.h
//  Slumbers
//
//  Created by RedSky on 2018/12/24.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZXTransportCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *statu;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *companyid;
@property (weak, nonatomic) IBOutlet UILabel *companyPhone;

@end
