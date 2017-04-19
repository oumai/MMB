//
//  NoPayYueZiCenterOrderVC.m
//  Mamabao
//
//  Created by Michael on 15/12/8.
//  Copyright © 2015年 Michael. All rights reserved.
//

/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface NoPayYueZiCenterOrderModel : NSObject


@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *entity_id;
@property (nonatomic, strong) NSString *package_id;
@property (nonatomic, strong) NSString *person_id;
@property (nonatomic, strong) NSString *order_number;
@property (nonatomic, strong) NSString *package_name;
@property (nonatomic, strong) NSString *entity_name;
@property (nonatomic, strong) NSString *service_time;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *isPerson;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface NoPayYueZiCenterOrderModel ()

@end

@implementation NoPayYueZiCenterOrderModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init])
    {
        if ([[dic objectForKey:@"id"]isKindOfClass:[NSNumber class]]) {
            self.order_id = [[dic objectForKey:@"id"] stringValue];
        }

        if ([dic objectForKey:@"order_number"]) {
            self.order_number = [dic objectForKey:@"order_number"];
        }
        if ([dic objectForKey:@"package_name"]) {
            self.package_name = [dic objectForKey:@"package_name"];
        }
        
        if ([dic objectForKey:@"entity_name"]) {
            self.entity_name = [dic objectForKey:@"entity_name"];
        }
        
        if ([dic objectForKey:@"service_time"]) {
            self.service_time = [dic objectForKey:@"service_time"];
        }
        if ([[dic objectForKey:@"status"]isKindOfClass:[NSNumber class]]) {
            self.status = [[dic objectForKey:@"status"] stringValue];
        }
        if ([[dic objectForKey:@"isPerson"]isKindOfClass:[NSNumber class]]) {
            self.isPerson = [[dic objectForKey:@"isPerson"] stringValue];
        }

        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface NoPayYueZiCenterOrderCustomCell : UITableViewCell

@property (nonatomic, strong) NoPayYueZiCenterOrderModel *yueOrderModel;
@property (nonatomic, strong) void(^PayOrderVCBlock)();

@end



@interface NoPayYueZiCenterOrderCustomCell ()
@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *payButton;
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) TTTAttributedLabel *orderNumeberLabel;
@property (nonatomic, strong) TTTAttributedLabel *yueZiCenterLabel;
@property (nonatomic, strong) TTTAttributedLabel *taoCanLabel;
@property (nonatomic, strong) TTTAttributedLabel *timeLabel;
@end

@implementation NoPayYueZiCenterOrderCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KHexColor(@"#f5f5f5");
        
        self.cellView = [UIView new];
        self.cellView.backgroundColor = KHexColor(@"#ffffff");
        self.cellView.layer.cornerRadius = 5;
        self.cellView.layer.masksToBounds = YES;
        self.cellView.layer.borderColor = KHexColor(@"#e6e6e6").CGColor;
        self.cellView.layer.borderWidth = 1;
        [self.contentView addSubview:_cellView];
        
        
        self.orderNumeberLabel = [TTTAttributedLabel new];
        self.orderNumeberLabel.textColor = KHexColor(@"#666666");
        self.orderNumeberLabel.font = KFontSize(14);
        [self.contentView addSubview:_orderNumeberLabel];
        
        
        self.payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.payButton.titleLabel.font = KFontSize(15);
        self.payButton.layer.cornerRadius = 5;
        self.payButton.layer.masksToBounds = YES;
        [self.payButton addTarget:self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.payButton setTitle:@"付款" forState:UIControlStateNormal];
        [self.payButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
        [self.payButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff92a5")] forState:UIControlStateNormal];
        [self.contentView addSubview:_payButton];
        
        
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#cccccc");
        [self.contentView addSubview:_line];
        
        
        
        self.yueZiCenterLabel = [TTTAttributedLabel new];
        self.yueZiCenterLabel.textColor = KHexColor(@"#ff637e");
        self.yueZiCenterLabel.font = KFontSize(14);
        [self.contentView addSubview:_yueZiCenterLabel];
        
        
        
        self.taoCanLabel = [TTTAttributedLabel new];
        self.taoCanLabel.textColor = KHexColor(@"#666666");
        self.taoCanLabel.font = KFontSize(14);
        [self.contentView addSubview:_taoCanLabel];
        
        
        self.timeLabel = [TTTAttributedLabel new];
        self.timeLabel.textColor = KHexColor(@"#666666");
        self.timeLabel.font = KFontSize(14);
        [self.contentView addSubview:_timeLabel];
        
        [_cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(7);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-7);
            make.right.equalTo(self.contentView.mas_right).offset(-7);
            
        }];
        [_orderNumeberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cellView.mas_top).offset(15);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.width.equalTo(self.orderNumeberLabel.mas_width);
            make.height.equalTo(14);
            
        }];
        [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.orderNumeberLabel.mas_centerY).offset(0);
            make.right.equalTo(self.cellView.mas_right).offset(-15);
            make.width.equalTo(50);
            make.height.equalTo(25);
        }];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.right.equalTo(self.cellView.mas_right).offset(-15);
            make.top.equalTo(self.cellView.mas_top).offset(45);
            make.height.equalTo(0.5);
        }];
        [_yueZiCenterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line.mas_top).offset(15);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.width.equalTo(self.yueZiCenterLabel.mas_width);
            make.height.equalTo(14);
            
        }];
        [_taoCanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.yueZiCenterLabel.mas_bottom).offset(15);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.width.equalTo(self.taoCanLabel.mas_width);
            make.height.equalTo(14);
            
        }];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.taoCanLabel.mas_bottom).offset(15);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.width.equalTo(self.timeLabel.mas_width);
            make.height.equalTo(14);
            
        }];
    }
    return self;
}


- (void)payButtonClick
{
    if (self.PayOrderVCBlock) {
        self.PayOrderVCBlock();
    }
}

- (void)setYueOrderModel:(NoPayYueZiCenterOrderModel *)yueOrderModel
{
    if (nil == yueOrderModel) {
        return;
    }
    self.orderNumeberLabel.text = [NSString stringWithFormat:@"订单号：%@",yueOrderModel.order_number];
    self.yueZiCenterLabel.text = yueOrderModel.entity_name;
    self.taoCanLabel.text = [NSString stringWithFormat:@"购买套餐：%@",yueOrderModel.package_name];
    self.timeLabel.text = [NSString stringWithFormat:@"服务时间：%@",yueOrderModel.service_time];
    self.order_id = yueOrderModel.order_id;
}

@end


/*-----------------------------------------------------------------------C-------------------------------------------*/


#import "NoPayYueZiCenterOrderVC.h"
#import "OrderDetailYueZiCenterVC.h"
#import "PayOrderVC.h"
#import "YSPayOrderVC.h"
@interface NoPayYueZiCenterOrderVC ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NoPayYueZiCenterOrderVC



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
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
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NavigationBarTitleColor
    self.view.backgroundColor = KHexColor(@"#ffffff");
    self.menuController.panEnabel = NO;
    self.user = [[ASUserInfoModel alloc] init];
    self.dataArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 160;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [self requestData];
}

#pragma mark ----------------------------------------------------------------------------UITableViewDatasource delegate---------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    NoPayYueZiCenterOrderCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[NoPayYueZiCenterOrderCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    cell.yueOrderModel = _dataArray[indexPath.row];
    NoPayYueZiCenterOrderModel *model = _dataArray[indexPath.row];
    [cell setPayOrderVCBlock:^{
        
        if ([model.isPerson isEqualToString:@"0"]) {
            PayOrderVC *pay = [[PayOrderVC alloc]init];
            pay.order_id = cell.order_id;
            [self.navigationController pushViewController:pay animated:YES];
        }
        if ([model.isPerson isEqualToString:@"1"]) {
            YSPayOrderVC *pay = [[YSPayOrderVC alloc]init];
            pay.order_id = cell.order_id;
            [self.navigationController pushViewController:pay animated:YES];

        }
       
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转到支付页面
    
}

#pragma mark -----------------------------------------------------------------------------------ASURLConnection---------------------------------------------------------------
- (void)requestData
{
    
    if ([self.serviceTypeId isValid]) {
        [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],@"serviceTypeId":self.serviceTypeId,@"payStatus":@0} method:@"renhe.orderService.myOrders" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
            
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
            {
                NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
                for (NSDictionary *dic in dataArr) {
                    NoPayYueZiCenterOrderModel *model = [[NoPayYueZiCenterOrderModel alloc] initWithDictionary:dic];
                    [_dataArray addObject:model];
                }
                [_tableView reloadData];
            }
            
        } errorBlock:^(NSError *error) {
        }];

    }
    
   
}
@end
