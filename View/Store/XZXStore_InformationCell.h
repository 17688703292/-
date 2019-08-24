//
//  XZXStore_InformationCell.h
//  BigMarket
//
//  Created by RedSky on 2019/5/27.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZXStore_InformationCellDelegate <NSObject>

-(void)DidSelectfavority;

@end

@interface XZXStore_InformationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *storeImage;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *storeFans;

@property (weak, nonatomic) IBOutlet UIButton *favority;
- (IBAction)favority_Action:(id)sender;
@property (nonatomic,weak)id<XZXStore_InformationCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
