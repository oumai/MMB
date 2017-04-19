//
//  ArticleDetailVC.m
//  Mamabao
//
//  Created by Michael on 15/11/12.
//  Copyright © 2015年 Michael. All rights reserved.
//
/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface ArticleDetailModel  : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface ArticleDetailModel ()

@end

@implementation ArticleDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface ArticleDetaiCustomCell : UITableViewCell


@end



@interface ArticleDetaiCustomCell ()



@end

@implementation ArticleDetaiCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}





@end


/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "ArticleDetailVC.h"

@interface ArticleDetailVC ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>


@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *hideButton;
@property (nonatomic, assign) NSInteger isCollect;  //是否收藏
@end


@implementation ArticleDetailVC

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
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文章详情";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.user = [[ASUserInfoModel alloc] init];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
    [self.view addSubview:_webView];
    
    
    [self makeUI];
    [self requestData];


}

#pragma mark ------------------------------------------------------------------Self - makeUI------------------------------------------------------------------
- (void)makeUI
{
    
    
    self.hideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hideButton.layer.borderWidth = 0.5;
    self.hideButton.layer.borderColor = KHexColor(@"#999999").CGColor;
    [self.hideButton addTarget:self action:@selector(hideButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.hideButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#f0f0f0")] forState:UIControlStateNormal];
    [self.view addSubview:_hideButton];
    
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareButton.layer.borderWidth = 0.5;
    self.shareButton.layer.borderColor = KHexColor(@"#999999").CGColor;
    [self.shareButton addTarget:self action:@selector(hideButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.shareButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#f0f0f0")] forState:UIControlStateNormal];
    [self.shareButton setImage:[UIImage imageNamed:@"icon_bigshare"] forState:UIControlStateNormal];
    [self.view addSubview:_shareButton];
    
    [_hideButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_centerX).offset(0);
        make.height.equalTo(50);
    }];

    
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.left.equalTo(self.view.mas_centerX).offset(0);
        make.height.equalTo(50);
    }];
    
}

#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------
- (void)hideButtonClick
{
    
    if (self.isCollect == 0) {
        [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],@"news_id":self.news_id,@"type":@0} method:@"jumper.news.collection.removeCollection" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
            
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                self.isCollect = 1;
                [self.hideButton setImage:[UIImage imageNamed:@"icon_bignotlike"] forState:UIControlStateNormal];
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
        [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],@"news_id":self.news_id,@"type":@0} method:@"jumper.news.collection.addCollection" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
            
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                self.isCollect = 0;
                [self.hideButton setImage:[UIImage imageNamed:@"icon_biglike"] forState:UIControlStateNormal];
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
- (void)shareButtonClick
{
    
}
- (void)sectionButtonClick
{
    
}
- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 45)];
    sectionView.backgroundColor = KHexColor(@"#ffffff");
    UILabel *sectionLabel = [UILabel new];
    sectionLabel.textColor = KHexColor(@"#666666");
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = sectionView.frame;
    [button addTarget:self action:@selector(sectionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [sectionView addSubview:button];
    return sectionView;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    ArticleDetaiCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[ArticleDetaiCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark ------------------------------------------------------------------ASURLConnection-----------------------------------------------------------
- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{@"news_id":self.news_id,@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId]} method:@"jumper.news.news.newsDetail" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            self.dataDic = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"][0];
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.dataDic objectForKey:@"newsUrl"]]]];
            [self backData];
            [_tableView reloadData];
        }
    } errorBlock:^(NSError *error) {
    }];
}

- (void)backData
{
    self.isCollect = [[self.dataDic objectForKey:@"isCollect"] intValue];
    if (self.isCollect == 1) //未收藏
    {
        [self.hideButton setImage:[UIImage imageNamed:@"icon_bignotlike"] forState:UIControlStateNormal];
    }
    else if (self.isCollect == 0)
    {
        [self.hideButton setImage:[UIImage imageNamed:@"icon_biglike"] forState:UIControlStateNormal];
    }
}
@end



