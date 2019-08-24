//
//  XZXMine_ScoreList.m
//  BigMarket
//
//  Created by RedSky on 2019/4/25.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMine_ScoreList.h"
#import "XZXWebViewController.h"
#import "OtherViewController.h"
#import "XZX_GoodList_JFTV.h"

#import "XZXMine_ScoreListCell1.h"
#import "XZXMine_ScoreListCell3.h"
#import "XZXMine_ScoreListCell4.h"

#import "QFDatePickerView.h"
@interface XZXMine_ScoreList ()<UITableViewDelegate,UITableViewDataSource,XZXMine_ScoreListCell3Delegate>

@property (weak, nonatomic) IBOutlet UITableView *CustomerTableView;

@property (nonatomic,strong)XZXMine_ScoreModel *MyModel;



@property (nonatomic,strong)dispatch_queue_t ScoreListqueue;
@end

@implementation XZXMine_ScoreListModel

@end

@implementation XZXMine_ScoreModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"list": [XZXMine_ScoreListModel class]};
}

@end

@implementation XZXMine_ScoreList{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"积分";
    

    _ScoreListqueue = dispatch_queue_create("ScoreListqueue", DISPATCH_QUEUE_SERIAL);
    self.CustomerTableView.dataSource = self;
    self.CustomerTableView.delegate   = self;
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXMine_ScoreListCell1" bundle:nil] forCellReuseIdentifier:@"XZXMine_ScoreListCell1ID"];
     [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXMine_ScoreListCell3" bundle:nil] forCellReuseIdentifier:@"XZXMine_ScoreListCell3ID"];
     [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXMine_ScoreListCell4" bundle:nil] forCellReuseIdentifier:@"XZXMine_ScoreListCell4ID"];
    self.CustomerTableView.tableFooterView = [UIView new];
    
    [self GetInformation];
}


-(void)GetInformation{
    
    [XHNetworking xh_postWithoutSuccess:@"signIn/getBlueScoreDetail" parameters:@{@"memberId":@(kUser.member_id),@"token":kUser.token,@"userId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
       
        if (responseObject.code == 200 &&
            [responseObject.data isKindOfClass:[NSDictionary class]]) {
           
            dispatch_async(self->_ScoreListqueue, ^{
               
                

                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    self.MyModel = [XZXMine_ScoreModel yy_modelWithJSON:responseObject.data];
                    NSDateFormatter *dateFormatter_temp =[[NSDateFormatter alloc] init];
                    [dateFormatter_temp setDateFormat:@"yyyy-MM"];
                    self.MyModel.date =  [dateFormatter_temp stringFromDate:[NSDate date]];
                    [self.CustomerTableView reloadData];
                });
                
            });
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.MyModel.list.count == 0) {
        return 2;
    }
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }
    return self.MyModel.list.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return kScreenWidth*0.64;
    }else if (indexPath.section == 1){
        
        return 100;
    }
    
    return 80;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0) {
     
        XZXMine_ScoreListCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMine_ScoreListCell1ID" forIndexPath:indexPath];
        
        cell.totalScore.attributedText = [NSString changestringArray:@[@"当前积分\n",[NSString stringWithFormat:@"%0.2f",[self.MyModel.shareGoods floatValue] + [self.MyModel.buyGoodsScore floatValue] + [self.MyModel.signScore floatValue]]] colorArray:@[[UIColor whiteColor],[UIColor whiteColor]] fontArray:@[@"16",@"30"]];
        cell.ExtensionLabel.attributedText = [NSString changestringArray:@[@"推广\n",self.MyModel.shareGoods] colorArray:@[[UIColor whiteColor],[UIColor whiteColor]] fontArray:@[@"14",@"20"]];
        
        cell.consumeLabel.attributedText = [NSString changestringArray:@[@"消费\n",self.MyModel.buyGoodsScore] colorArray:@[[UIColor whiteColor],[UIColor whiteColor]] fontArray:@[@"14",@"20"]];
        
        
        cell.signLabel.attributedText = [NSString changestringArray:@[@"签到\n",self.MyModel.signScore] colorArray:@[[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor]] fontArray:@[@"14",@"20",@"14",@"20"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ViewProduceBlock = ^{
            
            XZXWebViewController *webView = [XZXWebViewController new];
            webView.url = @"http://www.ydmall.xyz/admin/blue_score";
            webView.TopTitle = @"积分说明";
            webView.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:webView animated:YES];
        };
        
        cell.BuyProductBlock = ^{
          
            XZX_GoodList_JFTV *VC = [[XZX_GoodList_JFTV alloc]initWithNibName:@"XZX_GoodList_JFTV" bundle:nil];
            VC.hidesBottomBarWhenPushed =  YES;
            [self.navigationController pushViewController:VC animated:YES];
        };
        return cell;
    }else if (indexPath.section == 1){
        
        XZXMine_ScoreListCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMine_ScoreListCell3ID" forIndexPath:indexPath];
        cell.date.text = self.MyModel.date;
//        cell.content.text = [NSString stringWithFormat:@"支出 ¥ %@   收入 ¥ %@",self.MyModel.down,self.MyModel.up];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }else{
        
        XZXMine_ScoreListCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMine_ScoreListCell4ID" forIndexPath:indexPath];
        XZXMine_ScoreListModel *Model  = [self.MyModel.list objectAtIndex:indexPath.row];
        cell.content.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%@\n\n",[Model.scoreDesc isKindOfClass:[NSString class]]?Model.scoreDesc:@""],Model.time] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"17.0",@"15.0"]];
        
        if ([Model.type integerValue] == 2) {
            cell.scoreLabel.textColor = [UIColor blackColor];
            cell.scoreLabel.text = [NSString stringWithFormat:@"- %@",Model.score];
        }else{
            cell.scoreLabel.textColor = kThemeColor;
             cell.scoreLabel.text = [NSString stringWithFormat:@"+ %@",Model.score];
        }
       
        return cell;
    }
}


-(void)selectDate_ActionDelegate{
    
    
    QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithSUperView:self.view response:^(NSString *str) {
        NSString *string = str;
        
        [self GetSelectDate:string];
    }];
    [datePickerView show];
}


-(void)GetSelectDate:(NSString *)string{
    
    
    [XHNetworking xh_postWithoutSuccess:@"signIn/getBlueScoreDetail" parameters:@{@"date":@([XHTools nsstringConversionNSDatehhmmss:[NSString stringWithFormat:@"%@-01 00:00:00",string]]),@"memberId":@(kUser.member_id),@"token":kUser.token,@"userId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
        
        if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
            self.MyModel = [XZXMine_ScoreModel yy_modelWithJSON:responseObject.data];
            self.MyModel.date = string;
            [self.CustomerTableView reloadData];
        }
    }];
}
@end
