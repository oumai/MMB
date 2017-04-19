//
//  YueZiCenterOrderDetailVC.m
//  Mamabao
//
//  Created by Michael on 15/11/11.
//  Copyright © 2015年 Michael. All rights reserved.
//

/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface YueZiCenterOrderDetailModel  : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface YueZiCenterOrderDetailModel ()

@end

@implementation YueZiCenterOrderDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface YueZiCenterOrderDetaiLCustomCell : UITableViewCell


@end

@interface YueZiCenterOrderDetaiLCustomCell ()

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) TTTAttributedLabel *label;

@end

@implementation YueZiCenterOrderDetaiLCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KHexColor(@"#ffffff");
        
        
        
        
        self.titleLabel = [TTTAttributedLabel new];
        self.titleLabel.textColor = KHexColor(@"#8c8c8c");
        self.titleLabel.font = KFontSize(14);
        [self.contentView addSubview:_titleLabel];
        
             
        self.label = [TTTAttributedLabel new];
        self.label.textColor = KHexColor(@"#6f6f6f");
        self.label.font = KFontSize(14);
        [self.contentView addSubview:_label];
        
        
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#cccccc");
        [self.contentView addSubview:_line];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.width.equalTo(self.titleLabel.mas_width);
            make.height.equalTo(14);
            
        }];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_centerX).offset(-30);
            make.width.equalTo(self.titleLabel.mas_width);
            make.height.equalTo(14);
            
        }];
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.right.equalTo(self.contentView.mas_right).offset(-25);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.height.equalTo(0.5);
        }];

        
    }
    return self;
}


@end

/*-----------------------------------------------------------------------V-------------------------------------------*/

@interface BigCustomCell : UITableViewCell


@end



@interface BigCustomCell ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *customCellDataArray;
@property (nonatomic, strong) NSDictionary *customCellDic;
@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) TTTAttributedLabel *label;
@property (nonatomic, strong) UIImageView *pingJiaImage;
@property (nonatomic, strong) UIView *sectionFooterView;
@end

@implementation BigCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _customCellDataArray = [NSMutableArray array];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.scrollEnabled = NO;
        self.tableView.layer.cornerRadius = 5;
        self.tableView.layer.masksToBounds = YES;
        self.tableView.layer.borderColor = KHexColor(@"#e6e6e6").CGColor;
        self.tableView.layer.borderWidth = 1;
        self.tableView.rowHeight = 45;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.contentView addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(7);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-7);
            make.right.equalTo(self.contentView.mas_right).offset(-7);
        }];
        
        
        [self requestData];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //已评价
    self.sectionFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 100)];
    
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"#cccccc");
    [self.sectionFooterView addSubview:_line];
    
    self.titleLabel = [TTTAttributedLabel new];
    self.titleLabel.textColor = KHexColor(@"#ff3f62");
    self.titleLabel.font = KFontSize(14);
    self.titleLabel.text = @"已评价";
    [self.sectionFooterView addSubview:_titleLabel];
    
    
    self.label = [TTTAttributedLabel new];
    self.label.textColor = KHexColor(@"#2e2e2e");
    self.label.font = KFontSize(14);
    self.label.text = @"服务态度很棒";
    [self.sectionFooterView addSubview:_label];
    
    self.pingJiaImage = [UIImageView new];
    self.pingJiaImage.image = [UIImage imageNamed:@"evaluation3"];
    [self.sectionFooterView addSubview:_pingJiaImage];
    
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sectionFooterView.mas_left).offset(25);
        make.right.equalTo(self.sectionFooterView.mas_right).offset(-25);
        make.bottom.equalTo(self.sectionFooterView.mas_bottom).offset(-45);
        make.height.equalTo(0.5);
    }];

    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.line.mas_centerY).offset(-22.5);
        make.left.equalTo(self.sectionFooterView.mas_left).offset(25);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(14);
        
    }];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.line.mas_centerY).offset(22.5);
        make.left.equalTo(self.titleLabel.mas_left).offset(0);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(14);
        
    }];
    
    [_pingJiaImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.label.mas_centerY).offset(0);
        make.right.equalTo(self.line.mas_right).offset(0);
        make.width.equalTo(20);
        make.height.equalTo(20);
        
    }];

    
   
    
    return _sectionFooterView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    YueZiCenterOrderDetaiLCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[YueZiCenterOrderDetaiLCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    NSArray *titleArray = @[@"月子中心名称",@"套餐名称",@"费用",@"姓名",@"联系电话",@"入住时间"];
    cell.titleLabel.text = titleArray[indexPath.row];
    
    if (_customCellDic)
    {
        if (indexPath.row == 0) {
            cell.label.text = [self.customCellDic objectForKey:@"entity_name"];
            
        }
        if (indexPath.row == 1) {
            cell.label.text = [self.customCellDic objectForKey:@"package_name"];
            
        }
        if (indexPath.row == 2) {
            cell.label.text = [NSString stringWithFormat:@"%@元",[[self.customCellDic objectForKey:@"totalPrice"]stringValue]];
            
        }
        if (indexPath.row == 3) {
            cell.label.text = [self.customCellDic objectForKey:@"user_name"];
            
        }
        
        if (indexPath.row == 4) {
            cell.label.text = [self.customCellDic objectForKey:@"mobile"];
            
        }
        if (indexPath.row == 5) {
            cell.label.text = [NSString stringWithFormat:@"%@至%@",[self.customCellDic objectForKey:@"startDateTime"],[self.customCellDic objectForKey:@"endDateTime"]];
        }
       
    }
      return cell;
}

#pragma mark ------------------------------------------------------------------ASURLConnection  -----------------------------------------------------------
- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{@"order_id":@3} method:@"renhe.orderService.orderDetail" view:self.contentView version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            _customCellDataArray = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            self.customCellDic = _customCellDataArray[0];
            NSLog(@"self.customCellDic--------------%@",self.customCellDic);
            
            [_tableView reloadData];
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
}


@end


/*-----------------------------------------------------------------------C-------------------------------------------*/



#import "YueZiCenterOrderDetailVC.h"
#import "EvaluateViewController.h"
@interface YueZiCenterOrderDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *dataDic;

@end

@implementation YueZiCenterOrderDetailVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"评价" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightClicked)];
        self.navigationItem.rightBarButtonItem = right;
        right.tintColor = KHexColor(@"#ffffff");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.view.backgroundColor = KHexColor(@"#f3f3f3");
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 270+100;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(7);
        make.left.bottom.right.equalTo(self.view);
       

    }];
    
}

#pragma mark ------------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------


- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightClicked
{

    EvaluateViewController *evaluate = [EvaluateViewController new];
    [self.navigationController pushViewController:evaluate animated:YES];
}

#pragma mark ----------------------------------------------------------------------------UITableViewDatasource delegate---------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *bigIdentifier = @"bigCell";
    BigCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:bigIdentifier];
    if (nil == cell) {
        cell = [[BigCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:bigIdentifier];
    }
   
    return cell;
}



@end




