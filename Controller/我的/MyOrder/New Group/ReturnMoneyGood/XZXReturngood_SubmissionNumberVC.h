//
//  XZXReturngood_SubmissionNumberVC.h
//  BigMarket
//
//  Created by RedSky on 2019/7/11.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XHBaseViewController.h"
#import "XZXTextField.h"

NS_ASSUME_NONNULL_BEGIN


@interface CompanyListModel : NSObject

@property (nonatomic,copy) NSString *eName;
@property (nonatomic,copy) NSString *id;
@end

@interface XZXReturngood_SubmissionNumberVC : XHBaseViewController

@property (weak, nonatomic) IBOutlet UIView *BigView;
@property (weak, nonatomic) IBOutlet XZXTextField *company_TF;
@property (weak, nonatomic) IBOutlet XZXTextField *orderNum_TF;
@property (weak, nonatomic) IBOutlet UIButton *SureBtn;

- (IBAction)Sure_Action:(id)sender;

@property (nonatomic,copy) NSString *orderId;//订单号
@end

NS_ASSUME_NONNULL_END
