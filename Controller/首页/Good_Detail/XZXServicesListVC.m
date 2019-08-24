//
//  XZXServicesListVC.m
//  BigMarket
//
//  Created by RedSky on 2019/7/26.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXServicesListVC.h"

#import "GoodDetail_serviceHeadView.h"

@interface XZXServicesListVC ()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation XZXServicesListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(kScreenHeight/3.0*2.0);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    self.CustomerTableView.backgroundColor = kBackgroundColor;
    self.CustomerTableView.tableFooterView = [UIView new];
    self.CustomerTableView.dataSource = self;
    self.CustomerTableView.delegate   = self;
}
-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [NSString stringWithFormat:@"    %@",[[self.dataSource objectAtIndex:indexPath.section] valueForKey:@"content"]];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.textColor = [UIColor darkTextColor];
    cell.textLabel.backgroundColor = kBackgroundColor;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    GoodDetail_serviceHeadView *View = [[[NSBundle mainBundle]loadNibNamed:@"GoodDetail_serviceHeadView" owner:nil options:nil] firstObject];
    View.content_lab.text = [[self.dataSource objectAtIndex:section] valueForKey:@"title"];
    
    return View;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Delect_Action:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
