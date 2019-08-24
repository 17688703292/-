//
//  XZXClassVC.m
//  Slumbers
//
//  Created by RedSky on 2019/3/18.
//  Copyright © 2019 zhu. All rights reserved.
//

#import "XZXClassVC.h"
#import "XZXClass_TC.h"
#import "XZXClass_CC.h"
#import "XZXClass_two_TVC.h"
#import "ZWPullMenuView.h"
#import "XZXSearchResultVC.h"
#import "XZXHome_Class_StoreCVC.h"


#import "XZXClass_leftModel.h"
#import "XZXClass_rightModel.h"

@interface XZXClassVC ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UITableView *leftTView;
@property (weak, nonatomic) IBOutlet UIImageView *RightImage;
@property (weak, nonatomic) IBOutlet UICollectionView *RightCollView;

@property (nonatomic,strong)NSMutableArray *dataSource_left;
@property (nonatomic,assign)NSInteger Select_left;//选中下标
@property (nonatomic,strong)NSMutableArray *dataSource_right;


@property (nonatomic,strong)ZWPullMenuView *menuView;//下拉菜单

@property (nonatomic,strong)UIView *searchbackView;
@property (nonatomic,strong)UIView *selectType;
@property (nonatomic,strong)UILabel *searchtype_label;//用户搜索框
@property (nonatomic,copy) NSString *searchtype_str;//用户搜索类型 店铺、商店

@end

@implementation XZXClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Select_left = 0;
    self.searchtype_str = @" 商品";
    [self SearchBarInNavigation];
    self.leftTView.dataSource = self;
    self.leftTView.delegate   = self;
    [self.leftTView registerNib:[UINib nibWithNibName:@"XZXClass_TC" bundle:nil] forCellReuseIdentifier:@"XZXClass_TCID"];
    self.leftTView.tableFooterView = [UIView new];
    self.leftTView.backgroundColor = kBackgroundColor;
    
    self.RightCollView.dataSource = self;
    self.RightCollView.delegate   = self;
    [self.RightCollView registerNib:[UINib nibWithNibName:@"XZXClass_CC" bundle:nil] forCellWithReuseIdentifier:@"XZXClass_CCID"];
    [self GetLeftClassInformation];
 
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    //YES：允许右滑返回  NO：禁止右滑返回
    return NO;
    
}

-(NSMutableArray *)dataSource_left{
    if (!_dataSource_left) {
        _dataSource_left = [NSMutableArray array];

    }
    return _dataSource_left;
}

-(NSMutableArray *)dataSource_right{
    if (!_dataSource_right) {
        _dataSource_right = [NSMutableArray array];
        
    }
    return _dataSource_right;
}

#pragma mark 获取行业/分类商品列表
-(void)GetLeftClassInformation{
    
    [XHNetworking xh_postWithoutSuccess:@"goodsClassNav/getGoodsClassNavList" parameters:@{@"token":kUser.token} success:^(XHResponse *responseObject) {

       
        if (![responseObject.data isKindOfClass:[NSArray class]]) {
            
            return ;
        }
        for (NSInteger i = 0 ; i < ((NSArray *)responseObject.data).count; i ++) {
           
            NSDictionary *left_dic = responseObject.data[i];
            //加载第一个行业的商品类别
            [self.dataSource_left addObject:[XZXClass_leftModel yy_modelWithJSON:left_dic]];
            XZXClass_leftModel *Model = [self.dataSource_left objectAtIndex:0];
            [self.RightImage sd_setImageWithURL:[NSURL URLWithString:Model.gcThumb] placeholderImage:[UIImage imageNamed:LoadPic]];
            //。加载行业数据
            if (i == 0 &&
                [[left_dic valueForKey:@"goodsClassPc"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *right_dic in [left_dic valueForKey:@"goodsClassPc"]) {
                    
                    [self.dataSource_right addObject:[XZXClass_rightModel yy_modelWithJSON:right_dic]];
                }
            }
        }
        [self.leftTView reloadData];
        [self.RightCollView reloadData];
    }];
}



-(void)GetRightClassInformation{
    
    [self.dataSource_right removeAllObjects];
    
    [XHNetworking xh_postWithoutSuccess:@"goodsClassNav/getGoodsClassList" parameters:@{@"token":kUser.token,@"gcParentId":@(((XZXClass_leftModel *)self.dataSource_left[self.Select_left]).gcId)} success:^(XHResponse *responseObject) {
        
    
        for (NSDictionary *dic in responseObject.data) {
        
            [self.dataSource_right addObject:[XZXClass_rightModel yy_modelWithJSON:dic]];
        }
    
        [self.RightCollView reloadData];
    }];
    
}
#pragma mark UITableviewDelegate    

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource_left.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    XZXClass_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXClass_TCID" forIndexPath:indexPath];
    cell.Model = self.dataSource_left[indexPath.row];
    
    if (self.Select_left == indexPath.row) {
        cell.name.backgroundColor = kThemeColor;
        cell.name.textColor = kWhite;
        cell.name.font = [UIFont systemFontOfSize:15.0];
    }else{
        
        cell.name.backgroundColor = [UIColor clearColor];
        cell.name.textColor = kBlack;
        cell.name.font = [UIFont systemFontOfSize:13.0];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.Select_left != indexPath.row ) {
     
        self.Select_left = indexPath.row;
        
        [self.leftTView reloadData];
        XZXClass_leftModel *Model = [self.dataSource_left objectAtIndex:indexPath.row];
        [self.RightImage sd_setImageWithURL:[NSURL URLWithString:Model.gcThumb] placeholderImage:[UIImage imageNamed:LoadPic]];
        [self GetRightClassInformation];
    }
}

#pragma mark UICollectionViewdelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource_right.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXClass_CC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XZXClass_CCID" forIndexPath:indexPath];
    cell.Model = self.dataSource_right[indexPath.row];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((kScreenWidth-90-20)/3.0, (kScreenWidth-90-20)/3.0*1.14);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXClass_two_TVC *TVC = kStoryboradController(@"Class", @"XZXClass_two_TVCID");
    TVC.hidesBottomBarWhenPushed = YES;
    TVC.title = ((XZXClass_rightModel *)[self.dataSource_right objectAtIndex:indexPath.item]).gcName;
    TVC.gcParentId = [NSString stringWithFormat:@"%ld",((XZXClass_rightModel *)[self.dataSource_right objectAtIndex:indexPath.item]).gcId];
    [self.navigationController pushViewController:TVC animated:YES];
}


#pragma mark 搜索栏

-(void)SearchBarInNavigation{
    
    
    self.searchbackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth*0.8, self.navigationController.navigationBar.frame.size.height*0.7)];
    self.searchbackView.backgroundColor = [UIColor whiteColor];
    
    self.searchbackView.cornerRadius = self.navigationController.navigationBar.frame.size.height*0.7*0.5;
    self.navigationItem.titleView = self.searchbackView;
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_Seartch)];
    [self.searchbackView addGestureRecognizer:tap2];
    
    //左-选择列表
    self.selectType = [[UIView alloc]initWithFrame:CGRectMake(5, 5, self.searchbackView.frame.size.width/4.0, self.searchbackView.frame.size.height*0.7)];
    [self.searchbackView addSubview:self.selectType];
    self.selectType.backgroundColor = [UIColor colorWithRed:217/255.0 green:11/255.0 blue:23/255.0 alpha:1];
    self.selectType.cornerRadius = self.searchbackView.frame.size.height*0.7*0.5;
    
    
    self.searchtype_label = [[UILabel alloc]initWithFrame:CGRectMake(5, 0,  self.selectType.frame.size.width/1.5, self.searchbackView.frame.size.height*0.7)];
    [self.selectType addSubview:self.searchtype_label];
    
    
    self.searchtype_label.backgroundColor = [UIColor clearColor];
    self.searchtype_label.text = self.searchtype_str;
    self.searchtype_label.textColor = [UIColor whiteColor];
    self.searchtype_label.adjustsFontSizeToFitWidth = YES;

    UIImageView *searchtype_image = [[UIImageView alloc]initWithFrame:CGRectMake(self.selectType.frame.size.width/1.5 ,0, self.selectType.frame.size.width - self.selectType.frame.size.width/1.5, self.searchbackView.frame.size.height*0.7)];
    searchtype_image.image = [UIImage imageNamed:@"jiantou_down"];
    [self.selectType addSubview:searchtype_image];
    searchtype_image.contentMode = UIViewContentModeCenter;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap_List:)];
    [self.selectType addGestureRecognizer:tap];
    
    //右-放大镜
    UIImageView *View_Big = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*0.8-50, 0, 50, self.searchbackView.frame.size.height)];
    View_Big.image = [UIImage imageNamed:@"fandajin"];
    View_Big.contentMode = UIViewContentModeCenter;
    [self.searchbackView addSubview:View_Big];
    
}

-(void)tap_List:(UITapGestureRecognizer *)tap{
    
    
    
    NSArray *array = @[@" 商品",@" 店铺"];
    self.menuView = [ZWPullMenuView pullMenuAnchorView:self.searchtype_label titleArray:array];
    
    __weak __typeof(self) weakSelf = self;
    self.menuView.blockSelectedMenu = ^(NSInteger menuRow) {
        
        weakSelf.searchtype_str = array[menuRow];
        weakSelf.searchtype_label.text = weakSelf.searchtype_str;
    };
}

-(void)tap_Seartch{
    if ([self.searchtype_str isEqualToString:@" 商品"]) {
        
        XZXSearchResultVC *VC = [[XZXSearchResultVC alloc]initWithNibName:@"XZXSearchResultVC" bundle:nil];
        VC.hidesBottomBarWhenPushed = YES;
        VC.VC_type = SearchGood_GoodList;
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        
        //进入店铺列表
        XZXHome_Class_StoreCVC *VC = kStoryboradController(@"Homepage", @"XZXHome_Class_StoreCVCID");
        VC.hidesBottomBarWhenPushed = YES;
        
        VC.VC_type = Store_List;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}
@end
