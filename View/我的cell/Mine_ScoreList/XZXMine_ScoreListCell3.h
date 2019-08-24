//
//  XZXMine_ScoreListCell3.h
//  BigMarket
//
//  Created by RedSky on 2019/6/6.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZXMine_ScoreListCell3Delegate <NSObject>

-(void)selectDate_ActionDelegate;

@end

@interface XZXMine_ScoreListCell3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *content;
- (IBAction)selectDate_Action:(id)sender;

@property (nonatomic,weak)id<XZXMine_ScoreListCell3Delegate>delegate;
@end

NS_ASSUME_NONNULL_END
