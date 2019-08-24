//
//  XZXEvalutionTVC.m
//  BigMarket
//
//  Created by RedSky on 2019/4/30.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXEvalutionTVC.h"
#import "XZXMineOrderVC.h"

#import "XZXMine_goodCell.h"
#import "XZXEvalution_ThreeButton_TC.h"
#import "XZXEvalution_Field_TC.h"
#import "XZXReturnAfterSaleSelectImageTVC.h"
#import "XZXEvalution_OneButton_TC.h"
#import "CSImagePickerManager.h"

#import "XZXEvalutionTVCModel.h"
@interface XZXEvalutionTVC()<XZXEvalution_ThreeButton_TCDelegate,XZXReturnAfterSaleSelectImageTVCDelegate,XZXEvalution_OneButton_TCDelegate>


@property (nonatomic, strong) CSImagePickerManager *imageManager;


@end

@implementation XZXEvalutionTVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"评价";
   
    NSMutableArray *muarray = [NSMutableArray arrayWithArray:self.dataArray];
    for (XZXEvalutionTVCModel *Model in muarray) {
        
        if (Model.evaluationState == 1 &&
            Model.GoodModel.evaluationState == 1) {
            [self.dataArray removeObject:Model];
        }
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXMine_goodCell" bundle:nil] forCellReuseIdentifier:@"XZXMine_goodCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXEvalution_ThreeButton_TC" bundle:nil] forCellReuseIdentifier:@"XZXEvalution_ThreeButton_TCID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZXEvalution_Field_TC" bundle:nil] forCellReuseIdentifier:@"XZXEvalution_Field_TCID"];
     [self.tableView registerNib:[UINib nibWithNibName:@"XZXReturnAfterSaleSelectImageTVC" bundle:nil] forCellReuseIdentifier:@"XZXReturnAfterSaleSelectImageTVCID"];
    [self addRightItemWithTitle:@"发布" titleColor:[UIColor whiteColor]];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0 && self.dataArray.count > 0){return 0;}
    if (section == 0 && self.dataArray.count == 0) {
        return 50;
    }
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 120;
    }else if (indexPath.row == 1){
        
        return 60;
    }else if (indexPath.row == 2){
        
        return 150;
    }else if (indexPath.row == 3){
        
        return 100;
    }else if (indexPath.row == 4){
        
        return 44;
    }else{
        
        return 100;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [UIView new];
    view.backgroundColor = kBackgroundColor;
    if (self.dataArray.count == 0) {
        view.backgroundColor = [UIColor whiteColor];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        title.textAlignment = NSTextAlignmentCenter;
        title.text = @"恭喜你，所有的商品都已经评价过啦！";
        title.textColor = [UIColor lightGrayColor];
        title.font = [UIFont systemFontOfSize:15.0];
        [view addSubview:title];
    }
    return view;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count == 0 ? 1 : self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count == 0 ? 0 : 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XZXEvalutionTVCModel *Model = [self.dataArray objectAtIndex:indexPath.section];
    if(indexPath.row == 0){
        
        XZXMine_goodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXMine_goodCellID" forIndexPath:indexPath];
        cell.selected = UITableViewCellSelectionStyleNone;
        cell.goodName.numberOfLines = 0;
        cell.goodContent.numberOfLines = 0;
        cell.goodName.text = Model.GoodModel.goodsName;
        cell.goodContent.attributedText = [NSString changestringArray:@[[NSString stringWithFormat:@"¥ %@",[NSString reviseString:Model.GoodModel.goodsPrice]],[NSString stringWithFormat:@"\n积分：%@",Model.GoodModel.goodsScore]] colorArray:@[kThemeColor,kThemeColor] fontArray:@[@"17.0",@"15.0"]];
        [cell.goodImage sd_setImageWithURL:kImageUrl(Model.GoodModel.storeId,Model.GoodModel.goodsImage) placeholderImage:[UIImage imageNamed:LoadPic]];
        return cell;
    }else if (indexPath.row == 1){
        XZXEvalution_ThreeButton_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXEvalution_ThreeButton_TCID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        
        cell.goodBtn.selected = false;
        cell.MediumBtn.selected = false;
        cell.poorBtn.selected   = false;
        if (Model.EvalutionLevel == 5) {
            
            cell.goodBtn.selected = true;
        }else if (Model.EvalutionLevel == 3){
            
            cell.MediumBtn.selected = true;
        }else if (Model.EvalutionLevel == 1){
            
            cell.poorBtn.selected   = true;
        }
        return cell;
    }else if (indexPath.row == 2){
        XZXEvalution_Field_TC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXEvalution_Field_TCID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.TextField.text = Model.EvalutionContent;
        cell.GetContent = ^(NSString * _Nonnull content) {
            Model.EvalutionContent = content;
        };
        return cell;
    }else if (indexPath.row == 3){
       
        XZXReturnAfterSaleSelectImageTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"XZXReturnAfterSaleSelectImageTVCID" forIndexPath:indexPath];
        cell.delegate = self;
        cell.dataArray_Pic = Model.dataArray_Pic;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.CustomerCollectionView reloadData];
        return cell;
    }else{
     
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        if (((XZXEvalutionTVCModel *)[self.dataArray objectAtIndex:indexPath.section]).anonymous == 0) {
       
             cell.imageView.image = [UIImage imageNamed:@"weixuanzhong"];
        }else{
            
             cell.imageView.image = [UIImage imageNamed:@"xuanzhong"];
        }
       
        cell.textLabel.text  = @"匿名";
        return cell;
    }
}

#pragma mark 选择评价等级
-(void)selectEvalutionLevel:(NSInteger)level_t cell:(XZXEvalution_ThreeButton_TC *)cell{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    XZXEvalutionTVCModel *Model = [self.dataArray objectAtIndex:indexPath.section];
    Model.EvalutionLevel = level_t;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
    
}
#pragma makr 选择图片
-(void)GetPhont_XZXReturnAfterSaleSelectImageTVCDelegate:(XZXReturnAfterSaleSelectImageTVC *)cell{

    
     NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    XZXEvalutionTVCModel *Model = [self.dataArray objectAtIndex:indexPath.section];
    self.imageManager = [CSImagePickerManager presentVC:self assetsCallback:^(NSArray<UIImage *> *photos) {
        
        for (UIImage *image in photos) {
            
            if (Model.dataArray_Pic.count >= 2) {
                
                
                [MBProgressHUD xh_showHudWithMessage:@"最多只能上传一张图片" toView:self.view completion:^{
                    
                }];
            }else{
                
             
                [Model.dataArray_Pic addObject:image];
            }
        }
        
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    
}
#pragma mark 是否匿名
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        
        
        ((XZXEvalutionTVCModel *)[self.dataArray objectAtIndex:indexPath.section]).anonymous = ((XZXEvalutionTVCModel *)[self.dataArray objectAtIndex:indexPath.section]).anonymous == 0 ?1:0;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
    }
}


-(void)rightButtonItemOnClicked:(NSInteger)index{
    [self.view endEditing:YES];
  
    
    for (XZXEvalutionTVCModel *Model in self.dataArray) {
        if ([Model.EvalutionContent length] == 0) {
    
            [MBProgressHUD xh_showHudWithMessage:@"请检查您是否有填写您对商品的评价" toView:self.view completion:^{
                
            }];
            return;
        }
    }
    
    [self UploadImage:self.dataArray.firstObject];
}


-(void)UploadImage:(XZXEvalutionTVCModel *)Model{
 
    if (Model == nil){
        
        return;
    }
    
    if (Model.dataArray_Pic.count > 1) {
     
        [XHNetworking xh_uploadPath:kConfig(XHUploadUrl) parameters:@{} requestType:POST progressStyle:NetworkingPorgressStyleDeterminate fileData:^(id<AFMultipartFormData>  _Nonnull formData) {
            
         
            NSData *data1 = [XHTools compressImage:Model.dataArray_Pic[1] toByte:102400];
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
            [formatter1 setDateFormat:@"yyyyMMddhhmmssSSSS"];
            NSString *dateNow1 = [formatter1 stringFromDate:[NSDate date]];
            [formData appendPartWithFileData:data1 name:@"fileName" fileName:[NSString stringWithFormat:@"%@.png",dateNow1] mimeType:@"png/image"];
        } success:^(XHResponse *responseObject) {
            
            if(responseObject.code == 200){
             
                 [self UploadEvalution:Model ImageUrl:[responseObject.data valueForKey:@"url"]];
            }
        }];
    }else{
        
  
        [self UploadEvalution:Model ImageUrl:@""];

    }
}

-(void)UploadEvalution:(XZXEvalutionTVCModel *)Model ImageUrl:(NSString *)imageUrl{
    
    
    [XHNetworking xh_postWithSuccess:@"orders/orderEvaluate" parameters:@{@"token":kUser.token,@"userId":@(kUser.member_id),@"gevalOrderid":Model.orderID,@"gevalFrommemberid":@(kUser.member_id),@"gevalGoodsid":Model.GoodModel.goodsId,@"gevalScores":@(Model.EvalutionLevel),@"gevalContent":Model.EvalutionContent,@"gevalIsanonymous":@(Model.anonymous),@"gevalImage":imageUrl,@"recId":Model.GoodModel.recId} success:^(XHResponse *responseObject) {
        
        if (responseObject.code == 200) {
            [self.dataArray removeObject:Model];
            if (self.dataArray.count > 0) {
                
                [self UploadImage:self.dataArray.firstObject];
            }else{
             
                for (UIViewController *VC in self.navigationController.viewControllers) {
                    if ([VC isKindOfClass:[XZXMineOrderVC class]]) {
                        
                        [self.navigationController popToViewController:VC animated:YES];
                    }
                }
            }
        }
    }];
}

@end
