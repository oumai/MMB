//
//  HospitalDetailVC.m
//  Mamabao
//
//  Created by Michael on 15/11/26.
//  Copyright © 2015年 Michael. All rights reserved.
//
/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface HospitalDetailModel  : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface HospitalDetailModel ()

@end

@implementation HospitalDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface HospitalDetailCustomCell : UITableViewCell


+(CGFloat)cellForRowHeightWithString:(NSString *)string;
@end



@interface HospitalDetailCustomCell ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) TTTAttributedLabel *yiYuanJianJieLabel;

@end

@implementation HospitalDetailCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KHexColor(@"#f3f3f3");
        
        self.bgView = [UIView new];
        self.bgView.backgroundColor = KHexColor(@"#ffffff");
        [self.contentView addSubview:_bgView];
        
        self.yiYuanJianJieLabel = [TTTAttributedLabel new];
        self.yiYuanJianJieLabel.font = KFontSize(13);
        self.yiYuanJianJieLabel.textColor = KHexColor(@"#642800");
        self.yiYuanJianJieLabel.lineSpacing = 5;
        self.yiYuanJianJieLabel.numberOfLines = 0;
        [self.contentView addSubview:_yiYuanJianJieLabel];
        
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(0);
        }];
        
        [_yiYuanJianJieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);

        }];

    }
    return self;
}

+(CGFloat)cellForRowHeightWithString:(NSString *)string
{
    if (![string isValid]) {
        return 0;
    }
    
    CGFloat bottomSpace = 16;
    CGFloat detailHeight = [NSAttributedString contentHeightWithText:string width:CoreWidth-10-14 fontSize:13 lineSpacing:6.0f];
    return  bottomSpace + detailHeight +0;
}

@end


/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "HospitalDetailVC.h"



@interface HospitalDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) TTTAttributedLabel *yiYuanJianJieTitleLabel;
@property (nonatomic, strong) UIImageView*headerImage;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) TTTAttributedLabel *addressLabel;
@property (nonatomic, strong) UIImageView *addressImage;
@end

@implementation HospitalDetailVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"hospital_id---------------------------------%@",self.hospital_id);
    self.title = @"医院介绍";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    [self makeHeaderView];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(0);
        make.left.bottom.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-45);

    }];
    
    [self makeBottomView];
    [self requestData];
}

- (void)makeHeaderView
{
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, CoreWidth, 200)];
    self.headerView.backgroundColor = KHexColor(@"#fff4e2");
    [self.view addSubview:_headerView];
    
    self.headerImage = [[UIImageView alloc] init];
    self.headerImage.backgroundColor = KHexColor(@"#ebebeb");
    self.headerImage.image = [UIImage imageNamed:@""];
    [self.headerView addSubview:_headerImage];
    
     
    self.yiYuanJianJieTitleLabel = [TTTAttributedLabel new];
    self.yiYuanJianJieTitleLabel.font = KFontSize(15);
    self.yiYuanJianJieTitleLabel.textColor = KHexColor(@"#642800");
    self.yiYuanJianJieTitleLabel.text = @"医院简介";
    [self.headerView addSubview:_yiYuanJianJieTitleLabel];
    
    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.headerView);
        make.height.equalTo(160);
    }];
    [_yiYuanJianJieTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerView.mas_left).offset(10);
        make.bottom.equalTo(self.headerView.mas_bottom).offset(-13);
        make.width.equalTo(self.yiYuanJianJieTitleLabel.mas_width);
        make.height.equalTo(15);
    }];
    
    
}
- (void)makeBottomView
{
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = KHexColor(@"#dfffc8");
    [self.view addSubview:_bottomView];
    
      
    self.addressImage = [[UIImageView alloc] init];
    self.addressImage.backgroundColor = KHexColor(@"#ebebeb");
    self.addressImage.image = [UIImage imageNamed:@"hospital_introduction"];
    [self.bottomView addSubview:_addressImage];
    
     
    self.addressLabel = [TTTAttributedLabel new];
    self.addressLabel.font = KFontSize(15);
    self.addressLabel.textColor = KHexColor(@"#40112a");
    self.addressLabel.text = @"罗湖区五一路胜利街";
    [self.bottomView addSubview:_addressLabel];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.right.equalTo(self.headerView);
        make.height.equalTo(45);
    }];
    
    [_addressImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.bottomView).offset(17);
        make.width.equalTo(5);
        make.height.equalTo(9);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressImage.mas_right).offset(10);
        make.centerY.equalTo(self.addressImage.mas_centerY).offset(0);
        make.width.equalTo(self.addressLabel.mas_width);
        make.height.equalTo(15);
    }];

    
}

#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------
- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HospitalDetailCustomCell cellForRowHeightWithString:[self.dataDic objectForKey:@"introduction"]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    HospitalDetailCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[HospitalDetailCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.yiYuanJianJieLabel.text = [self.dataDic objectForKey:@"introduction"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

#pragma mark ------------------------------------------------------------------ASURLConnection -----------------------------------------------------------------
- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{@"hospital_id":self.hospital_id,@"user_id":@0} method:@"jumper.hospital.hospital.getdetail" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject)
    {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            
            NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"]objectAtIndex:0];
            
            self.dataDic = [[NSDictionary alloc] initWithDictionary:dic];
            self.addressLabel.text = [dic objectForKey:@"address"];
            [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"image"]] placeholderImage:nil];
            [_tableView reloadData];
        }
        
    } errorBlock:^(NSError *error)
    {
        
    }];
}
@end

