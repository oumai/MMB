//
//  RePlyContentVC.m
//  Mamabao
//
//  Created by Michael on 15/12/8.
//  Copyright © 2015年 Michael. All rights reserved.
//

/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface RePlyContentModel  : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface RePlyContentModel ()

@end

@implementation RePlyContentModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/
@interface RePlyContentCustomCell : UITableViewCell


@end

@interface RePlyContentCustomCell ()

@property (nonatomic, strong) TTTAttributedLabel *detailLabel;

@end

@implementation RePlyContentCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.detailLabel = [TTTAttributedLabel new];
        self.detailLabel.font = KFontSize(13);
        self.detailLabel.textColor = KHexColor(@"#333333");
        self.detailLabel.lineSpacing = 4;
        self.detailLabel.numberOfLines = 0;
        self.detailLabel.text = @"我是大哥基督教风口浪尖奥斯卡放假肯德基司法鉴定松开立即反馈到健身房看见对方就减肥估计快了估计快了过奖了看见过快乐健康路公交离开过考虑过发生纠纷空间开发进口量";
        [self.contentView addSubview:_detailLabel];
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            //make.bottom.equalTo(self.headerView.mas_bottom).offset(-5);
        }];

    }
    return self;
}





@end


/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "RePlyContentVC.h"

@interface RePlyContentVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UITextField *textTF;
@property (nonatomic, strong) UIButton *sendButton;
@end

@implementation RePlyContentVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"回复详情";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    self.bottomView = [UIView new];
    self.bottomView.frame = CGRectMake(0, CoreHeight-50, CoreWidth, 50);
    self.bottomView.backgroundColor = KHexColor(@"#ffffff");
    [self.view addSubview:_bottomView];
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.layer.cornerRadius = 6;
    self.sendButton.layer.masksToBounds = YES;
    self.sendButton.titleLabel.font = KFontSize(14);
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.sendButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff637e")] forState:UIControlStateNormal];
    [self.sendButton addTarget:self action:@selector(replyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:_sendButton];
    
    self.textTF = [UITextField new];
    self.textTF.layer.cornerRadius = 6;
    self.textTF.layer.masksToBounds = YES;
    self.textTF.layer.borderColor = KHexColor(@"#bbbbbb").CGColor;
    self.textTF.layer.borderWidth = 0.5;
    self.textTF.placeholder = @"回复谁";
    self.textTF.returnKeyType = UIReturnKeySend;
    self.textTF.delegate = self;
    [self.bottomView addSubview:_textTF];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
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
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------

//隐藏键盘手势
-(void)backTap:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
    if(self.view.frame.origin.y == -100+64){
        [UIView animateWithDuration:0.2 animations:^{
            self.view.frame = CGRectMake(0, self.view.frame.origin.y+100, kSCREEN_WIDTH, self.view.frame.size.height);
        }];
    }
}

- (void)sectionButtonClick
{
    
}
- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
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
#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 70)];
    sectionView.backgroundColor = KHexColor(@"#ffffff");
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"circle_3mother"];
    [sectionView addSubview:imageView];
    
    UILabel *sectionLabel = [UILabel new];
    sectionLabel.font = KFontSize(14);
    sectionLabel.textColor = KHexColor(@"#666666");
    sectionLabel.text = @"雪化了";
    [sectionView addSubview:sectionLabel];
   
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sectionView.mas_centerY).offset(0);
        make.left.equalTo(sectionView.mas_left).offset(10);
        make.width.equalTo(40);
        make.height.equalTo(40);
    }];
    
    [sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sectionView.mas_centerY).offset(0);
        make.left.equalTo(imageView.mas_right).offset(10);
        make.width.equalTo(sectionLabel.mas_width);
        make.height.equalTo(14);
    }];

    return sectionView;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    RePlyContentCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[RePlyContentCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (void)replyButtonClick
{
    
}
@end