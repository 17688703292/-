//
//  XZXMineSignCell1.h
//  BigMarket
//
//  Created by RedSky on 2019/5/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZXMineSignCell1Delegate <NSObject>

-(void)DidSelectSign;

@end

@interface XZXMineSignCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Sign_backView;
@property (weak, nonatomic) IBOutlet UIImageView *Sign_backView2;
@property (weak, nonatomic) IBOutlet UILabel *Sign_content;

@property (nonatomic,weak)id<XZXMineSignCell1Delegate>delegate;
@end

NS_ASSUME_NONNULL_END
