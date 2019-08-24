//
//  XZXAp_Store_SelectStoreTypeVC.m
//  BigMarket
//
//  Created by RedSky on 2019/5/8.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXAp_Store_SelectStoreTypeVC.h"

@interface XZXAp_Store_SelectStoreTypeVC ()

@end

@implementation XZXAp_Store_SelectStoreTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"选择店铺类型";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.dataArray addObject:@{@"name":@" 食品类",@"id":@"1"}];
    [self.dataArray addObject:@{@"name":@" 化妆品",@"id":@"2"}];
    [self.dataArray addObject:@{@"name":@" 纸/卫生巾/消毒/洗衣液产品",@"id":@"3"}];
    [self.dataArray addObject:@{@"name":@" 初级包装农副产品",@"id":@"4"}];
    [self.dataArray addObject:@{@"name":@" 电器",@"id":@"5"}];
    
    [self.dataArray addObject:@{@"name":@" 儿童玩具",@"id":@"6"}];
    [self.dataArray addObject:@{@"name":@" 五金类",@"id":@"7"}];
    [self.dataArray addObject:@{@"name":@" 酒水饮料",@"id":@"8"}];
    [self.dataArray addObject:@{@"name":@" 服装",@"id":@"9"}];
    [self.dataArray addObject:@{@"name":@" 化工产品（危险化学品除外）",@"id":@"10"}];
    
    [self.dataArray addObject:@{@"name":@" 生活用品",@"id":@"11"}];
    [self.dataArray addObject:@{@"name":@" 建筑材料",@"id":@"12"}];
    [self.dataArray addObject:@{@"name":@" 生产室内照明灯具",@"id":@"13"}];
    [self.dataArray addObject:@{@"name":@" 板式家具",@"id":@"14"}];
    [self.dataArray addObject:@{@"name":@" 钟表珠宝首饰",@"id":@"15"}];
    
    [self.dataArray addObject:@{@"name":@" 文体用品",@"id":@"16"}];
    [self.dataArray addObject:@{@"name":@" 电子产品",@"id":@"17"}];
    [self.dataArray addObject:@{@"name":@" 初级农副产品/家庭手工业产品/便民劳务活动/零星小额交易活动",@"id":@"18"}];
    [self.dataArray addObject:@{@"name":@" 工艺礼品",@"id":@"19"}];
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    cell.textLabel.font = kFont_Medium;
    cell.textLabel.text = [[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.DidSeletType) {
        
        self.DidSeletType([self.dataArray objectAtIndex:indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
