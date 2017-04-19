//
//  MyOrderVC.m
//  Mamabao
//
//  Created by Michael on 15/11/10.
//  Copyright © 2015年 Michael. All rights reserved.
//





/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface MyOrderModel: NSObject

@property (nonatomic, strong) NSString *serviceTypeId;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *titleRName;
@property (nonatomic, strong) NSString *detailName;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface MyOrderModel ()

@end

@implementation MyOrderModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([dic objectForKey:@"name"]) {
            self.titleRName = [dic objectForKey:@"name"];
        }
        if ([dic objectForKey:@"text"]) {
            self.detailName = [dic objectForKey:@"text"];
            NSLog(@"self.detailName%@",self.detailName);
            
        }
        if ([dic objectForKey:@"imageUrl"]) {
            self.imageName = [dic objectForKey:@"imageUrl"];
        }
        if ([[dic objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
            self.serviceTypeId = [[dic objectForKey:@"id"] stringValue];
        }

        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface MyOrderCustomCell : UITableViewCell


@property (nonatomic, strong) MyOrderModel *orderModel;
@property (nonatomic, strong) MyOrderModel *orderModelRequest;

@end



@interface MyOrderCustomCell ()

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImage;

@end

@implementation MyOrderCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#e6e6e6");
        [self.contentView addSubview:_line];
        
        self.arrowImage = [UIImageView new];
        self.arrowImage.image = [UIImage imageNamed:@"3-1monitordata"];
        [self.contentView addSubview:_arrowImage];
        
        self.iconImage = [UIImageView new];
        self.iconImage.layer.cornerRadius = 14;
        self.iconImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconImage];
        
        self.titleLabel = [TTTAttributedLabel new];
        self.titleLabel.font = KFontSize(14);
        self.titleLabel.textColor = KHexColor(@"#656565");
        [self.contentView addSubview:_titleLabel];
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(0.5);
        }];
        
        [_arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.width.equalTo(10);
            make.height.equalTo(14);
        }];
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.width.equalTo(28);
            make.height.equalTo(28);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.left.equalTo(self.iconImage.mas_right).offset(10);
            make.width.equalTo(self.titleLabel.mas_width);
            make.height.equalTo(14);
        }];
        
    }
    return self;
}


- (void)setOrderModelRequest:(MyOrderModel *)orderModelRequest
{
    if (nil == orderModelRequest) {
        return;
    }
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:orderModelRequest.imageName] placeholderImage:nil];
    self.titleLabel.text = orderModelRequest.titleRName;
}

@end


/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "MyOrderVC.h"
#import "MyOrderYueZiVC.h"
#import "VisitOrderVC.h"


@interface MyOrderVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MyOrderVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.title = @"我的订单";
        
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
    }
    return self;
}

- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

   

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.dataArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [self requestData];
}

- (void)sectionButtonClick
{
    
}

#pragma mark ----------------------------------------------------------------------------UITableViewDatasource delegate---------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 10 : 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 45)];
    sectionView.backgroundColor = KHexColor(@"#f5f5f5");
    return sectionView;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0 == section ? [_dataArray count] :1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    MyOrderCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[MyOrderCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    if (indexPath.section == 0) {
        cell.orderModelRequest = _dataArray[indexPath.row] ;
    }
    else
    {
        cell.titleLabel.text = @"预约参观";
        cell.iconImage.image = [UIImage imageNamed:@"order_of_6mine"];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        MyOrderYueZiVC *yue = [MyOrderYueZiVC new];
        MyOrderModel *myOrder = _dataArray[indexPath.row];
        yue.navigationTitle = myOrder.titleRName;
        yue.serviceTypeId = myOrder.serviceTypeId;
        [self.navigationController pushViewController:yue animated:YES];
    }
    else
    {
        VisitOrderVC *visit = [VisitOrderVC new];
        [self.navigationController pushViewController:visit animated:YES];
    }
    
}
#pragma mark ----------------------------------------------------------------------------ASURLConnection---------------------------------------------------------------------------------
- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{} method:@"renhe.momService.serviceType" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"];
            for (int i = 0; i<dataArr.count; i ++)
            {
                MyOrderModel *model = [[MyOrderModel alloc] initWithDictionary:dataArr[i]];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
}
@end
