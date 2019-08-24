//
//  XZXHome_ActivityHeadTC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/10.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZXHomeModel.h"
#import "XZXHome_goodListModel.h"

NS_ASSUME_NONNULL_BEGIN

@class XZXHome_ActivityHeadTC;

@protocol XZXHome_ActivityHeadTCDelegate <NSObject>

-(void)DidSelectViewMoreActivity:(XZXHome_ActivityHeadTC *)cell;

@end


@interface XZXHome_ActivityHeadTC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *ViewMoreBtn;
- (IBAction)View_Action:(id)sender;

-(void)ReloadUI:(XZXHomeModel *)MyModel section:(NSInteger )section;

@property (nonatomic,weak)id<XZXHome_ActivityHeadTCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
