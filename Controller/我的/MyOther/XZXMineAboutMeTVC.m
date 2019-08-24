//
//  XZXMineAboutMeTVC.m
//  BigMarket
//
//  Created by RedSky on 2019/6/11.
//  Copyright © 2019 RedSky. All rights reserved.
//

#import "XZXMineAboutMeTVC.h"
#import "GoodDetail_goodImage.h"


@interface XZXMineAboutMeTVC ()

@end

@implementation XZXMineAboutMeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"关于我们";
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodDetail_goodImage" bundle:nil] forCellReuseIdentifier:@"GoodDetail_goodImageID"];
    
    self.dataArray = [NSMutableArray arrayWithObjects:
                      @"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789A43127C61AE74D9A966FBACF26F5733B.jpg",
                      @"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789444C771B81664FA4B9FBBCC4A18CD771.jpg",
                      @"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/121345678952DB8575F65F4D05B7D8D66DB0A63C02.jpg",
                      @"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789EA9BD503BF324DE482BDBBE0A2CAB018.jpg",
                      @"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/121345678952962CBD9F124B1E8FFB4E5ADE8AB9B9.jpg",
                      @"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789119F849E1B2A455EBBCCF30D74401E8E.jpeg",
                      @"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789F342C51BCDB7437CB556F16BA10C9055.jpg",
                      @"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/12134567896F1743A46C7A4A3FA8641F8880648017.jpg",
                      @"http://ydshop-photo.oss-cn-shenzhen.aliyuncs.com/newyunshop/1213456789D6488077B0404022979E26F64D353E5C.jpg",nil];
}

#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenWidth*1.78;
    
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
    
    GoodDetail_goodImage *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodDetail_goodImageID" forIndexPath:indexPath];
    [cell.good_image sd_setImageWithURL:kImageUrl(@"",[self.dataArray objectAtIndex:indexPath.row]) placeholderImage:[UIImage imageNamed:LoadPic]];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;
}


@end
