//
//  XZXMineAgentVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/21.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMineAgentVC.h"
#import "LXCalender.h"
#import "XZXMineFootCVC.h"
#import "XZXWebViewController.h"
#import "QFDatePickerView.h"
#import "OtherViewController.h"

#import "XZXMine_ScoreListCell2.h"
#import "XZXMine_ScoreListCell3.h"
#import "XZXMine_ScoreListCell4.h"

@interface XZXMineAgentVC ()<UITableViewDataSource,UITableViewDelegate,XZXMine_ScoreListCell3Delegate,XZXMine_ScoreListCell2Delegate>

@property (nonatomic,strong) XZXMineAgentModel *MyModel;


@end

@implementation XZXMineAgentModel


@end

@implementation XZXMineAgentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"分红积分";
    
    self.CustomerTableView.cornerRadius = 5.0f;
    self.CustomerTableView.layer.borderWidth = 1;
    self.CustomerTableView.layer.borderColor = kBackgroundColor.CGColor;
    self.CustomerTableView.dataSource = self;
    self.CustomerTableView.delegate   = self;
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXMine_ScoreListCell2" bundle:nil] forCellReuseIdentifier:@"XZXMine_ScoreListCell2ID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXMine_ScoreListCell3" bundle:nil] forCellReuseIdentifier:@"XZXMine_ScoreListCell3ID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXMine_ScoreListCell4" bundle:nil] forCellReuseIdentifier:@"XZXMine_ScoreListCell4ID"];
    self.CustomerTableView.tableFooterView = [UIView new];
    self.CustomerTableView.backgroundColor = kBackgroundColor;
    [self GetInformation];
}


-(void)GetInformation{
    
    [XHNetworking xh_postWithoutSuccess:@"agent/getMyPacket" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
        
        
        if ([responseObject.data isKindOfClass:[NSDictionary class]]) {
            
            self.MyModel = [XZXMineAgentModel yy_modelWithJSON:responseObject.data];
            
            
            [self.CustomerTableView reloadData];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([self.MyModel.list isKindOfClass:[NSArray class]]) {
     
        return 3;
    }
    return 0;
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
        
        return kScreenWidth*0.872;
    }else if (indexPath.section == 1){
        
        return 100;
    }
    
    return 80;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        XZXMine_ScoreListCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMine_ScoreListCell2ID" forIndexPath:indexPath];
        
        cell.totalScore.attributedText = [NSString changestringArray:@[@"当前积分\n",[NSString stringWithFormat:@"%0.2f",[self.MyModel.agentAcore floatValue] + [self.MyModel.lowerLevelScore floatValue]]] colorArray:@[[UIColor whiteColor],[UIColor whiteColor]] fontArray:@[@"16",@"30"]];
        cell.ShareScoreLabel.attributedText = [NSString changestringArray:@[@"代理积分\n",self.MyModel.agentAcore,@"\n\n省代\n",[NSString stringWithFormat:@"%@",[self.MyModel.province valueForKey:@"map"]]] colorArray:@[[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor]] fontArray:@[@"14",@"20",@"14",@"20"]];
        
        cell.AgentLabel.attributedText = [NSString changestringArray:@[@"\n\n",@"",@"\n\n市代\n",[NSString stringWithFormat:@"%@",[self.MyModel.city valueForKey:@"map"]]] colorArray:@[[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor]] fontArray:@[@"14",@"20",@"14",@"20"]];
        
        
         cell.ExtensionLabel.attributedText = [NSString changestringArray:@[@"推广积分\n",self.MyModel.lowerLevelScore,@"\n\n县代\n",[NSString stringWithFormat:@"%@",[self.MyModel.area valueForKey:@"map"]]] colorArray:@[[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor]] fontArray:@[@"14",@"20",@"14",@"20"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ExplainBlock = ^{
          
            XZXWebViewController *webView = [XZXWebViewController new];
            webView.url = @"http://www.ydmall.xyz/admin/red_score";
            webView.TopTitle = @"积分说明";
            webView.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:webView animated:YES];
        };
        cell.RechargeBlock = ^{
            
            OtherViewController *VC = kStoryboradController(@"Login", @"OtherViewControllerID");
            VC.hidesBottomBarWhenPushed =  YES;
            VC.title = @"充值";
            VC.ImageStr = @"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789C36D9E46F4074ACFA577253994BA1E54.png";
            [self.navigationController pushViewController:VC animated:YES];
        };
        cell.CrashBlock = ^{
          
            OtherViewController *VC = kStoryboradController(@"Login", @"OtherViewControllerID");
            VC.hidesBottomBarWhenPushed =  YES;
            VC.title = @"提现";
            VC.ImageStr = @"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789D598DB41477844A8817DD56179C6E08A.png";
            [self.navigationController pushViewController:VC animated:YES];
        };
        cell.delegate = self;
        return cell;
    }else if (indexPath.section == 1){
        
        XZXMine_ScoreListCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMine_ScoreListCell3ID" forIndexPath:indexPath];
        cell.date.text = self.MyModel.date;
       
        cell.content.text = [NSString stringWithFormat:@"支出 ¥ %@   收入 ¥ %@",[NSString reviseString:self.MyModel.down],[NSString reviseString:self.MyModel.up]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }else{
        
        XZXMine_ScoreListCell4 *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMine_ScoreListCell4ID" forIndexPath:indexPath];
        NSDictionary *dic  = [self.MyModel.list objectAtIndex:indexPath.row];
        cell.content.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"%@\n",[dic valueForKey:@"note"]],[dic valueForKey:@"time"]] colorArray:@[[UIColor blackColor],[UIColor lightGrayColor]] fontArray:@[@"17.0",@"15.0"]];
        
        if ([[dic valueForKey:@"logType"] integerValue] == 0) {
            cell.scoreLabel.textColor = [UIColor blackColor];
            cell.scoreLabel.text = [NSString stringWithFormat:@"- %@",[dic valueForKey:@"balance"]];
        }else{
            cell.scoreLabel.textColor = kThemeColor;
            cell.scoreLabel.text = [NSString stringWithFormat:@"+ %@",[dic valueForKey:@"balance"]];
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
    
    NSLog(@"结果：%@",string);
    [XHNetworking xh_postWithSuccess:@"agent/getMyScoreDetail" parameters:@{@"agentTime":@([XHTools nsstringConversionNSDate:[NSString stringWithFormat:@"%@-01",string]]),@"token":kUser.token,@"userId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
        
        
        if ([responseObject.data isKindOfClass:[NSArray class]]) {
            self.MyModel.list = responseObject.data;
            self.MyModel.date = string;
            [self.CustomerTableView reloadData];
        }
        
    }];
}

-(void)DidSelectAgent:(NSInteger)index{
    

    NSInteger agID = 0;
    switch (index) {
        case 1:
            {
                agID = [[self.MyModel.province valueForKey:@"agId"] integerValue];
            }
            break;
        case 2:
        {
             agID = [[self.MyModel.city valueForKey:@"agId"] integerValue];
        }
            break;
        case 3:
        {
             agID = [[self.MyModel.area valueForKey:@"agId"] integerValue];
        }
            break;
        default:
            break;
    }

    XZXMineFootCVC *VC = [[XZXMineFootCVC alloc]initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    VC.hidesBottomBarWhenPushed = YES;
    VC.VC_type = VC_agentGoodList;
    VC.agId = agID;
    [self.navigationController pushViewController:VC animated:YES];
}

@end
