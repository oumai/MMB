//
//  ShiTieZi.m
//  Mamabao
//
//  Created by Michael on 16/1/13.
//  Copyright © 2016年 Michael. All rights reserved.
//

/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface ShiTieZiMoel  : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userimg;
@property (nonatomic, strong) NSString *discuss;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface ShiTieZiMoel ()

@end

@implementation ShiTieZiMoel

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
            self.userName = [dic objectForKey:@"username"];
        }
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/

@interface ShiTieZiCustomCell : UITableViewCell

@property (nonatomic, strong) ShiTieZiMoel *shiTieModel;
@end



@interface ShiTieZiCustomCell ()

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *pingLunLabel;
@property (nonatomic, strong) UIButton *pingLunButton;

@end

@implementation ShiTieZiCustomCell

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
        self.nameLabel.font = KFontSize(13);
        self.nameLabel.textColor = KHexColor(@"#333333");
        //self.nameLabel.text = @"王二狗";
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

- (void)setShiTieModel:(ShiTieZiMoel *)shiTieModel
{
    if (nil == shiTieModel) {
        return;
    }
    
    NSLog(@"-------------%@",shiTieModel.userName);
    self.nameLabel.text = shiTieModel.userName;
    self.pingLunLabel.text = shiTieModel.discuss;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:shiTieModel.userimg] placeholderImage:nil];
}

@end


/*-----------------------------------------------------------------------C-------------------------------------------*/
#import "ShiTieZi.h"

@interface ShiTieZi ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *xiangQingdataDic;
@property (nonatomic, strong) NSMutableArray *pingLunArray;
@property (nonatomic, strong) UIView *bottomView;               //发送
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UITextField *textTF;
@property (nonatomic, strong) UIWebView *webView;               //html
@property (nonatomic, strong) UIButton *collectButton;
@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, assign) NSInteger isCollect;
@end

@implementation ShiTieZi

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
    //[self makeUI];
    [self requestDta];
}

#pragma mark ------------------------------------------------------------------Self makeUI -------------------------------------------------------------------
- (void)makeUI
{
    
    
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

#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_pingLunArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"TieZiDetailCustomCell";
    ShiTieZiCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[ShiTieZiCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.shiTieModel = _pingLunArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


#pragma mark -------------------------------------------------------------------ASURLConnectionDelegate--------------------------------------------------------------------

- (void)requestDta
{
       //评论列表
    [ASURLConnection requestAFNJSon:@{@"post_id":@1,@"pageNum":@1,@"pageSize":@3} method:@"renhe.momCircle.postPageQuery" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            //if (dataArr.count >0)
            
            {
                self.xiangQingdataDic = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"][0];
                NSArray *dataArrP = [self.xiangQingdataDic objectForKey:@"records"];
                for (NSDictionary *dic in dataArrP)
                {
                    ShiTieZiMoel *tieZi = [[ShiTieZiMoel alloc] initWithDictionary:dic];
                    [self.pingLunArray addObject:tieZi];
                }
                
                NSLog(@"+++++++++++++%ld",_pingLunArray.count);
                NSLog(@"+++++++++++++%@",_pingLunArray);

                [_tableView reloadData];
            }
        }
    } errorBlock:^(NSError *error) {
    }];
    
}
@end


