//
//  SidebarViewController.m
//  Benevolence
//
//  Created by Michael on 15/10/27.
//  Copyright © 2015年 Michael. All rights reserved.
//



/*-------------------------------------------------------------------------------------M-------------------------------------------------------------------*/

@interface SidebarModel : NSObject

@property(nonatomic,strong)NSString *iconName;
@property(nonatomic,strong)NSString *labelName;

@end

@interface SidebarModel ()

@end

@implementation SidebarModel



@end

/*-------------------------------------------------------------------------------------V-------------------------------------------------------------------*/

@interface SidebarCustomCell : UITableViewCell

@property(nonatomic,strong)SidebarModel *model;

@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) TTTAttributedLabel *tttLabel;
@property (nonatomic, strong) UIImageView *iconImage;


@end

@interface SidebarCustomCell ()
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UIImageView *arrowImage;
@end

@implementation SidebarCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor =  KHexColor(@"#ffe8eb");
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#999999");
        [self.contentView addSubview:_line];
        
        self.iconImage = [UIImageView new];
        [self.contentView addSubview:_iconImage];
        
        self.tttLabel = [TTTAttributedLabel new];
        self.tttLabel.font = KFontSize(14);
        self.tttLabel.textColor = KHexColor(@"#c1999f");
        [self.contentView addSubview:_tttLabel];
        
        self.arrowImage = [UIImageView new];
        self.arrowImage.image = [UIImage imageNamed:@"3-1monitordata"];
        [self.contentView addSubview:_arrowImage];
        
       
        
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.height.equalTo(0.5);
        }];
        
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.width.equalTo(16);
            make.height.equalTo(16);
        }];
        
        [_tttLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImage.mas_centerY).offset(-2);
            make.left.equalTo(self.iconImage.mas_right).offset(20);
            make.width.equalTo(self.tttLabel.mas_width);
            make.height.equalTo(14);
        }];

        
        
        [_arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImage.mas_centerY).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.width.equalTo(10);
            make.height.equalTo(14);
        }];
        
            }
    return self;
}

- (void)setIconName:(NSString *)iconName
{
    if (![iconName isValid]) {
        return;
    }
    self.iconImage.image = [UIImage imageNamed:iconName];
}


@end
/*-------------------------------------------------------------------------------------C-------------------------------------------------------------------*/


#import "SidebarViewController.h"
#import "ZYMenuController.h"
#import "MySetVC.h"
#import "MotherCircleVC.h"
#import "InformationVC.h"
#import "MyCollectionVC.h"
#import "ConsultRecordVC.h"
#import "MyOrderVC.h"
#import "SettingCenterVC.h"
#import "MyCollectionTieZiVC.h"
@interface SidebarViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *infoDic;


@property (nonatomic, strong) UIView *headerView;//头像
@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *yuChanQiLabel;
@property (nonatomic, strong) UIButton *headerButton;

@end

@implementation SidebarViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.menuController.navigationController.navigationBar.hidden = YES;
    
    if ([self.user getUserMessageFromLocation].isLogin == YES)
    {
        
        self.nameLabel.text = [self.user getUserMessageFromLocation].userRealName;
        
        if ([self.user getUserMessageFromLocation].currentIdentity == 0)
        {
            self.yuChanQiLabel.text = [NSString stringWithFormat:@"预产期: %@",[self.user getUserMessageFromLocation].userExpectConfindent];

        }
        else
        {
            self.yuChanQiLabel.text = [NSString stringWithFormat:@"宝宝生日: %@",[self.user getUserMessageFromLocation].baby_birthday];
        }
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[[self.user getUserMessageFromLocation].userImg stringByReplacingOccurrencesOfString:@" " withString:@""]] placeholderImage:[UIImage imageNamed:@"photo_ring"]];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = KHexColor(@"#ffe8eb");
    self.user = [[ASUserInfoModel alloc] init];
    [self makeUI];
    
    
    //列表
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = KHexColor(@"#ffe8eb");
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(200);
        make.left.bottom.equalTo(self.view);
        make.width.equalTo(self.view.frame.size.width*0.78);
    }];
}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------

- (void)headerButtonClick:(UIButton *)button
{

    MySetVC* vc = [[MySetVC alloc] init];
    [self.menuController showRootViewController:YES ];
    [self.menuController.navigationController pushViewController:vc animated:YES];

}

#pragma mark ------------------------------------------------------------------Self makeUI -------------------------------------------------------------------
- (void)makeUI
{
    //头像
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*0.78, 200)];
    self.headerView.backgroundColor = KHexColor(@"#ffe8eb");
    [self.view addSubview:_headerView];
    
    self.headerImage = [UIImageView new];
    self.headerImage.image = [UIImage imageNamed:@"side_1bar"];
    self.headerImage.backgroundColor =  KHexColor(@"#ffe8eb");
    self.headerImage.layer.cornerRadius = 50;
    self.headerImage.layer.masksToBounds = YES;
    [self.headerView addSubview:_headerImage];
    
    self.iconImage = [UIImageView new];
    self.iconImage.layer.cornerRadius = 40;
    self.iconImage.layer.masksToBounds = YES;
    [self.headerView addSubview:_iconImage];
    
    
    self.nameLabel = [UILabel new];
    self.nameLabel.textColor = KHexColor(@"#a48a83");
    [self.view addSubview:_nameLabel];
    
    
    self.yuChanQiLabel = [UILabel new];
    self.yuChanQiLabel.textColor = KHexColor(@"#a48a83");
    [self.view addSubview:_yuChanQiLabel];
    
    self.headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.headerButton addTarget:self action:@selector(headerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:_headerButton];
    
    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView);
        make.top.equalTo(self.headerView.mas_top).offset(30);
        make.width.equalTo(330/2);
        make.height.equalTo(270/2);
    }];
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView);
        make.top.equalTo(self.headerView.mas_top).offset(30);
        make.width.equalTo(80);
        make.height.equalTo(80);
    }];

    
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView);
        make.top.equalTo(self.headerView.mas_top).offset(120);
        make.width.equalTo(self.nameLabel.mas_width);
        make.height.equalTo(17);
    }];
    
    [_yuChanQiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.width.equalTo(self.yuChanQiLabel.mas_width);
        make.height.equalTo(14);
    }];
    [_headerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.headerView);
    }];
}

#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 7;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.row == 2) {
        return 90;
    }
    else
    {
        return 45;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    SidebarCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[SidebarCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        if (indexPath.row == 2) {
            cell.tttLabel.textColor = [UIColor grayColor];
        }

    }
    NSArray *array = @[@"妈妈圈",@"资讯",@"我的帖子",@"我的收藏",@"我的咨询",@"我的订单",@"设置中心"];
    NSArray *arrayImage = @[@"side_2bar",@"side_3bar",@"my_post",@"side_4bar",@"side_5bar",@"side_6bar",@"side_7bar"];
    cell.tttLabel.text = array[indexPath.row];
    cell.iconName = arrayImage[indexPath.row];
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {

        MotherCircleVC *mother = [[MotherCircleVC alloc] init];
        [self.menuController.navigationController pushViewController:mother animated:YES];
        [self.menuController showRootViewController:YES];
        
    }
    else if (indexPath.row == 1 )
    {
        InformationVC *info = [[InformationVC alloc] init];
        [self.menuController.navigationController pushViewController:info animated:YES];
        [self.menuController showRootViewController:YES];
    }
    else if (indexPath.row == 2)
    {
        MyCollectionTieZiVC *vc = [[MyCollectionTieZiVC alloc] init];
        [self.menuController.navigationController pushViewController:vc animated:YES];
        [self.menuController showRootViewController:YES];
    }
    else if (indexPath.row == 3)
    {
        MyCollectionVC* myCollection = [[MyCollectionVC alloc] init];
        [self.menuController.navigationController pushViewController:myCollection animated:YES];
        [self.menuController showRootViewController:YES];

    }
    else if (indexPath.row == 4)
    {
        ConsultRecordVC* consult = [[ConsultRecordVC alloc] init];
        [self.menuController.navigationController pushViewController:consult animated:YES];
        [self.menuController showRootViewController:YES];
    }
    else if (indexPath.row == 5)
    {
            
        MyOrderVC* vc = [[MyOrderVC alloc] init];
        [self.menuController.navigationController pushViewController:vc animated:YES];
        [self.menuController showRootViewController:YES];

        
    }
    else if (indexPath.row == 6)
    {
        SettingCenterVC *set = [[SettingCenterVC alloc] init];
        [self.menuController.navigationController pushViewController:set animated:YES];
        [self.menuController showRootViewController:YES];
    }
}


@end
