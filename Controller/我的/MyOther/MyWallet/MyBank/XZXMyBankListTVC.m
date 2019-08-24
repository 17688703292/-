//
//  XZXMyBankListTVC.m
//  DoorLock
//
//  Created by RedSky on 2019/3/5.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMyBankListTVC.h"
#import "XZXMyBindBankVC.h"

#import "XZXMyBankListCell.h"
@interface XZXMyBankListTVC ()

@end

@implementation XZXMyBankListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"银行卡";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXMyBankListCell" bundle:nil] forCellReuseIdentifier:@"XZXMyBankListCellID"];
    [self GetInformation];
}

-(void)GetInformation{
    
    [XHNetworking xh_postWithoutSuccess:@"wallet/searchCard" parameters:@{@"userId":@(kUser.member_id),@"memberId":@(kUser.member_id)} success:^(XHResponse *responseObject) {
                                                                          
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArray.count == indexPath.section) {
        return 60;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count + 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.dataArray.count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        cell.imageView.image = [UIImage imageNamed:@"tianjiayinhangka"];
        cell.textLabel.text  = @"添加银行卡";
        cell.textLabel.textColor = [UIColor grayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{

        
        XZXMyBankListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMyBankListCellID" forIndexPath:indexPath];
        cell.Content.attributedText = [NSString changestringArray:@[@"平安银行\n\n储蓄卡\n\n**** **** **** **** 4504"] colorArray:@[[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor]] fontArray:@[@"17",@"14",@"20"]];
        cell.Content.numberOfLines = 0;
        cell.backgroundColor = [UIColor colorWithHexString:@"#fdcf72"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.dataArray.count) {
     
        XZXMyBindBankVC *VC = kStoryboradController(@"Bank", @"XZXMyBindBankVCID");
        VC.AddBankCarkSuccess = ^{
        
            [self GetInformation];
        };
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}

@end


