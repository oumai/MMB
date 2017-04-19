//
//  MessageDetailVC.m
//  Mamabao
//
//  Created by Michael on 15/12/8.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import "MessageDetailVC.h"
#import "RePlyContentVC.h"
@interface MessageDetailVC ()<UITextFieldDelegate>

@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIButton *replyButton;
@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) TTTAttributedLabel *titlteLabel;
@property (nonatomic, strong) TTTAttributedLabel *detailLabel;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UITextField *textTF;
@property (nonatomic, strong) UIButton *sendButton;
@end

@implementation MessageDetailVC


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
    self.title = @"消息详情";
    self.view.backgroundColor = KHexColor(@"#f0f0f0");
    self.user = [[ASUserInfoModel alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = KHexColor(@"#f0f0f0");
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [self readRequest];
   [self makeBottomView];
    
}

- (void)makeBottomView
{
    self.headerView = [[UIView alloc]init];
    self.headerView.layer.cornerRadius = 5;
    self.headerView.layer.masksToBounds = YES;
    self.headerView.layer.borderColor = KHexColor(@"#e0e0e0").CGColor;
    self.headerView.layer.borderWidth = 1;
    self.headerView.frame = CGRectMake(10, 20, CoreWidth-20, 170);
    self.headerView.backgroundColor = KHexColor(@"#ffffff");
    [self.tableView addSubview:_headerView];
    
    
    self.headerImage = [UIImageView new];
    self.headerImage.layer.cornerRadius = 27.5;
    self.headerImage.layer.masksToBounds = YES;
    self.headerImage.image = [UIImage imageNamed:@"circle_3mother"];
    [self.headerView addSubview:_headerImage];
    
      
    self.titlteLabel = [TTTAttributedLabel new];
    self.titlteLabel.font = KFontSize(16);
    self.titlteLabel.textColor = KHexColor(@"#333333");
    self.titlteLabel.text = self.backUserName;
    [self.headerView addSubview:_titlteLabel];
    
    self.line1 = [UIView new];
    self.line1.backgroundColor = KHexColor(@"#cccccc");
    [self.headerView addSubview:_line1];
      
    self.detailLabel = [TTTAttributedLabel new];
    self.detailLabel.font = KFontSize(13);
    self.detailLabel.textColor = KHexColor(@"#333333");
    self.detailLabel.lineSpacing = 4;
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.text = self.backText;
    [self.headerView addSubview:_detailLabel];
    
    
    self.line2 = [UIView new];
    self.line2.backgroundColor = KHexColor(@"#cccccc");
    [self.headerView addSubview:_line2];
    
      
    self.replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.replyButton.layer.cornerRadius = 6;
    self.replyButton.layer.masksToBounds = YES;
    self.replyButton.titleLabel.font = KFontSize(14);
    [self.replyButton setTitle:@"回复" forState:UIControlStateNormal];
    [self.replyButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.replyButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff637e")] forState:UIControlStateNormal];
    [self.replyButton addTarget:self action:@selector(replyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:_replyButton];
    
    self.bottomView = [UIView new];
    self.bottomView.frame = CGRectMake(0, CoreHeight+100, CoreWidth, 50);
    self.bottomView.backgroundColor = KHexColor(@"#ffffff");
    [self.view addSubview:_bottomView];
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.layer.cornerRadius = 6;
    self.sendButton.layer.masksToBounds = YES;
    self.sendButton.titleLabel.font = KFontSize(14);
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.sendButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff637e")] forState:UIControlStateNormal];
    [self.sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:_sendButton];
    
    self.textTF = [UITextField new];
    self.textTF.layer.cornerRadius = 6;
    self.textTF.layer.masksToBounds = YES;
    self.textTF.layer.borderColor = KHexColor(@"#bbbbbb").CGColor;
    self.textTF.layer.borderWidth = 0.5;
    self.textTF.placeholder = @"回复谁";
    self.textTF.returnKeyType = UIReturnKeySend;
    self.textTF.delegate = self;
    self.textTF.font = KFontSize(14);
    [self.bottomView addSubview:_textTF];
    
    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(10);
        make.left.equalTo(self.headerView.mas_left).offset(10);
        make.width.equalTo(55);
        make.height.equalTo(55);
    }];
    
    
    [_titlteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerImage.mas_centerY).offset(0);
        make.left.equalTo(self.headerImage.mas_right).offset(5);
        make.width.equalTo(self.titlteLabel.mas_width);
        make.height.equalTo(16);
    }];
    
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titlteLabel.mas_bottom).offset(10);
        make.left.equalTo(self.titlteLabel.mas_left).offset(0);
        make.right.equalTo(self.headerView.mas_right).offset(-30);
        make.height.equalTo(0.5);
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImage.mas_bottom).offset(5);
        make.left.equalTo(self.headerView.mas_left).offset(10);
        make.right.equalTo(self.headerView.mas_right).offset(-10);
        //make.bottom.equalTo(self.headerView.mas_bottom).offset(-5);
    }];
    
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(10);
        make.left.equalTo(self.detailLabel.mas_left).offset(0);
        make.right.equalTo(self.detailLabel.mas_right).offset(0);
        make.height.equalTo(0.5);
    }];
    
    
    [_replyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line2.mas_bottom).offset(10);
        make.right.equalTo(self.detailLabel.mas_right).offset(0);
        make.width.equalTo(60);
        make.height.equalTo(30);
    }];
    
    
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView.mas_centerY).offset(0);
        make.right.equalTo(self.bottomView.mas_right).offset(-10);
        make.width.equalTo(60);
        make.height.equalTo(32);
    }];
    
    [_textTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView.mas_centerY).offset(0);
        make.left.equalTo(self.bottomView.mas_left).offset(10);
        make.right.equalTo(self.sendButton.mas_left).offset(-20);
        make.height.equalTo(32);
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTap:)];//隐藏键盘手势
    [self.view addGestureRecognizer:tap];

    
}

//隐藏键盘手势
-(void)backTap:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
    if(self.view.frame.origin.y == -100+64)
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.frame = CGRectMake(0, self.view.frame.origin.y+100, kSCREEN_WIDTH, self.view.frame.size.height);
        }];
    }
}

- (void)keyboardChange:(NSNotification *)noti
{
    NSValue *value = [noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [value CGRectValue];
    self.bottomView.frame = CGRectMake(0, rect.origin.y-60, CoreWidth, 60);
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField  //点击键盘调用的方法
{
    
    return YES;
}

- (void)sendButtonClick:(UIButton *)button
{
    NSLog(@"%@",self.backId);
    NSLog(@"discuss_id%@",self.discuss_id);
    NSLog(@"post_id%@",self.post_id);
    if (self.textTF.text.length>0 && [self.discuss_id isValid] && [self.post_id isValid] && [self.backUserId isValid]) {
        
        NSDictionary *jsonDic = @{@"user_id":self.backUserId,
                                  @"backDiscussId":self.discuss_id,
                                  @"post_id":self.post_id,
                                  @"discuss":self.textTF.text,
                                  @"type":@1};
        
        [ASURLConnection requestAFNJSon:jsonDic method:@"renhe.momCircle.postDiscuss" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
            
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                k_yjHUD(@"回复成功", self.view);
            }
            else
            {
                k_yjHUD(@"回复失败", self.view);
            }
        } errorBlock:^(NSError *error) {
            
        }];

    }
    else if (self.textTF.text.length == 0)
    {
        k_yjHUD(@"回复内容不能为空", self.view);
    }
    else if (![self.discuss_id isValid])
    {
        k_yjHUD(@"self.discuss_id 没有效", self.view);
    }
    else if (![self.post_id isValid])
    {
        k_yjHUD(@"self.post_id 没有效", self.view);
    }
}

+ (void)pingLunTieZi
{
    
}
- (void)replyButtonClick:(UIButton *)button
{
    
    [self.textTF becomeFirstResponder];                 //让它成为第一响应者
    
}

- (void)readRequest
{
   
    [ASURLConnection requestAFNJSon:@{@"back_id":self.backId} method:@"renhe.momCircle.readMsgSubmit" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            k_yjHUD(@"未读变已读", self.view)
        }else
        {
             k_yjHUD(@"已读", self.view)
        }
    } errorBlock:^(NSError *error) {
    }];

}

@end
