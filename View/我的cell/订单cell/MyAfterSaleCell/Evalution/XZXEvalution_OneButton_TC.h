//
//  XZXEvalution_OneButton_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/4/30.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XZXEvalution_OneButton_TC;
@protocol XZXEvalution_OneButton_TCDelegate <NSObject>

-(void)Sure_Action:(XZXEvalution_OneButton_TC *)cell;

@end
@interface XZXEvalution_OneButton_TC : UITableViewCell

- (IBAction)Sure_Action:(id)sender;

@property (nonatomic,weak)id<XZXEvalution_OneButton_TCDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
