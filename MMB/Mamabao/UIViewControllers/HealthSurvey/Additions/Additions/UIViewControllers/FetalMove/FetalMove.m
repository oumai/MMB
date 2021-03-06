//
//  FetalMove.m
//  Mamabao
//
//  Created by Michael on 15/11/17.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import "FetalMove.h"
#import "OximeterRecordVC.h"
@interface FetalMove ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) TTTAttributedLabel *label1;
@property (nonatomic, strong) TTTAttributedLabel *label2;
@property (nonatomic, strong) TTTAttributedLabel *label3;
@property (nonatomic, strong) TTTAttributedLabel *label4;
@property (nonatomic, strong) UIImageView *circleImage;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *addButton;
@end

@implementation FetalMove
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"3_monitor"] style:(UIBarButtonItemStylePlain) target:self action:@selector(rightClick)];
        self.navigationItem.rightBarButtonItem = right;
        right.tintColor = KHexColor(@"#ffffff");

    }
    return self;
}
- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightClick
{
    OximeterRecordVC *record = [OximeterRecordVC new];
    record.typeRecordString = @"8";
    [self.navigationController pushViewController:record animated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"胎动";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [self makeUI];
}
- (void)makeUI
{
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, CoreHeight-64)];
    self.headerView.backgroundColor = KHexColor(@"#f3f3f3");
    [self.tableView addSubview:_headerView];
    
    self.label1 = [TTTAttributedLabel new];
    self.label1.font = KFontSize(14);
    self.label1.textColor = KHexColor(@"#666666");
    self.label1.text = @"五分钟连续记录一次";
    [self.headerView addSubview:_label1];
    
     
    self.label2 = [TTTAttributedLabel new];
    self.label2.font = KFontSize(14);
    self.label2.textColor = KHexColor(@"#fe647e");
    self.label2.text = @"00:00";
    [self.headerView addSubview:_label2];
    
    
       
    self.circleImage = [UIImageView new];
    self.circleImage.image = [UIImage imageNamed:@"monitor67"];
    [self.headerView addSubview:_circleImage];
    
      
    self.label3 = [TTTAttributedLabel new];
    self.label3.font = KFontSize(50);
    self.label3.textColor = KHexColor(@"#fe647e");
    self.label3.text = @"0";
    [self.headerView addSubview:_label3];
    
      
    self.label4 = [TTTAttributedLabel new];
    self.label4.font = KFontSize(14);
    self.label4.textColor = KHexColor(@"#333333");
    self.label4.text = @"胎动记录";
    [self.headerView addSubview:_label4];
    
    
      
    self.startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startButton.layer.cornerRadius = 7;
    self.startButton.layer.masksToBounds = YES;
    [self.startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.startButton setTitle:@"开始" forState:UIControlStateNormal];
    [self.startButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.startButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff92a5")] forState:UIControlStateNormal];
    [self.headerView addSubview:_startButton];
      
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton.layer.cornerRadius = 7;
    self.addButton.layer.masksToBounds = YES;
    [self.addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.addButton setTitle:@"计数+1" forState:UIControlStateNormal];
    [self.addButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.addButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff92a5")] forState:UIControlStateNormal];
    [self.headerView addSubview:_addButton];
  

    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.headerView.mas_top).offset(25);
        make.width.equalTo(self.label1.mas_width);
        make.height.equalTo(14);
    }];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.label1.mas_bottom).offset(25);
        make.width.equalTo(self.label2.mas_width);
        make.height.equalTo(14);
    }];
    
    [_circleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.label2.mas_bottom).offset(25);
        make.width.equalTo(225);
        make.height.equalTo(225);
    }];
    
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.centerY.equalTo(self.circleImage.mas_centerY).offset(0);
        make.width.equalTo(self.label3.mas_width);
        make.height.equalTo(50);
    }];
    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.circleImage.mas_bottom).offset(-50);
        make.width.equalTo(self.label4.mas_width);
        make.height.equalTo(14);
    }];
    
    [_startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headerView.mas_centerX).offset(-20);
        make.bottom.equalTo(self.headerView.mas_bottom).offset(-50);
        make.width.equalTo(60);
        make.height.equalTo(30);
    }];
    
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerView.mas_centerX).offset(20);
        make.bottom.equalTo(self.headerView.mas_bottom).offset(-50);
        make.width.equalTo(60);
        make.height.equalTo(30);
    }];


}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------
- (void)startButtonClick
{
    
}

- (void)addButtonClick
{
    
}



@end
