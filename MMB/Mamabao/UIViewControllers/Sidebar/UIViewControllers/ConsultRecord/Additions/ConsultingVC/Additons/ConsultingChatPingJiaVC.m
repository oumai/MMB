//
//  ConsultingChatPingJiaVC.m
//  Mamabao
//
//  Created by Michael on 15/11/16.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import "ConsultingChatPingJiaVC.h"

@interface ConsultingChatPingJiaVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView*headerView;
@property (nonatomic, strong) UIView *fontView;
@property (nonatomic, strong) UIImageView *mediumImage;
@property (nonatomic, strong) UIImageView *goodImage;
@property (nonatomic, strong) UIImageView *madImage;
@property (nonatomic, strong) UIButton *mediumButton;
@property (nonatomic, strong) UIButton *madButton;
@property (nonatomic, strong) UIButton *goodButton;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) PlaceholderTextView *textTV;
@property (nonatomic, strong) TTTAttributedLabel *limitLabel;
@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) NSString *entityGrade;

@end

@implementation ConsultingChatPingJiaVC
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

    self.title = @"评价";
    self.user = [[ASUserInfoModel alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = KHexColor(@"#f5f5f5");
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [self makeUI];
}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------

- (void)submitButtonClik
{
     NSDictionary *json = @{@"constant_id":[NSNumber numberWithInteger:self.detailId],
                            @"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],
                            @"satisfied":self.entityGrade,
                            @"content":self.textTV.text,
                            @"type":@0};
    [ASURLConnection requestAFNJSon:json method:kAddCommentToDoctor view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
        }
        else
        {
            
        }
    } errorBlock:^(NSError *error) {
    }];
}

- (void)madButtonClick  //月子中心评价
{
    [self.madButton setTitleColor:KHexColor(@"#ff657f") forState:UIControlStateNormal];
    [self.mediumButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.goodButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    self.entityGrade = @"0";
}
- (void)mediumButtonClick {
    [self.madButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.mediumButton setTitleColor:KHexColor(@"#ff657f") forState:UIControlStateNormal];
    [self.goodButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    self.entityGrade = @"1";
    
}
- (void)goodButtonClick
{
    [self.madButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.mediumButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.goodButton setTitleColor:KHexColor(@"#ff657f") forState:UIControlStateNormal];
    self.entityGrade = @"2";
}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------

- (void)makeUI
{
    self.entityGrade = @"2";
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CoreWidth, CoreHeight)];
    self.headerView.backgroundColor = KHexColor(@"#f5f5f5");
    [self.tableView addSubview:_headerView];
    
    self.fontView = [UIView new];
    self.fontView.backgroundColor = KHexColor(@"#ffffff");
    self.fontView.layer.cornerRadius = 7;
    self.fontView.layer.masksToBounds = YES;
    self.fontView.layer.borderColor = KHexColor(@"#e6e6e6").CGColor;
    self.fontView.layer.borderWidth = 0.5;
    [self.headerView addSubview:_fontView];
    
       
    self.mediumImage = [UIImageView new];
    self.mediumImage.image = [UIImage imageNamed:@"evaluation"];
    [self.fontView addSubview:_mediumImage];
    
  
    
    self.mediumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mediumButton.titleLabel.font = KFontSize(14);
    self.mediumButton.contentEdgeInsets = UIEdgeInsetsMake(30, 0, 0, 0);
    [self.mediumButton setTitle:@"满意" forState:UIControlStateNormal];
    [self.mediumButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.mediumButton addTarget:self action:@selector(mediumButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.fontView addSubview:_mediumButton];
    
      
    self.goodImage = [UIImageView new];
    self.goodImage.image = [UIImage imageNamed:@"evaluation3"];
    [self.fontView addSubview:_goodImage];
    
       
    self.goodButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.goodButton.titleLabel.font = KFontSize(14);
    self.goodButton.contentEdgeInsets = UIEdgeInsetsMake(30, 0, 0, 0);
    [self.goodButton setTitle:@"很满意" forState:UIControlStateNormal];
    [self.goodButton setTitleColor:KHexColor(@"#ff627d") forState:UIControlStateNormal];
    [self.goodButton addTarget:self action:@selector(goodButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.fontView addSubview:_goodButton];
    
      
    
    
    self.madImage = [UIImageView new];
    self.madImage.image = [UIImage imageNamed:@"evaluation2"];
    [self.fontView addSubview:_madImage];
    
      
    
    self.madButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.madButton.titleLabel.font = KFontSize(14);
    self.madButton.contentEdgeInsets = UIEdgeInsetsMake(30, 0, 0, 0);
    [self.madButton setTitle:@"不满意" forState:UIControlStateNormal];
    [self.madButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.madButton addTarget:self action:@selector(madButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.fontView addSubview:_madButton];
    

    
    self.textTV = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(7, 100, CoreWidth-24, 120)];
    self.textTV.placeholder = @"请输入评价内容";
    self.textTV.layer.cornerRadius = 7;
    self.textTV.layer.masksToBounds = YES;
    self.textTV.layer.borderColor = KHexColor(@"#cbcbcb").CGColor;
    self.textTV.layer.borderWidth = 0.5;
    [self.fontView addSubview:_textTV];
    
    
    self.limitLabel = [TTTAttributedLabel new];
    self.limitLabel.textColor = KHexColor(@"#999999");
    self.limitLabel.font = KFontSize(13);
    self.limitLabel.text = [NSString stringWithFormat:@"%ld/160字",self.textTV.text.length];
    [self.fontView addSubview:_limitLabel];
    
      
    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitButton.titleLabel.font = KFontSize(15);
    self.submitButton.layer.cornerRadius = 8;
    self.submitButton.layer.masksToBounds = YES;
    [self.submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.submitButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff875c")] forState:UIControlStateNormal];
    [self.submitButton addTarget:self action:@selector(submitButtonClik) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:_submitButton];
    
    [_fontView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(10);
        make.left.equalTo(self.headerView.mas_left).offset(5);
        make.right.equalTo(self.headerView.mas_right).offset(-5);
        make.height.equalTo(300);
    }];
    
    [_mediumImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.fontView.mas_centerX).offset(0);
        make.top.equalTo(self.fontView.mas_top).offset(20);
        make.width.equalTo(30);
        make.height.equalTo(30);
        
    }];
    [_mediumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mediumImage.mas_centerX).offset(0);
        make.centerY.equalTo(self.mediumImage.mas_centerY).offset(20);
        make.width.equalTo(50);
        make.height.equalTo(70);
    }];
    [_goodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.fontView.mas_centerX).offset(-CoreWidth/4);
        make.top.equalTo(self.fontView.mas_top).offset(20);
        make.width.equalTo(30);
        make.height.equalTo(30);
        
    }];
    
    [_goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.goodImage.mas_centerX).offset(0);
        make.centerY.equalTo(self.goodImage.mas_centerY).offset(20);
        make.width.equalTo(50);
        make.height.equalTo(70);
    }];
    [_madImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.fontView.mas_centerX).offset(CoreWidth/4);
        make.top.equalTo(self.fontView.mas_top).offset(20);
        make.width.equalTo(30);
        make.height.equalTo(30);
        
    }];
    [_madButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.madImage.mas_centerX).offset(0);
        make.centerY.equalTo(self.madImage.mas_centerY).offset(20);
        make.width.equalTo(50);
        make.height.equalTo(70);
    }];
    [_limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.fontView.mas_right).offset(-15);
        make.bottom.equalTo(self.fontView.mas_bottom).offset(-95);
        make.width.equalTo(self.limitLabel.mas_width);
        make.height.equalTo(13);
    }];
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fontView.mas_bottom).offset(20);
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.left.equalTo(self.headerView.mas_left).offset(40);
        make.right.equalTo(self.headerView.mas_right).offset(-40);
        make.height.equalTo(50);
    }];
    

}
@end
