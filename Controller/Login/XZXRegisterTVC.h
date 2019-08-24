//
//  XZXRegisterTVC.h
//  BigMarket
//
//  Created by RedSky on 2019/5/25.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseTableViewController.h"
#import "XZXTextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface  XZXRegisterTVC : XHBaseTableViewController
@property (weak, nonatomic) IBOutlet XZXTextField *accountTF;
@property (weak, nonatomic) IBOutlet XZXTextField *verifyCodeTF;
@property (weak, nonatomic) IBOutlet XZXTextField *userName;
@property (weak, nonatomic) IBOutlet XZXTextField *userIDCard;
@property (weak, nonatomic) IBOutlet XZXTextField *passwordTF;
@property (weak, nonatomic) IBOutlet XZXTextField *Invitation;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
- (IBAction)Done_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *InvitationImage;

@property (weak, nonatomic) IBOutlet UIButton *protocolBtn;

- (IBAction)protocol_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *protocolStr;

@end

NS_ASSUME_NONNULL_END
