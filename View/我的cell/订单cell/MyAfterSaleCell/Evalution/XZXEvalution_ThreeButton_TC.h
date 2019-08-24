//
//  XZXEvalution_ThreeButton_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/4/30.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XZXEvalution_ThreeButton_TC;
@protocol XZXEvalution_ThreeButton_TCDelegate <NSObject>

-(void)selectEvalutionLevel:(NSInteger )level_t cell:(XZXEvalution_ThreeButton_TC *)cell;

@end

@interface XZXEvalution_ThreeButton_TC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *goodBtn;
- (IBAction)good_Action:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *MediumBtn;
- (IBAction)Medium_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *poorBtn;
- (IBAction)poor_Action:(id)sender;

@property (nonatomic,weak)id<XZXEvalution_ThreeButton_TCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
