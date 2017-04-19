//
//  TieZiDetailVC.m
//  Mamabao
//
//  Created by Michael on 15/11/13.
//  Copyright © 2015年 Michael. All rights reserved.
//
/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface TieZiDetailModel  : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *userimg;
@property (nonatomic, strong) NSString *discuss;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface TieZiDetailModel ()

@end

@implementation TieZiDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([dic objectForKey:@"discuss"]) {
            self.discuss = [dic objectForKey:@"discuss"];
        }
        if ([dic objectForKey:@"userimg"]) {
            self.userimg = [dic objectForKey:@"userimg"];
        }
        if ([dic objectForKey:@"username"]) {
            self.username = [dic objectForKey:@"username"];
        }
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface TieZiDetailCustomCell : UITableViewCell

@property (nonatomic, strong) TieZiDetailModel *tieModel;
@property (nonatomic, strong) void(^commentBlock)();
@end



@interface TieZiDetailCustomCell ()

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *pingLunLabel;
@property (nonatomic, strong) UIButton *pingLunButton;

@end

@implementation TieZiDetailCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellView = [UIView new];
        self.cellView.backgroundColor = KHexColor(@"#ffffff");
        self.cellView.layer.cornerRadius = 5;
        self.cellView.layer.masksToBounds = YES;
        self.cellView.layer.borderColor = KHexColor(@"#e6e6e6").CGColor;
        self.cellView.layer.borderWidth = 1;
        [self.contentView addSubview:_cellView];
        
        
        
        self.iconImage = [UIImageView new];
        self.iconImage.layer.cornerRadius = 15;
        self.iconImage.layer.masksToBounds = YES;
        self.iconImage.image = [UIImage imageNamed:@"circle_12mothe"];
        [self.contentView addSubview:_iconImage];
        
        
        self.nameLabel = [UILabel new];
        self.nameLabel.textColor = KHexColor(@"#333333");
        self.nameLabel.font = KFontSize(13);
        self.nameLabel.text = @"王二狗";
        [self.contentView addSubview:_nameLabel];
        
        
        self.pingLunLabel = [UILabel new];
        self.pingLunLabel.font = KFontSize(13);
        self.pingLunLabel.textColor = KHexColor(@"#999999");
        self.pingLunLabel.text = @"服务周到，细心呵护，很棒的月子中心";
        [self.contentView addSubview:_pingLunLabel];
        
        self.pingLunButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.pingLunButton.titleLabel.font = KFontSize(15);
        self.pingLunButton.layer.cornerRadius = 5;
        self.pingLunButton.layer.masksToBounds = YES;
        [self.pingLunButton addTarget:self action:@selector(commentButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.pingLunButton setBackgroundImage:[UIImage imageNamed:@"circle_6mother"] forState:UIControlStateNormal];
        [self.contentView addSubview:_pingLunButton];
        
        
        [_cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(3);
            make.left.equalTo(self.contentView.mas_left).offset(6);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-3);
            make.right.equalTo(self.contentView.mas_right).offset(-6);
            
        }];

        
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.width.equalTo(30);
            make.height.equalTo(30);
        }];
        
        
        
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImage.mas_centerY).offset(0);
            make.left.equalTo(self.iconImage.mas_right).offset(20);
            make.width.equalTo(self.nameLabel.mas_width);
            make.height.equalTo(13);
        }];
        
        
        
        [_pingLunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(7);
            make.left.equalTo(self.nameLabel.mas_left).offset(0);
            make.width.equalTo(self.pingLunLabel.mas_width);
            make.height.equalTo(15);
            
        }];
        
      
        
        [_pingLunButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel.mas_centerY).offset(0);
            make.right.equalTo(self.cellView.mas_right).offset(-15);
            make.width.equalTo(15);
            make.height.equalTo(13);
        }];
        
        
    }
    return self;
}

- (void)commentButtonClick
{
    if (self.commentBlock) {
        self.commentBlock();
    }
}

- (void)setTieModel:(TieZiDetailModel *)tieModel
{
    if (nil == tieModel) {
        return;
    }
    NSLog(@"--------------------------%@",tieModel.username);//名字中有问号   ，解析不了
    self.nameLabel.text = tieModel.username;
    self.pingLunLabel.text = tieModel.discuss;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:tieModel.userimg] placeholderImage:nil];
}

@end


/*-----------------------------------------------------------------------C-------------------------------------------*/
#import "TieZiDetailVC.h"

@interface TieZiDetailVC ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *xiangQingdataDic;
@property (nonatomic, strong) NSMutableArray *pingLunArray;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UIImageView *indroduceImage;
@property (nonatomic, strong) UIView *bottomView;               //发送
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UITextField *textTF;
@property (nonatomic, strong) UIWebView *webView;               //html
@property (nonatomic, strong) TTTAttributedLabel *nameLabel;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) UIButton *collectButton;
@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, assign) NSInteger isCollect;
@end

@implementation TieZiDetailVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {

        self.collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.collectButton setFrame:CGRectMake(0, 0, 20, 14)];
        [self.collectButton setBackgroundImage:[UIImage imageNamed:@"notcollect"] forState:UIControlStateNormal];
        [self.collectButton addTarget:self action:@selector(collectButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:_collectButton];
        self.navigationItem.rightBarButtonItem = right;
        right.tintColor = KHexColor(@"#ffffff");
        
        
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
    self.title = @"帖子详情";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.user = [[ASUserInfoModel alloc]init];
    self.pingLunArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = KHexColor(@"#ffffff");
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 80;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
    [self makeUI];
    [self requestDta];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];

}
#pragma mark ------------------------------------------------------------------Self makeUI -------------------------------------------------------------------
- (void)makeUI
{

    self.webView = [[UIWebView alloc] init];
    CGFloat sizeHeight = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    self.webView.delegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.frame = CGRectMake(0, 0, CoreWidth, sizeHeight);
    self.tableView.tableHeaderView = self.webView;
    
    self.bottomView = [UIView new];
    self.bottomView.frame = CGRectMake(0, CoreHeight-50, CoreWidth, 50);
    self.bottomView.backgroundColor = KHexColor(@"#ebebeb");
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
    self.textTF.placeholder = @"评论";
    self.textTF.returnKeyType = UIReturnKeySend;
    self.textTF.delegate = self;
    self.textTF.font = KFontSize(14);
    self.textTF.backgroundColor = KHexColor(@"#ffffff");
    [self.bottomView addSubview:_textTF];
    
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
        make.height.equalTo(35);
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
            self.view.frame = CGRectMake(0, self.view.frame.origin.y, kSCREEN_WIDTH, self.view.frame.size.height);
        }];
    }
}

- (void)keyboardChange:(NSNotification *)noti
{
    NSValue *value = [noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [value CGRectValue];
    self.bottomView.frame = CGRectMake(0, rect.origin.y-50, CoreWidth, 50);
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendButtonClick:nil];
    return YES;
}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------

- (void)sendButtonClick:(UIButton *)button
{
    if (self.textTF.text.length>0 && [self.post_id isValid])
    {
        
        NSDictionary *jsonDic = @{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],
                                  @"post_id":self.post_id,
                                  @"discuss":self.textTF.text,
                                  @"type":@0};  //0 是评价 1：是回复
        
        [ASURLConnection requestAFNJSon:jsonDic method:@"renhe.momCircle.postDiscuss" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
            
            self.textTF.text = nil;
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
            {
                [self.view endEditing:YES];

                k_yjHUD(@"评论成功", self.view);
                [self requestDta];
                [_tableView reloadData];
                
            }
            else
            {
                k_yjHUD(@"评论失败", self.view);
            }
            
        } errorBlock:^(NSError *error) {
            
        }];
        
    }
    else if (self.textTF.text.length == 0)
    {
        k_yjHUD(@"回复内容不能为空", self.view);
    }
      else if (![self.post_id isValid])
    {
        k_yjHUD(@"self.post_id 没有效", self.view);
    }
}

- (void)collectButtonClick
{
    //收藏帖子
    
    if (self.isCollect == 0) {
        [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],@"news_id":self.post_id,@"type":@1} method:@"jumper.news.collection.removeCollection" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
            
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                self.isCollect = 1;
                [self.collectButton setBackgroundImage:[UIImage imageNamed:@"notcollect"] forState:UIControlStateNormal];
                k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            }
            else
            {
                k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            }
        } errorBlock:^(NSError *error) {
        }];
        
    }
    else if(self.isCollect == 1)
    {
        [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],@"news_id":self.post_id,@"type":@1} method:@"jumper.news.collection.addCollection" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
            
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                self.isCollect = 0;
                [self.collectButton setBackgroundImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
                k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            }
            else
            {
                k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            }
        } errorBlock:^(NSError *error) {
        }];
        
    }

}


#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 30)];
    sectionView.backgroundColor =  KHexColor(@"#ffffff");
    
    
    UILabel *sectionLabel = [UILabel new];
    sectionLabel.textColor = KHexColor(@"#4a4a4a");
    sectionLabel.font = KFontSize(14);
    sectionLabel.text = [NSString stringWithFormat:@"%lu评论",(unsigned long)[_pingLunArray count]];
    [sectionView addSubview:sectionLabel];
    
    UIImageView *lineImage = [UIImageView new];
    lineImage.image = [UIImage imageNamed:@"xian_buttom"];
    [sectionView addSubview:lineImage];
    
    [sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sectionView.mas_top).offset(10);
        make.left.equalTo(sectionView.mas_left).offset(5);
        make.width.equalTo(sectionLabel.mas_width);
        make.height.equalTo(15);
    }];
    
    [lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(sectionView.mas_bottom).offset(0);
        make.left.equalTo(sectionView.mas_left).offset(5);
        make.right.equalTo(sectionView.mas_right).offset(-5);
        make.height.equalTo(5);
    }];
    return sectionView;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_pingLunArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"TieZiDetailCustomCell";
    TieZiDetailCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[TieZiDetailCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.tieModel = _pingLunArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
}


#pragma mark -------------------------------------------------------------------ASURLConnectionDelegate--------------------------------------------------------------------

- (void)requestDta
{
    //帖子详情
    [ASURLConnection requestAFNJSon:@{@"post_id":self.post_id,@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId]} method:@"renhe.momCircle.postDetail" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            self.xiangQingdataDic = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"][0];
            [self backData];
            [_tableView reloadData];
        }
    } errorBlock:^(NSError *error) {
        
    }];
    
    
    //评论列表
    [ASURLConnection requestAFNJSon:@{@"post_id":self.post_id,@"pageNum":@1,@"pageSize":@100} method:@"renhe.momCircle.postPageQuery" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];

            if (dataArr.count >0) {
                self.xiangQingdataDic = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"][0];
                NSArray *dataArrP = [self.xiangQingdataDic objectForKey:@"records"];
                for (NSDictionary *dic in dataArrP)
                {
                    TieZiDetailModel *tieZi = [[TieZiDetailModel alloc] initWithDictionary:dic];
                    [self.pingLunArray addObject:tieZi];
                }
                [_tableView reloadData];
            }
        }
    } errorBlock:^(NSError *error) {
    }];

}
- (void)backData
{
   
    self.nameLabel.text = [self.xiangQingdataDic objectForKey:@"username"];
    self.titleLabel.text = [self.xiangQingdataDic objectForKey:@"title"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.xiangQingdataDic objectForKey:@"context"]]]];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[self.xiangQingdataDic objectForKey:@"userImg"]] placeholderImage:nil];
    self.isCollect =[[self.xiangQingdataDic objectForKey:@"favourite"] integerValue];
    
    if (self.isCollect == 1) {

        [self.collectButton setBackgroundImage:[UIImage imageNamed:@"notcollect"] forState:UIControlStateNormal];


    }
    else
    {
        [self.collectButton setBackgroundImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    }
}
@end





