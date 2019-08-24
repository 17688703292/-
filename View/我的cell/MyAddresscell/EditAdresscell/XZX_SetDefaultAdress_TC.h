//
//  XZX_SetDefaultAdress_TC.h
//  BigMarket
//
//  Created by RedSky on 2019/4/13.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZX_SetDefaultAdressDelegate <NSObject>

-(void)SwitchAction_XZX_SetDefaultAdress_TC:(BOOL )IsDefault;

@end

@interface XZX_SetDefaultAdress_TC : UITableViewCell

@property (nonatomic,weak) id<XZX_SetDefaultAdressDelegate>delegate;

@property (weak, nonatomic) IBOutlet UISwitch *DefaultAddress_IsOn;
- (IBAction)switch_Action:(id)sender;
@end

NS_ASSUME_NONNULL_END
