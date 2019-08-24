//
//  XZXMine_EditAdress_SelectArea.m
//  Slumbers
//
//  Created by RedSky on 2019/1/25.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XZXMine_EditAdress_SelectArea.h"

#import "XZXTransportlistCell.h"
#import "XZXMine_EditAdress_SelectAreaCell.h"

#import "XZXMine_EditAdress_SelectAreaModel.h"

@interface XZXMine_EditAdress_SelectArea ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIButton *DelectView;
@property (nonatomic,strong) UITableView *CustomerTableView;
@property (nonatomic,strong) UIView *bottomView;//下半部底层试图
@property (nonatomic,strong) XZXMine_EditAdress_SelectAreaModel *SelectAreaModel;//城市信息
@property (nonatomic,strong) NSMutableArray *dataSource_Select;//保存选择的地区
@property (nonatomic,strong) NSMutableArray *dataSource;//保存所有地区
@property (nonatomic,assign) NSInteger selectType;//1、选择省。2、选择市 3、选择县、区



@end

@implementation XZXMine_EditAdress_SelectArea

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.bottomView = [[UIView alloc]init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kScreenHeight/3.0*2.0);
    }];
    
    UILabel *Toptitle = [UILabel new];
    [self.bottomView addSubview:Toptitle];
    [Toptitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bottomView);
        make.top.mas_equalTo(self.bottomView.mas_top).offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/4.0);
    }];
    Toptitle.text = @"请选择";
    Toptitle.textAlignment = NSTextAlignmentCenter;
    
    
    self.DelectView = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 70, 30)];
    [self.DelectView setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
    [self.DelectView addTarget:self action:@selector(DelectView_Action) forControlEvents:UIControlEventTouchDown];
    [self.bottomView addSubview:self.DelectView];
    
    
    
    self.CustomerTableView = [[UITableView alloc]init];
    [self.bottomView addSubview:self.CustomerTableView];
    
    [self.CustomerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bottomView.mas_left).offset(0);
        make.right.mas_equalTo(self.bottomView.mas_right).offset(0);
        make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(-5);
        make.top.mas_equalTo(self.bottomView.mas_top).offset(35);
    }];
    self.CustomerTableView.backgroundColor = kBackgroundColor;
    self.CustomerTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXTransportlistCell" bundle:nil] forCellReuseIdentifier:@"XZXTransportlistCellID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXMine_EditAdress_SelectAreaCell" bundle:nil] forCellReuseIdentifier:@"XZXMine_EditAdress_SelectAreaCellID"];
    self.CustomerTableView.dataSource = self;
    self.CustomerTableView.delegate   = self;
    
    self.selectType = 1;//获取省份
    [self GetInformation_cityUrl:@"area/selectAllProvinceArea" parameter:@{}];
}

-(void)GetInformation_cityUrl:(NSString *)url parameter:(NSDictionary *)parameter{
    
    [XHNetworking xh_postWithoutSuccess:url parameters:parameter success:^(XHResponse *responseObject) {
        if ([responseObject.data isKindOfClass:[NSArray class]]) {
        
          
            [self.dataSource removeAllObjects];
            for (NSDictionary *dic in responseObject.data) {
                [self.dataSource addObject:[XZXMine_EditAdress_SelectAreaModel yy_modelWithJSON:dic]];
            }
            
//            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"area_py" ascending:YES];
//            self.dataSource = [NSMutableArray arrayWithArray:[self.dataSource sortedArrayUsingDescriptors:@[sortDescriptor]]];
//
            if (self.dataSource.count == 0) {
                
                [self DelectView_Action];
            }
            
            [self.CustomerTableView reloadData];
        }
    }];
}


-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
-(NSMutableArray *)dataSource_Select{
    if (!_dataSource_Select) {
        XZXMine_EditAdress_SelectAreaModel *model = [XZXMine_EditAdress_SelectAreaModel new];
        model.areaName = @"请选择";
        _dataSource_Select = [NSMutableArray arrayWithObjects:model, nil];
    }
    return _dataSource_Select;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        
        return self.dataSource_Select.count;
        
    }else{
        
        return self.dataSource.count;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return 70;
    }
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    if (indexPat.section == 0) {
        XZXTransportlistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXTransportlistCellID" forIndexPath:indexPat];
        cell.time.hidden = true;
        if (indexPat.row < self.dataSource_Select.count-1) {
            
            XZXMine_EditAdress_SelectAreaModel *cityModel = self.dataSource_Select[indexPat.row];
            cell.Adress.text = cityModel.areaName;
            cell.Adress.textColor = [UIColor blackColor];
            cell.Image.image = [UIImage imageNamed:@"aixin"];
        }else{
            
            cell.Adress.text = @"请选择";
            cell.Adress.textColor = kThemeColor;
            cell.Image.image = [UIImage imageNamed:@"aixin_hui"];
        }
        return cell;
        
    }else{
        XZXMine_EditAdress_SelectAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMine_EditAdress_SelectAreaCellID" forIndexPath:indexPat];
        XZXMine_EditAdress_SelectAreaModel *model = self.dataSource[indexPat.row];
        cell.city_name.text = model.areaName;
        //cell.city_word.text = model.area_py;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return;
    }
    
    XZXMine_EditAdress_SelectAreaModel *current_cityModel = self.dataSource[indexPath.row];
    [self.dataSource_Select insertObject:current_cityModel atIndex:self.dataSource_Select.count-1];
    
    ++self.selectType;
    [self GetInformation_cityUrl:@"area/selectAllListByParentId" parameter:@{@"areaParentId":@(current_cityModel.areaId),@"userId":@(kUser.member_id)}];

}

-(void)DelectView_Action{
    
    NSMutableString *mustr = [NSMutableString new];
    for (NSInteger j = 0 ; j < self.dataSource_Select.count - 1; j++) {
        XZXMine_EditAdress_SelectAreaModel *SelectAreaModel = [self.dataSource_Select objectAtIndex:j];
        [mustr appendString:[NSString stringWithFormat:@"%@ ",SelectAreaModel.areaName]];
    }
    
    if (self.SelectArea) {
        self.SelectArea(mustr, self.dataSource_Select);
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
