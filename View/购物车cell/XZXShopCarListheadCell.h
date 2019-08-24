//
//  XZXShopCarListheadCell.h
//  BigMarket
//
//  Created by RedSky on 2019/4/23.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZXShopCarListheadCellDelegate <NSObject>

-(void)DidSelectStor:(NSInteger )section;
-(void)EnterStore:(UITapGestureRecognizer *)tap;
@end

@interface XZXShopCarListheadCell : UIView
@property (weak, nonatomic) IBOutlet UIButton *SelectBtn;
- (IBAction)Select_Action:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *statuContent;

@property (nonatomic,weak)id<XZXShopCarListheadCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
