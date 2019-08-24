//
//  XZXReturngood_SubmissionNumberVC.m
//  BigMarket
//
//  Created by RedSky on 2019/7/11.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXReturngood_SubmissionNumberVC.h"
#import "XZXReturnAfterSale.h"
#import "ZWPullMenuView.h"

@interface XZXReturngood_SubmissionNumberVC ()<UITextFieldDelegate>

@property (nonatomic,strong)ZWPullMenuView *menuView;//下拉菜单
@property (nonatomic,strong) NSMutableArray *company_dataSource;
@property (nonatomic,strong) CompanyListModel *companyModel;

@end

@implementation CompanyListModel


@end

@implementation XZXReturngood_SubmissionNumberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.company_TF.delegate = self;
    self.orderNum_TF.delegate = self;
    self.title = @"提交快递单号";
    [self.company_TF creatLeftTitle:@"快递公司"];
    [self.orderNum_TF creatLeftTitle:@"快递单号"];
    self.SureBtn.cornerRadius = 5.0;
    self.SureBtn.backgroundColor = kThemeColor;
}


-(NSMutableArray *)company_dataSource{
    if (!_company_dataSource) {
        _company_dataSource = [NSMutableArray array];
    }
    return _company_dataSource;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:self.company_TF]) {
        
        
        [XHNetworking xh_postWithoutSuccess:[NSString stringWithFormat:@"%@express/select",Store_ServiceIP] parameters:@{} success:^(XHResponse *responseObject) {
            
            __weak __typeof(self) weakSelf = self;
            if ([responseObject.data isKindOfClass:[NSArray class]]) {
                NSMutableArray *nameArray = [NSMutableArray array];
                for (NSDictionary *dic in responseObject.data) {
                    [weakSelf.company_dataSource addObject:[CompanyListModel yy_modelWithJSON:dic]];
                    [nameArray addObject:[dic valueForKey:@"eName"]];
                }
             
                weakSelf.menuView = [ZWPullMenuView pullMenuAnchorView:weakSelf.BigView  titleArray:nameArray];
                
                
                weakSelf.menuView.blockSelectedMenu = ^(NSInteger menuRow) {
                    NSString *name = [nameArray objectAtIndex:menuRow];
                    for (CompanyListModel *model in weakSelf.company_dataSource) {
                        if([model.eName isEqualToString:name]){
                            
                            weakSelf.companyModel = model;
                            weakSelf.company_TF.text = model.eName;
                        }
                    }
                    
                };
            }
        }];
    
        return false;
    }else{
        
        
        return true;
    }
}



- (IBAction)Sure_Action:(id)sender {
    
    self.companyModel = [CompanyListModel new];
    if ([self.company_TF.text length] != 0 &&
        [self.orderNum_TF.text length] != 0) {
        
    
        [XHNetworking xh_postWithoutSuccess:@"refundReturn/exchangeGoods" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"orderId":self.orderId,@"expressId":self.companyModel.id,@"invoiceNo":self.orderNum_TF.text} success:^(XHResponse *responseObject) {
         
            
            for (UIViewController *VC in self.navigationController.viewControllers) {
                if ([VC isKindOfClass:[XZXReturnAfterSale class]]) {
                    
                    [self.navigationController popToViewController:VC animated:YES];
                }
            }
        }];
    }
}
@end
