//
//  XZXMineFootCC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/24.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XZXMineFootCC;
@protocol XZXMineFootCCDelegate <NSObject>

-(void)MoreAction:(XZXMineFootCC *)cell;

@end

@interface XZXMineFootCC : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *content;
- (IBAction)More_Action:(id)sender;

@property (nonatomic,weak)id<XZXMineFootCCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
