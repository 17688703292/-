//
//  XZXMyBindBankVC.h
//  DoorLock
//
//  Created by RedSky on 2019/3/6.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZXMyBindBankVC : XHBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *Input_name;
@property (weak, nonatomic) IBOutlet UITextField *Input_BankNum;
@property (weak, nonatomic) IBOutlet UIButton *FinishBtn;
- (IBAction)Finish_Action:(id)sender;

@property (nonatomic,copy)void(^AddBankCarkSuccess)(void);
@end

NS_ASSUME_NONNULL_END
