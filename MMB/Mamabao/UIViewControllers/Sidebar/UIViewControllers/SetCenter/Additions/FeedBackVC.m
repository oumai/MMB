//
//  FeedBackVC.m
//  Mamabao
//
//  Created by Michael on 15/11/12.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import "FeedBackVC.h"

@interface FeedBackVC ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITextView *feedTV;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) NSString *addTime;
@end

@implementation FeedBackVC
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    NavigationBarTitleColor
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [self makeUI];
    
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    self.addTime = [dateformatter stringFromDate:senddate];
    
}


- (void)makeUI
{
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, CoreHeight)];
    self.headerView.backgroundColor = KHexColor(@"#f3f3f3");
    self.tableView.tableHeaderView = self.headerView;
    
    self.feedTV = [UITextView new];
    self.feedTV.layer.cornerRadius = 8;
    self.feedTV.layer.masksToBounds = YES;
    self.feedTV.layer.borderColor = KHexColor(@"#e9e8e9").CGColor;
    self.feedTV.layer.borderWidth = 1;
    [self.headerView addSubview:_feedTV];
    
    
    
    self.submitButton = [UIButton ButtonWithBorderTitle:@"提交" titleNormalColor:KHexColor(@"#ffffff") titleHightlightedColor:KHexColor(@"#ffffff")
                                        backgroundColor:KHexColor(@"#ff879a") highlightedBackgroundColor:KHexColor(@"#ff879a")
                                              titleSize:14
                                                  frame:CGRectZero
                                                    tag:0
                                                 target:self
                                                 action:@selector(submitButtonClick)];

    self.submitButton.enabled = NO;
    self.submitButton.layer.cornerRadius = 5;
    self.submitButton.titleLabel.font = KFontSize(20);
    self.submitButton.layer.masksToBounds = YES;
    [self.submitButton setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
    [self.headerView addSubview:_submitButton];
    
    [_feedTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(10);
        make.right.equalTo(self.headerView.mas_right).offset(-7);
        make.left.equalTo(self.headerView.mas_left).offset(7);
        make.height.equalTo(120);
    }];

    
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.feedTV.mas_bottom).offset(30);
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.left.equalTo(self.headerView.mas_left).offset(20);
        make.right.equalTo(self.headerView.mas_right).offset(-20);
        make.height.equalTo(35);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:UITextViewTextDidChangeNotification object:self.feedTV];

}

- (void)submitButtonClick
{
    [self.view endEditing:YES];
    //[ASLoadingView showActivity:self.view];
    [ASURLConnection requestAFNJSon:@{@"user_id":@32,@"content":self.feedTV.text,@"addTime":self.addTime} method:@"renhe.system.settingfeedback" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            [self performSelector:@selector(delayDate) withObject:nil afterDelay:0.5];
           
        }
    } errorBlock:^(NSError *error) {
    }];
    

}
- (void)delayDate
{
    
    //[ASLoadingView hidenActivity:self.view];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)change:(NSNotification *)noti
{
    UITextField *textTF = noti.object;
    NSString *string = textTF.text;
    self.submitButton.enabled = [string isValid];
}
@end
