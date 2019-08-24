//
//  XZXShopGoodSelectVC.m
//  Slumbers
//
//  Created by RedSky on 2018/12/25.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "XZXShopGoodSelectVC.h"
#import "XZXShopGood_UploadOrderVC.h"

#import "XZXPaymentOrder.h"

#import "XZXShopGoodSelectContent.h"
#import "XZXShopGoodSelectWeight.h"
#import "XZXShopGoodSelectNum.h"

@interface XZXShopGoodSelectVC ()<UITableViewDelegate,UITableViewDataSource,XZXShopGoodSelectWeightDelegate>
@property (nonatomic,strong) UIButton *DelectView;
@property (nonatomic,strong) UITableView *CustomerTableView;
@property (nonatomic,strong) NSMutableArray *DataArray_GuiGe;//规格列表
@property (nonatomic,strong) NSMutableArray *Select_DataArray_GuiGe;//选中的规格列表

@end


@implementation XZXShopGoodSelectModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"specValueList": [XZXShopGoodSelectGuiGeModel class]};
}

@end


@implementation XZXShopGoodSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGFloat height = 70;
    if (kScreenWidth <= 320) {
        height = 50;
    }
    
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
    
    if (self.LastTime >= 0 ) {
        //秒杀只有立即购买，没有添加购物车
        self.AddCarBtn.hidden = YES;
        [self.BuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(self.BottomView.mas_left);
            make.bottom.mas_equalTo(self.BottomView.mas_bottom);
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(height);
        }];
        if (self.LastTime == 0) {
            
            self.BuyBtn.backgroundColor = [UIColor lightGrayColor];
        }else{
            
            self.BuyBtn.backgroundColor = kThemeColor;
        }
    }else if (self.GoodModel.goodsPromotionType == JiFen_t){
     
        self.AddCarBtn.hidden = YES;
        [self.BuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.BottomView.mas_left);
            make.bottom.mas_equalTo(self.BottomView.mas_bottom);
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(height);
        }];
        
        
        if (self.JF_type == 3) {
            
            [self.BuyBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
        }
        
    }else{
        
        [self.AddCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.BottomView.mas_left);
            make.bottom.mas_equalTo(self.BottomView.mas_bottom);
            make.width.mas_equalTo(kScreenWidth/2.0);
            make.height.mas_equalTo(height);
        }];
        
        [self.BuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.BottomView.mas_right);
            make.bottom.mas_equalTo(self.BottomView.mas_bottom);
            make.width.mas_equalTo(kScreenWidth/2.0);
            make.height.mas_equalTo(height);
        }];
    }

    
    self.CustomerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, 50)];
    [self.BottomView addSubview:self.CustomerTableView];
    
    [self.CustomerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.BottomView.mas_left).offset(0);
        make.right.mas_equalTo(self.BottomView.mas_right).offset(0);
        make.bottom.mas_equalTo(self.BuyBtn.mas_top).offset(5);
        make.top.mas_equalTo(self.BottomView.mas_top).offset(35);
    }];
    
    self.CustomerTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.CustomerTableView.dataSource = self;
    self.CustomerTableView.delegate   = self;
    
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXShopGoodSelectContent" bundle:nil] forCellReuseIdentifier:@"XZXShopGoodSelectContentID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXShopGoodSelectWeight" bundle:nil] forCellReuseIdentifier:@"XZXShopGoodSelectWeightID"];
    [self.CustomerTableView registerNib:[UINib nibWithNibName:@"XZXShopGoodSelectNum" bundle:nil] forCellReuseIdentifier:@"XZXShopGoodSelectNumID"];
    

    //默认选择一个商品

    if ([self.GoodModel.type count] > 0 ||
        [self.GoodModel.type2 isEqualToString:@"1"]) {
        
        
        [self GetInformation];
    }else{
        
        //商品没有规格，将商品信息导入
      
    }
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
                XZXShopGoodSelectModel *MyModel = [XZXShopGoodSelectModel yy_modelWithJSON:dic];
                [self.DataArray_GuiGe addObject:MyModel];
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
    return 2 + self.DataArray_GuiGe.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        XZXShopGoodSelectContent *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXShopGoodSelectContentID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.image sd_setImageWithURL:kImageUrl(self.GoodModel.storeId,self.GoodModel.titlePicture) placeholderImage:[UIImage imageNamed:LoadPic]];
        cell.price.text = self.GoodModel.goodsName;
        
        if (self.GoodModel.goodsPromotionType ==20) {
        
        
            cell.capacity.text = [NSString stringWithFormat:@"¥ %@",[NSString reviseString:self.GoodModel.goodsPromotionPrice]];
        }else if (self.GoodModel.goodsPromotionType == JiFen_t){
            
            if ([self.GoodModel.goodsPromotionPrice floatValue] != 0) {
                
                
                cell.capacity.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"积分:%@",self.GoodModel.score],@" + ",[NSString stringWithFormat:@"¥ %@",[NSString reviseString:self.GoodModel.goodsPromotionPrice]]] colorArray:@[kThemeColor,[UIColor lightGrayColor],[UIColor lightGrayColor]] fontArray:@[@"19.0",@"14.0",@"14.0"]];
            }else{
                
                
                cell.capacity.text = [NSString stringWithFormat:@"积分:%@",self.GoodModel.score];
                
            }
            
        }else{
            
           cell.capacity.text = [NSString stringWithFormat:@"¥ %@",[NSString reviseString:self.GoodModel.price]];
            
        }
        
        if (self.GoodModel.goodsPromotionType == MiaoSha_t) {
            
            cell.content.text = [NSString stringWithFormat:@"销量：%ld   库存：%ld    积分：%@",self.GoodModel.activitySellCount ,self.GoodModel.activityCount - self.GoodModel.activitySellCount,[self.GoodModel.score isKindOfClass:[NSString class]] ? self.GoodModel.score :@"0"];
        }else{
         
            if (self.GoodModel.goodsPromotionType == JiFen_t){
                
                    cell.content.text = [NSString stringWithFormat:@"销量：%ld   库存：%ld",self.GoodModel.activitySellCount ,self.GoodModel.activityCount - self.GoodModel.activitySellCount];
            }else{
                
             
                   cell.content.text = [NSString stringWithFormat:@"销量：%@   库存：%@    积分：%@",[self.GoodModel.goodsSalenum isKindOfClass:[NSString class]] ? self.GoodModel.goodsSalenum :@"0",[self.GoodModel.goodsStorage isKindOfClass:[NSString class]] ? self.GoodModel.goodsStorage :@"0",[self.GoodModel.score isKindOfClass:[NSString class]] ? self.GoodModel.score :@"0"];
            }
        }
        return cell;
    }
    else if (indexPath.section == 1 + self.DataArray_GuiGe.count){
        
        
        XZXShopGoodSelectNum *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXShopGoodSelectNumID" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.GoodNum.text = [NSString stringWithFormat:@"%ld",self.GoodModel.goodnum];
        cell.selectGoodNum = self.GoodModel.goodnum;
        cell.goodsPromotionType = self.GoodModel.goodsPromotionType;
        cell.ChangeGoodNum = ^(NSInteger selectGoodNum) {

            if (self.GoodModel.goodsPromotionType == MiaoSha_t) {
                
                [MBProgressHUD xh_showHudWithMessage:@"秒杀商品最多选购1个" toView:self.view completion:^{
                    
                }];
            }else{
             
                self.GoodModel.goodnum = selectGoodNum;
                
            }
        };
        
        return cell;
    }
    else
    {
        //商品属性
        XZXShopGoodSelectWeight *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXShopGoodSelectWeightID" forIndexPath:indexPath];
        XZXShopGoodSelectModel *Model = [self.DataArray_GuiGe objectAtIndex:indexPath.section-1];
        cell.dataSource  = Model.specValueList;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.SelectWeightdelegate = self;
        [cell.CustomerCollectionView reloadData];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return 100;
    }else if(indexPath.section == 1 + self.DataArray_GuiGe.count){
        
        return 50;
    }else{
        
        XZXShopGoodSelectModel *Model = [self.DataArray_GuiGe objectAtIndex:indexPath.section-1];
        NSInteger num = Model.specValueList.count%4 == 0 ? Model.specValueList.count/4 : Model.specValueList.count/4+1;
        return 60*num;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    view.backgroundColor = kBackgroundColor;
    UILabel *label = [[UILabel alloc]initWithFrame:view.bounds];
    [view addSubview:label];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor grayColor];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 10, 0, 10));
    }];
    
    label.text = ((XZXShopGoodSelectModel*)[self.DataArray_GuiGe objectAtIndex:section-1]).spName;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section !=0 &&
        section != 1 + self.DataArray_GuiGe.count) {
        return 30;
    }
    return 0;
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
- (IBAction)AddCar_Action:(id)sender {
    
    if (self.GoodModel.goodsPromotionType == JiFen_t) {
        
        [MBProgressHUD xh_showHudWithMessage:@"积分商品不能添加到购物车" toView:self.view completion:^{
            
        }];
        return;
    }
    
    NSMutableString *mustr = [NSMutableString string];

    for (NSInteger j =0; j < self.Select_DataArray_GuiGe.count ; j++ ) {
        XZXShopGoodSelectGuiGeModel *model = [self.Select_DataArray_GuiGe objectAtIndex:j];
        if (j == self.Select_DataArray_GuiGe.count - 1) {
            [mustr appendString:[NSString stringWithFormat:@"%@",model.spValueId]];
        }else{
            
            [mustr appendString:[NSString stringWithFormat:@"%@_",model.spValueId]];
        }
    }
    
    [XHNetworking xh_postWithoutSuccess:@"cart/insertCart" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"buyerId":@(kUser.member_id),@"storeId":self.GoodModel.storeId,@"goodsId":self.GoodModel.goodsId,@"goodsNum":@(self.GoodModel.goodnum),@"spValueIdStr":mustr} success:^(XHResponse *responseObject) {
      
        [MBProgressHUD xh_showHudWithMessage:@"商品已成功添加到购物车" toView:self.view completion:^{
            
            [self dismissViewControllerAnimated:YES completion:^{
                
                
            }];
        }];
      
    }];
    
}
- (IBAction)Buy_Action:(id)sender {
    if (self.LastTime == 0) {
        
       
        return;
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
       
        if (self.BuyGoods) {
            self.BuyGoods(self.GoodModel, self.Select_DataArray_GuiGe);
        }
    }];
    
}

@end

