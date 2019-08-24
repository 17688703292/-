//
//  XZXMyAgentGoodListCCCollectionViewCell.h
//  BigMarket
//
//  Created by RedSky on 2019/5/23.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXMyAgentGoodListModel.h"

NS_ASSUME_NONNULL_BEGIN

@class XZXMyAgentGoodListCCCollectionViewCell;
@protocol XZXMyAgentGoodListCCCollectionViewCellDelegate <NSObject>

-(void)DidselectMoreBtn:(XZXMyAgentGoodListCCCollectionViewCell *)cell;

@end

@interface XZXMyAgentGoodListCCCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *tagStr;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
- (IBAction)AddCar:(id)sender;

@property (nonatomic,strong)XZXMyAgentGoodListModel *MyModel;
@property (nonatomic,weak) id <XZXMyAgentGoodListCCCollectionViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
