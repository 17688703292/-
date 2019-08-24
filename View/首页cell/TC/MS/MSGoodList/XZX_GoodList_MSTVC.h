//
//  XZX_GoodList_MSTVC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/14.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XZX_Good_MSModel.h"
NS_ASSUME_NONNULL_BEGIN

@class XZX_GoodList_MSTVC;

@protocol XZX_GoodList_MSTVCDelegate <NSObject>

-(void)DidSelectGood:(XZX_GoodList_MSTVC *)cell;

@end


@interface XZX_GoodList_MSTVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *HeadInage;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *SureBtn;

- (IBAction)Sure_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIProgressView *progressStau;
@property (weak, nonatomic) IBOutlet UILabel *progressStauLabel;

@property (nonatomic,weak) id<XZX_GoodList_MSTVCDelegate>delegate;

@property (nonatomic,strong)XZX_Good_MSModel *MyModel;
@end

NS_ASSUME_NONNULL_END
