//
//  ConsultOverVC.m
//  Mamabao
//
//  Created by Michael on 15/11/14.
//  Copyright © 2015年 Michael. All rights reserved.
//


/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface ConsultOverModel : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface ConsultOverModel ()

@end

@implementation ConsultOverModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface ConsultOverCustomCell : UITableViewCell

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *payButton;
@property (nonatomic, strong) TTTAttributedLabel *nameLabel;
@property (nonatomic, strong) TTTAttributedLabel *questionLabel;
@property (nonatomic, strong) TTTAttributedLabel *timeLabel;
@end



@interface ConsultOverCustomCell ()
@end

@implementation ConsultOverCustomCell

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
        
        
        self.nameLabel = [TTTAttributedLabel new];
        self.nameLabel.textColor = KHexColor(@"#999999");
        self.nameLabel.font = KFontSize(14);
        self.nameLabel.text = @"欢哥";
        [self.contentView addSubview:_nameLabel];
        
        
        self.payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.payButton.titleLabel.font = KFontSize(15);
        self.payButton.layer.cornerRadius = 5;
        self.payButton.layer.masksToBounds = YES;
        [self.payButton addTarget:self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.payButton setTitle:@"未评价" forState:UIControlStateNormal];
        [self.payButton setTitleColor:KHexColor(@"#ff627e") forState:UIControlStateNormal];
        [self.contentView addSubview:_payButton];
        
        
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#cbcbcb");
        [self.contentView addSubview:_line];
        
        
        
        self.questionLabel = [TTTAttributedLabel new];
        self.questionLabel.textColor = KHexColor(@"#333333");
        self.questionLabel.font = KFontSize(14);
        self.questionLabel.text = [NSString stringWithFormat:@"腰酸，背痛，腿抽筋，上楼费劲，服了盖中盖一口气上五楼，不费劲"];
        [self.contentView addSubview:_questionLabel];
        
        
        
        
        
        self.timeLabel = [TTTAttributedLabel new];
        self.timeLabel.textColor = KHexColor(@"#cecece");
        self.timeLabel.font = KFontSize(14);
        NSString *timeString = @"2015.01.17  14:00";
        self.timeLabel.text = [NSString stringWithFormat:@"%@",timeString];
        [self.contentView addSubview:_timeLabel];
        
        [_cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(7);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-7);
            make.right.equalTo(self.contentView.mas_right).offset(-7);
            
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cellView.mas_top).offset(15);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.width.equalTo(self.nameLabel.mas_width);
            make.height.equalTo(14);
            
        }];
        [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel.mas_centerY).offset(0);
            make.right.equalTo(self.cellView.mas_right).offset(-15);
            make.width.equalTo(50);
            make.height.equalTo(25);
        }];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.right.equalTo(self.cellView.mas_right).offset(0);
            make.top.equalTo(self.cellView.mas_top).offset(45);
            make.height.equalTo(0.5);
        }];
        [_questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line.mas_top).offset(15);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.right.equalTo(self.cellView.mas_right).offset(-15);
            make.height.equalTo(14);
            
        }];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.questionLabel.mas_bottom).offset(15);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.width.equalTo(self.timeLabel.mas_width);
            make.height.equalTo(14);
            
        }];
    }
    return self;
}


- (void)payButtonClick
{
    
}


@end


/*-----------------------------------------------------------------------C-------------------------------------------*/
#import "ConsultOverVC.h"
#import "ConsultOverChat.h"
@interface ConsultOverVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ConsultOverVC

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
    self.title = @"月子中心订单";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.view.backgroundColor = KHexColor(@"#ffffff");
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 120;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
}
#pragma mark ----------------------------------------------------------------------------UITableViewDatasource delegate---------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    ConsultOverCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[ConsultOverCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConsultOverChat  *chat = [ConsultOverChat new];
    [self.navigationController pushViewController:chat animated:YES];
}
@end
