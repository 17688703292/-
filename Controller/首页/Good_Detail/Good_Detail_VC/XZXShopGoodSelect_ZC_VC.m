//
//  XZXShopGoodSelect_ZC_VC.m
//  BigMarket
//
//  Created by RedSky on 2019/7/25.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXShopGoodSelect_ZC_VC.h"
#import "XZXShopGood_UploadOrderVC.h"

#import "XZXPaymentOrder.h"

#import "XZXShopGoodSelectContent.h"
#import "XZXShopGoodSelectWeight.h"
#import "XZXShopGoodSelectNum.h"
#import "XZXShopGoodSelectZC_SelectTypeTVC.h"
#import "XZXShopGoodSelectZC_IntroduceTVC.h"
#import "XZXShopGoodSelectZC_Introduce2TVC.h"

@interface XZXShopGoodSelect_ZC_VC ()<UITableViewDelegate,UITableViewDataSource,XZXShopGoodSelectWeightDelegate,XZXShopGoodSelectZC_SelectTypeDelegate>
@property (nonatomic,strong) UITableView *CustomerTableView;
@property (nonatomic,strong) UIButton *DelectView;
@property (nonatomic,strong) NSMutableArray *DataArray_GuiGe_Orange;//规格列表
@property (nonatomic,strong) NSMutableArray *DataArray_GuiGe;//规格列表
@property (nonatomic,strong) NSMutableArray *Select_DataArray_GuiGe;//选中的规格列表
@property (nonatomic,assign) BOOL IsAllPay;

@end


@implementation XZXShopGoodSelect_ZC_Model

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"specValueList": [XZXShopGoodSelectGuiGeModel class]};
}

@end

@implementation XZXShopGoodSelect_ZC_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGFloat height = 70;
    if (kScreenWidth <= 320) {
        height = 50;
    }
    self.BuyBtn.cornerRadius = 30.0;
    self.DelectView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    [self.BottomView addSubview:self.DelectView];
    [self.DelectView setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
    [self.DelectView addTarget:self action:@selector(DelectView_Action) forControlEvents:UIControlEventTouchDown];
    
    [self.BottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(kScreenHeight/3.0*2.0);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    
    
    self.CustomerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, 50)];
    [self.BottomView addSubview:self.CustomerTableView];
    
    [self.CustomerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.BottomView.mas_left).offset(0);
        make.right.mas_equalTo(self.BottomView.mas_right).offset(0);
        make.bottom.mas_equalTo(self.BuyBtn.mas_top).offset(-5);
        make.top.mas_equalTo(self.BottomView.mas_top).offset(35);
    }];
    
    self.CustomerTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.CustomerTableView.dataSource = self;
    self.CustomerTableView.delegate   = self;
    self.CustomerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXShopGoodSelectContent" bundle:nil] forCellReuseIdentifier:@"XZXShopGoodSelectContentID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXShopGoodSelectWeight" bundle:nil] forCellReuseIdentifier:@"XZXShopGoodSelectWeightID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXShopGoodSelectNum" bundle:nil] forCellReuseIdentifier:@"XZXShopGoodSelectNumID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXShopGoodSelectZC_SelectTypeTVC" bundle:nil] forCellReuseIdentifier:@"XZXShopGoodSelectZC_SelectTypeTVCID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXSHopGoodselectZC_IntroduceTVC" bundle:nil] forCellReuseIdentifier:@"XZXSHopGoodselectZC_IntroduceTVCID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXShopGoodSelectZC_Introduce2TVC" bundle:nil] forCellReuseIdentifier:@"XZXShopGoodSelectZC_Introduce2TVCID"];
    
    
    if (self.GoodModel.IsOver == true) {
        
        [self.BuyBtn setBackgroundColor:[UIColor lightGrayColor]];
        [self.BuyBtn setTitle:@"已结束" forState:UIControlStateNormal];
        self.BuyBtn.userInteractionEnabled = false;
    }

    //默认选择一个商品
    self.IsAllPay = YES;
    if ([self.GoodModel.type count] > 0 ||
        [self.GoodModel.type2 isEqualToString:@"1"]) {
        
        
        [self GetInformation];
    }else{
        
        //商品没有规格，将商品信息导入
        
    }
}

-(NSMutableArray *)DataArray_GuiGe_Orange{
    
    if (!_DataArray_GuiGe_Orange) {
        _DataArray_GuiGe_Orange = [NSMutableArray array];
    }
    return _DataArray_GuiGe_Orange;
}

-(NSMutableArray *)DataArray_GuiGe{
    if (!_DataArray_GuiGe) {
        _DataArray_GuiGe = [NSMutableArray array];
    }
    return _DataArray_GuiGe;
}

-(NSMutableArray *)Select_DataArray_GuiGe{
    if (!_Select_DataArray_GuiGe) {
        _Select_DataArray_GuiGe = [NSMutableArray array];
    }
    return _Select_DataArray_GuiGe;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)GetInformation{
    [XHNetworking xh_postWithoutSuccess:@"spec/getGoodsSpec" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"goodsCommonid":self.GoodModel.goodsCommonid,@"goodsId":self.GoodModel.goodsId} success:^(XHResponse *responseObject) {
        if ([responseObject.data isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in responseObject.data) {
                XZXShopGoodSelect_ZC_Model *MyModel = [XZXShopGoodSelect_ZC_Model yy_modelWithJSON:dic];
                [self.DataArray_GuiGe addObject:MyModel];
                [self.DataArray_GuiGe_Orange addObject:MyModel];
                //选择每个类型规格的第一个
                
                for (XZXShopGoodSelectGuiGeModel *specValue in MyModel.specValueList) {
                    
                    if (specValue.status == 1) {
                        [self.Select_DataArray_GuiGe addObject:specValue];
                    
                        break;
                    }
                }
                
            }
            
        
            [self.CustomerTableView reloadData];
        }
        
    }];
    
}
-(void)viewWillLayoutSubviews{
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

     if (self.IsAllPay == YES) {
     
         return 2 + self.DataArray_GuiGe.count;
     }else{
         
         return 1;
     }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
       
        return 4;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            XZXShopGoodSelectContent *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXShopGoodSelectContentID" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.image sd_setImageWithURL:kImageUrl(self.GoodModel.storeId,self.GoodModel.titlePicture) placeholderImage:[UIImage imageNamed:LoadPic]];
            cell.price.text = self.GoodModel.goodsName;
            
            if (self.IsAllPay == YES) {
                
                 cell.capacity.text = [NSString stringWithFormat:@"¥ %@",[NSString reviseString:self.GoodModel.price]];
            }else{
                
                 cell.capacity.text = @"¥ 1";
            }
            
            return cell;
        }else if (indexPath.row == 1){
            
            XZXShopGoodSelectZC_SelectTypeTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXShopGoodSelectZC_SelectTypeTVCID" forIndexPath:indexPath];
            cell.delegate = self;
            if (self.IsAllPay == YES) {
                
                cell.AllPayBtn.selected = YES;
                [cell.AllPayBtn setBackgroundColor:[UIColor colorWithRed:249/255.0 green:244/255.0 blue:243/255.0 alpha:1]];
                cell.AllPayBtn.layer.borderColor = kThemeColor.CGColor;
                
                cell.OnePayBtn.selected = NO;
                [cell.OnePayBtn setBackgroundColor:[UIColor whiteColor]];
                cell.OnePayBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            }else{
                
                cell.OnePayBtn.selected = YES;
                [cell.OnePayBtn setBackgroundColor:[UIColor colorWithRed:249/255.0 green:244/255.0 blue:243/255.0 alpha:1]];
                cell.OnePayBtn.layer.borderColor = kThemeColor.CGColor;
                
                cell.AllPayBtn.selected = NO;
                [cell.AllPayBtn setBackgroundColor:[UIColor whiteColor]];
                cell.AllPayBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            }
            return cell;
        }else if(indexPath.row == 2){
            
            XZXSHopGoodselectZC_IntroduceTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXSHopGoodselectZC_IntroduceTVCID" forIndexPath:indexPath];
            cell.content_lab.attributedText  = [NSString changestringArray:@[@"支持人数 ",self.IsAllPay == YES ? self.GoodModel.currentFullPeople:self.GoodModel.currentOnePeople] colorArray:@[[UIColor lightGrayColor],[UIColor blackColor]] fontArray:@[@"13",@"13"]];

            return cell;
        }else{
            
            XZXShopGoodSelectZC_Introduce2TVC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXShopGoodSelectZC_Introduce2TVCID" forIndexPath:indexPath];
            if (self.IsAllPay == YES) {
                
                cell.content_lab.text = self.GoodModel.goodsJingle;
            }else{
             
                cell.content_lab.text = self.GoodModel.explainDesc;
            }
            return cell;
        }
    }
    else if (indexPath.section == 1 + self.DataArray_GuiGe.count){
        
        
        XZXShopGoodSelectNum *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXShopGoodSelectNumID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.GoodNum.text = [NSString stringWithFormat:@"%ld",self.GoodModel.goodnum];
        cell.selectGoodNum = self.GoodModel.goodnum;
        cell.ChangeGoodNum = ^(NSInteger selectGoodNum) {
            
            self.GoodModel.goodnum = selectGoodNum;
        };
        return cell;
    }
    else
    {
        //商品属性
        XZXShopGoodSelectWeight *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXShopGoodSelectWeightID" forIndexPath:indexPath];
        XZXShopGoodSelect_ZC_Model *Model = [self.DataArray_GuiGe objectAtIndex:indexPath.section-1];
        cell.dataSource  = Model.specValueList;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.SelectWeightdelegate = self;
        [cell.CustomerCollectionView reloadData];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 1) {
            return 70;
        }else if (indexPath.row == 2 ||
                  indexPath.row == 3){
            
            return UITableViewAutomaticDimension;
        }
        return 100;
    }else if(indexPath.section == 1 + self.DataArray_GuiGe.count){
        
        return 50;
    }else{
        
        XZXShopGoodSelect_ZC_Model *Model = [self.DataArray_GuiGe objectAtIndex:indexPath.section-1];
        NSInteger num = Model.specValueList.count%4 == 0 ? Model.specValueList.count/4 : Model.specValueList.count/4+1;
        return 60*num;
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:view.bounds];
    [view addSubview:label];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor grayColor];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 10, 0, 10));
    }];
    
    label.text = ((XZXShopGoodSelect_ZC_Model*)[self.DataArray_GuiGe objectAtIndex:section-1]).spName;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section !=0 &&
        section != 1 + self.DataArray_GuiGe.count) {
        return 30;
    }
    return 0;
}


#pragma XZXShopGoodSelectZC_SelectTypeDelegate

-(void)DidselectAllPayMoney:(BOOL)IsAllPay{
    
    [self.DataArray_GuiGe removeAllObjects];
    if (self.IsAllPay == YES) {
        self.GoodModel.goodnum = 1;
        self.IsAllPay = false;
    }else{
        
        self.IsAllPay = true;
        self.DataArray_GuiGe = [NSMutableArray arrayWithArray:self.DataArray_GuiGe_Orange];
    }
    [self.CustomerTableView reloadData];
}

#pragma XZXShopGoodSelectWeightDelegate
//选择规格后重新定向商品详情
-(void)didSelectGuigeDataSource:(XZXShopGoodSelectGuiGeModel *)GuigeDataModel tableviewcell:(XZXShopGoodSelectWeight *)cell{
    
    NSIndexPath *indexPath = [self.CustomerTableView indexPathForCell:cell];
    
    [self.Select_DataArray_GuiGe replaceObjectAtIndex:indexPath.section-1 withObject:GuigeDataModel];
    //1、将新规格传递给服务器获取新的商品ID
    NSMutableDictionary *MuDic = [NSMutableDictionary dictionary];
    for (XZXShopGoodSelectGuiGeModel *model in self.Select_DataArray_GuiGe) {
        
        NSLog(@"%@",model.spValueName);
        [MuDic setObject:model.spValueName forKey:model.spValueId];
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:MuDic options:kNilOptions error:nil];
    NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    
    [XHNetworking xh_postWithoutSuccess:@"spec/getGoodsByCommonIdAndSpec" parameters:@{@"spValue":json,@"token":kUser.token,@"userId":@(kUser.member_id),@"goodsCommonid":self.GoodModel.goodsCommonid} success:^(XHResponse *responseObject) {
        
        if (responseObject.code == 200 && [responseObject.data isKindOfClass:[NSDictionary class]]) {
            
            
            self.GoodModel.goodsId      = [responseObject.data valueForKey:@"goodsId"];
            self.GoodModel.titlePicture = [responseObject.data valueForKey:@"goodsImage"];
            self.GoodModel.goodsName    = [responseObject.data valueForKey:@"goodsName"];
            self.GoodModel.price        = [NSString reviseString:[responseObject.data valueForKey:@"goodsPrice"]];
            self.GoodModel.score        = [NSString stringWithFormat:@"%@",[responseObject.data valueForKey:@"score"]];
            self.GoodModel.goodsStorage = [NSString stringWithFormat:@"%@",[responseObject.data valueForKey:@"goodsStorage"]];
            self.GoodModel.goodsSalenum = [NSString stringWithFormat:@"%@",[responseObject.data valueForKey:@"goodsSalenum"]];
            [self.CustomerTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}


- (void)DelectView_Action{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)Buy_Action:(id)sender {
    
 
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if (self.BuyGoods) {
            if (self.IsAllPay == false) {
                self.GoodModel.goodnum = 1;
            }
            self.BuyGoods(self.GoodModel, self.Select_DataArray_GuiGe,self.IsAllPay == YES ? 2 : 1);
        }
    }];
}
@end
