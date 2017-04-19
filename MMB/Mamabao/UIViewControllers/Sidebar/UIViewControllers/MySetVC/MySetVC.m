//
//  MySetVC.m
//  Mamabao
//
//  Created by Michael on 15/11/10.
//  Copyright © 2015年 Michael. All rights reserved.
//
/*-----------------------------------------------------------------------C-------------------------------------------*/
#import "MySetVC.h"
#import "ASPhotoView.h"
#import "UIView+ASPhotoCategory.h"
#import "QBImagePickerController.h"
#import "UIImage+Image.h"

#import "ASChoicePhotoView.h" //图片选择
#import "ASSecondView.h"

#import "DateWYPopView.h" //弹时间框
@interface MySetVC ()<UITextFieldDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,WYPopoverControllerDelegate,ASChoicePhotoViewDelegate>

@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *sectionView;
@property (nonatomic, strong) UILabel *sectionLabel;
@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, strong) UIImageView *sectionImage;
@property (nonatomic, strong) UIButton *iconButton;
@property (nonatomic, strong) UIActionSheet *sexAction;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel2;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel3;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel4;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel5;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel6;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel7;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel8;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel9;
@property (nonatomic, strong) TTTAttributedLabel *titleLabelXB;

@property (nonatomic, strong) UITextField *detailTF;
@property (nonatomic, strong) UITextField *detailTF2;
@property (nonatomic, strong) UITextField *detailTF3;
@property (nonatomic, strong) UITextField *detailTF4;
@property (nonatomic, strong) UITextField *detailTF5;
@property (nonatomic, strong) UITextField *detailTF6;
@property (nonatomic, strong) UITextField *detailTF7;
@property (nonatomic, strong) UITextField *detailTF8;
@property (nonatomic, strong) UITextField *detailTF9;
@property (nonatomic, strong) UITextField *detailTFXB;

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *line0;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *line3;
@property (nonatomic, strong) UIView *line4;
@property (nonatomic, strong) UIView *line5;
@property (nonatomic, strong) UIView *line6;
@property (nonatomic, strong) UIView *line7;
@property (nonatomic, strong) UIView *line8;
@property (nonatomic, strong) UIView *line9;
@property (nonatomic, strong) UIView *line10;

@property (nonatomic, strong) ASChoicePhotoView *choicePhotoView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic , strong) WYPopoverController *simanPopoverController;
@property (nonatomic, strong) UIButton *zhuangTaiButton;
@property (nonatomic, strong) UIButton *yuChanQiButton;

@property (nonatomic, strong) NSDictionary *dataDic;    //reuqest
@property (nonatomic, assign) NSInteger statue;
@property (nonatomic, strong) NSString *currentIdentity;//1辣妈 0孕妈
@property (nonatomic, assign) NSInteger baby_sex;       //1女   0男
@property (nonatomic, assign) BOOL isKnow;

@end

@implementation MySetVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.title = @"我";
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightClick)];
        self.navigationItem.rightBarButtonItem = right;
        right.tintColor = KHexColor(@"#ffffff");
    }
    
    return self;
}

- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightClick {
    
   
    if (![[self.user getUserMessageFromLocation].userNickname isEqualToString:@""] && [NSString isBlankString:self.detailTF.text] == YES) {
        k_NSlogHUD(@"昵称不能为空")
    }else if(((self.detailTF.text.length<1||self.detailTF.text.length>17))&&![[self.user getUserMessageFromLocation].userNickname isEqualToString:@""]){
        k_NSlogHUD(@"请输入2~16字符昵称");
    }else if ((self.detailTF2.text.length<2||self.detailTF2.text.length>6)){
        k_NSlogHUD(@"请输入正确姓名");
    }else if([self.detailTF4.text integerValue] < 16  || [self.detailTF4.text integerValue] > 45){
        k_NSlogHUD(@"请输入正确年龄(16~45)");
    }else if (![[self.user getUserMessageFromLocation].contactPhone isEqualToString:@""] && [NSString isBlankString:self.detailTF3.text] == YES){
        k_NSlogHUD(@"联系电话不能为空")
    }else if([NSString validateMobile:self.detailTF3.text] ==NO && ![[self.user getUserMessageFromLocation].contactPhone isEqualToString:@""]){
        k_NSlogHUD(@"请输入正确电话")
    }else if([[self.user getUserMessageFromLocation].height integerValue] != 0 && [NSString isBlankString:self.detailTF5.text] == YES){
        k_NSlogHUD(@"身高不能为空")
    }else if([[self.user getUserMessageFromLocation].weight integerValue] != 0 && [NSString isBlankString:self.detailTF6.text] == YES){
        k_NSlogHUD(@"体重不能为空")
    }else
    {
        [self commitInfo];
    }
    
}


-(void)commitInfo{
    NSDictionary *json = nil;
    if ([self.currentIdentity  intValue]== 0)   //怀孕
    {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        NSString *dateStr = nil;
        
        
        //知道预产期
        
        json = @{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],
                 @"nick_name":self.detailTF.text,
                 @"real_name":[self.detailTF2.text stringByReplacingOccurrencesOfString:@" " withString:@""],
                 @"age":[self.detailTF4.text stringByReplacingOccurrencesOfString:@" " withString:@""],
                 @"mobile":[self.detailTF3.text stringByReplacingOccurrencesOfString:@" " withString:@""],
                 @"province":@0,
                 @"city":@0,
                 @"height":self.detailTF5.text,
                 @"weight":[NSNumber numberWithInteger:[self.detailTF6.text integerValue]],
                 @"address":self.detailTF7.text,
                 @"statue":@0,
                 @"expect_date":self.detailTF9.text,
                 @"last_period":@"",
                 @"id_card":@""};
        
        
        
    }
    else  if ([self.currentIdentity  intValue]== 1)                            //辣妈
    {
        json = @{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],
                 @"nick_name":self.detailTF.text,
                 @"real_name":[self.detailTF2.text stringByReplacingOccurrencesOfString:@" " withString:@""],
                 @"age":[self.detailTF4.text stringByReplacingOccurrencesOfString:@" " withString:@""],
                 @"mobile":[self.detailTF3.text stringByReplacingOccurrencesOfString:@" " withString:@""],
                 @"province":@0,
                 @"city":@0,
                 @"height":self.detailTF5.text,
                 @"weight":[NSNumber numberWithInteger:[self.detailTF6.text integerValue]],
                 @"address":self.detailTF7.text,
                 @"statue":@1,
                 @"baby_birthday":self.detailTF9.text,
                 @"baby_sex":[NSNumber numberWithInteger:self.baby_sex],
                 @"id_card":@""};
        
    }
    
    
    else if ([self.currentIdentity  intValue]== 2)                  //不知道预产期
    {
        json = @{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],
                 @"nick_name":self.detailTF.text,
                 @"real_name":[self.detailTF2.text stringByReplacingOccurrencesOfString:@" " withString:@""],
                 @"age":[self.detailTF4.text stringByReplacingOccurrencesOfString:@" " withString:@""],
                 @"mobile":[self.detailTF3.text stringByReplacingOccurrencesOfString:@" " withString:@""],
                 @"province":@0,
                 @"city":@0,
                 @"height":self.detailTF5.text,
                 @"weight":[NSNumber numberWithInteger:[self.detailTF6.text integerValue]],
                 @"address":self.detailTF7.text,
                 @"statue":@0,
                 @"expect_date":@"",
                 @"last_period":self.detailTF9.text,
                 @"id_card":@""};
        
    }

    
    [ASLoadingView showActivity:self.view];
    [ASURLConnection requestAFNJSon:json method:@"jumper.user.information.update" view:nil version:@"" completeBlock:^(NSData *data, id responseObject) {
        
        [ASLoadingView hidenActivity:self.view];
        
        if ([[ASURLConnection getMsg:responseObject]isEqual:@1]) {
            
            self.user = [ASUserInfoModel objectWithKeyValues:AFNdata[0]];
            self.user.isLogin = YES;
            [self.user saveMessageToLocation];
            if ([self.currentIdentity intValue] == 0) {
                NSUserDefaults *userdefault = NSUserDefaultsInstance;
                [userdefault setObject:[self.user getUserMessageFromLocation].userExpectConfindent forKey:userDate];
            }else
            {
                NSUserDefaults *userdefault = NSUserDefaultsInstance;
                [userdefault setObject:[self.user getUserMessageFromLocation].userExpectConfindent forKey:userBabyDate];
            }
            
            /**修改预产期或者宝宝生日通知**/
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshDate" object:nil];
            
            k_NSlogHUD([ASURLConnection getMessage:responseObject])
            
            double delayTime = 1.0;
            __block UIViewController *bself = self;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime *NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^{
                [bself.navigationController popViewControllerAnimated:YES];
            });
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject])
        }
    } errorBlock:^(NSError *error) {
        [ASLoadingView hidenActivity:self.view];
    }];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.menuController.navigationController.navigationBar.hidden = NO;
    if ([self.user getUserMessageFromLocation].isLogin == YES)
    {
       [self.sectionImage sd_setImageWithURL:[NSURL URLWithString:[[self.user getUserMessageFromLocation].userImg stringByReplacingOccurrencesOfString:@" " withString:@""]] placeholderImage:[UIImage imageNamed:@"photo_ring"]];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NavigationBarTitleColor
    self.navigationController.navigationBar.hidden = NO;
    self.menuController.panEnabel = NO;

    
    //数据源
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MyList" ofType:@"plist"];
//    self.dataArray = [[[NSArray alloc] initWithContentsOfFile:plistPath]objectAtIndex:0];
    self.isKnow = YES;
    self.user = [[ASUserInfoModel alloc] init];
    self.imageArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [self makeHeaderView];
    
    
    self.zhuangTaiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.zhuangTaiButton addTarget:self action:@selector(actionSheet) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:_zhuangTaiButton];
    
    [_zhuangTaiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.detailTF8);
    }];
    
    self.yuChanQiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.yuChanQiButton addTarget:self action:@selector(yuChanQiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:_yuChanQiButton];
    
    [_yuChanQiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.detailTF9);
    }];
    
    self.choicePhotoView = [[ASChoicePhotoView alloc]initWithFrame:self.view.frame];
    self.choicePhotoView.delegate = self;//delegate

   [self requestData];
    
}
#pragma mark -------------------------------------------------------------------  ASURLConnection -----------------------------------------------------------------
- (void)requestData
{
    
    [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId]} method:@"jumper.user.information.get" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            self.dataDic = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"][0];
            [self backData];
            self.user = [ASUserInfoModel objectWithKeyValues:AFNdata[0]];
            self.user.isLogin = YES;
            [self.user saveMessageToLocation];
            [_tableView reloadData];
        }
        
    } errorBlock:^(NSError *error){
    }];
}


- (void)backData
{
    
    self.detailTF.text = [self.dataDic objectForKey:@"nick_name"];
    self.detailTF2.text = [self.dataDic objectForKey:@"realname"];
    self.detailTF3.text = [self.dataDic objectForKey:@"mobile"];
    self.detailTF4.text = [[self.dataDic objectForKey:@"age"] stringValue];
    self.detailTF5.text = [self.dataDic objectForKey:@"height"];
    self.detailTF6.text = [[self.dataDic objectForKey:@"weight"]stringValue];
    self.detailTF7.text = [self.dataDic objectForKey:@"address"];
    self.detailTF8.text = [[self.dataDic objectForKey:@"status"]stringValue];
    self.baby_sex = [[self.dataDic objectForKey:@"baby_sex"] intValue];
    self.currentIdentity = [self.dataDic objectForKey:@"currentIdentity"];
    [self.sectionImage sd_setImageWithURL:[NSURL URLWithString:[self.dataDic objectForKey:@"user_img"]] placeholderImage:nil];
    
    if ([self.currentIdentity intValue] ==1) {
        
        self.detailTF8.text = @"已有宝宝";
        self.titleLabel9.text = @"宝宝生日:";
        
        self.line10 = [UIView new];                          ///10
        self.line10.backgroundColor = KHexColor(@"#e4e4e4");
        [self.headerView addSubview:_line10];
        
        self.titleLabelXB = [TTTAttributedLabel new];
        self.titleLabelXB.textColor = KHexColor(@"#666666");
        self.titleLabelXB.font = KFontSize(14);
        self.titleLabelXB.text = @"宝宝性别:";
        [self.headerView addSubview:_titleLabelXB];
        
        self.detailTFXB = [UITextField new];
        self.detailTFXB.textColor = KHexColor(@"#666666");
        self.detailTFXB.font = KFontSize(14);
        self.detailTFXB.textAlignment = NSTextAlignmentRight;
        self.detailTFXB.delegate = self;
        [self.headerView addSubview:_detailTFXB];
        
        [_line10 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerView.mas_top).offset(45*10);
            make.left.equalTo(self.headerView.mas_left).offset(15);
            make.right.equalTo(self.headerView.mas_right).offset(-15);
            make.height.equalTo(0.5);
        }];
        
        
        [_titleLabelXB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.line10.mas_centerY).offset(-22.5);
            make.left.equalTo(self.headerView.mas_left).offset(30);
            make.width.equalTo(self.titleLabelXB.mas_width);
            make.height.equalTo(14);
        }];
        
        
        [_detailTFXB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabelXB.mas_centerY).offset(0);
            make.right.equalTo(self.headerView.mas_right).offset(-15);
            make.width.equalTo(150);
            make.height.equalTo(30);
        }];
        
        if (self.baby_sex == 1) {
            self.detailTFXB.text = @"女";
        }
        if (self.baby_sex == 0) {
            self.detailTFXB.text = @"男";
        }
        self.detailTF9.text = [self.dataDic objectForKey:@"baby_birthday"];
        
    }
    else
    {
        [_line10 removeFromSuperview];
        [_titleLabelXB removeFromSuperview];
        [_detailTFXB removeFromSuperview];
        self.detailTF8.text = @"怀孕中";
        self.titleLabel9.text = @"预产期:";
        self.detailTF9.text = [self.dataDic objectForKey:@"expected_confinement"];
        
    }
}


- (void)actionSheet
{
    UIActionSheet *acitonSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"已有宝宝" otherButtonTitles:@"怀孕中", nil];
    [acitonSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex                    //状态
{
    
    if (actionSheet == _sexAction) //有宝宝
    {
        if (buttonIndex == 0)
        {
            self.baby_sex = 0;
            self.detailTFXB.text = @"男";
            
        }
        if (buttonIndex == 1)
        {
            self.baby_sex = 1;
            self.detailTFXB.text = @"女";
        }
        
    }
    else
    {
        if (buttonIndex == 0) {
            self.currentIdentity  = @"1";
            self.detailTF8.text = @"已有宝宝";
            self.titleLabel9.text = @"宝宝生日:";
            
            self.line10 = [UIView new];                          ///9
            self.line10.backgroundColor = KHexColor(@"#e4e4e4");
            [self.headerView addSubview:_line10];
            
            self.titleLabelXB = [TTTAttributedLabel new];
            self.titleLabelXB.textColor = KHexColor(@"#666666");
            self.titleLabelXB.font = KFontSize(14);
            self.titleLabelXB.text = @"宝宝性别:";
            [self.headerView addSubview:_titleLabelXB];
            
            self.detailTFXB = [UITextField new];
            self.detailTFXB.textColor = KHexColor(@"#666666");
            self.detailTFXB.font = KFontSize(14);
            self.detailTFXB.textAlignment = NSTextAlignmentRight;
            self.detailTFXB.delegate = self;
            [self.headerView addSubview:_detailTFXB];
            
            [_line10 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.headerView.mas_top).offset(45*10);
                make.left.equalTo(self.headerView.mas_left).offset(15);
                make.right.equalTo(self.headerView.mas_right).offset(-15);
                make.height.equalTo(0.5);
            }];
            
            
            [_titleLabelXB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.line10.mas_centerY).offset(-22.5);
                make.left.equalTo(self.headerView.mas_left).offset(30);
                make.width.equalTo(self.titleLabelXB.mas_width);
                make.height.equalTo(14);
            }];
            
            
            [_detailTFXB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.titleLabelXB.mas_centerY).offset(0);
                make.right.equalTo(self.headerView.mas_right).offset(-15);
                make.width.equalTo(150);
                make.height.equalTo(30);
            }];
            
            self.detailTF9.text = [self.dataDic objectForKey:@"baby_birthday"];
            if (self.baby_sex == 1) {
                self.detailTFXB.text = @"女";
            }
            if (self.baby_sex == 0) {
                self.detailTFXB.text = @"男";
            }
        }
        else if(buttonIndex == 1)  //孕妈
        {
            self.currentIdentity = @"0";
            [_line10 removeFromSuperview];
            [_titleLabelXB removeFromSuperview];
            [_detailTFXB removeFromSuperview];
            self.detailTF8.text = @"怀孕中";
            self.titleLabel9.text = @"预产期:";
            self.detailTF9.text = [self.dataDic objectForKey:@"expect_date"];
        }

    }
}

#pragma TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //[self.view endEditing:YES];
    self.sexAction = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"男" otherButtonTitles:@"女", nil];
    [_sexAction showInView:self.view];
    return NO;
}


- (void)yuChanQiButtonClick                                                                                     //设置预产期时间
{
    if ([self.titleLabel9.text isEqualToString:@"末次月经时间:"])
    {
        self.currentIdentity = @"2";
    }
    DateWYPopView *simanPopoverViewController = [DateWYPopView new];                                            //初始化弹框
    simanPopoverViewController.preferredContentSize = CGSizeMake( CoreWidth,CoreHeight);                        //设置弹框的大小
    simanPopoverViewController.currentIdentity = self.currentIdentity;  ///根据状态选择时间
    [simanPopoverViewController setDismissSimanPopoverViewController:^(DateWYPopView *viewController) {
        [self.simanPopoverController dismissPopoverAnimated:YES completion:^{
        }];
    }];
    [simanPopoverViewController   setSureBlock:^(NSString *yuC) {
        self.detailTF9.text = yuC;
    }];                                                                                                             //确定方法
    
    
    [simanPopoverViewController setNoYuChanQiBlock:^(DateWYPopView *noYuChanQi) {
        self.titleLabel9.text = @"末次月经时间:";
        [self.simanPopoverController dismissPopoverAnimated:YES completion:^{
        }];
    }];
    self.simanPopoverController = [[WYPopoverController alloc] initWithContentViewController:simanPopoverViewController];
    self.simanPopoverController.delegate = self;
    self.simanPopoverController.animationDuration = .5f;
    self.simanPopoverController.popoverLayoutMargins = UIEdgeInsetsMake(CoreHeight-268, 10, 10, 10);
    self.simanPopoverController.wantsDefaultContentAppearance = NO;
    
    
    WYPopoverTheme *result = [[WYPopoverTheme alloc] init];                                                          //设置弹框的主题风格
    result.usesRoundedArrow = YES;
    result.dimsBackgroundViewsTintColor = YES;
    result.tintColor = nil;
    result.outerStrokeColor = [UIColor clearColor];
    result.innerStrokeColor = [UIColor clearColor];
    result.fillTopColor = nil;
    result.fillBottomColor = nil;
    result.glossShadowColor = nil;
    result.glossShadowOffset = CGSizeZero;
    result.glossShadowBlurRadius = 0;
    result.borderWidth = 0;
    result.arrowBase = 15;
    result.arrowHeight = 6;
    result.outerShadowColor = [UIColor clearColor];
    result.outerShadowBlurRadius = 0;
    result.outerShadowOffset = CGSizeZero;
    result.outerCornerRadius = 5;
    result.minOuterCornerRadius = 0;
    result.innerShadowColor = [UIColor clearColor];
    result.innerShadowBlurRadius = 0;
    result.innerShadowOffset = CGSizeZero;
    result.innerCornerRadius = 0;
    result.viewContentInsets = UIEdgeInsetsZero;
    result.overlayColor = [UIColor colorWithWhite:0 alpha:0.3];
    result.preferredAlpha = 1.0f;
    self.simanPopoverController.theme = result;
    [self.simanPopoverController presentPopoverAsDialogAnimated:YES
                                                        options:WYPopoverAnimationOptionFadeWithScale];
}
- (void)sectionButtonClick
{
    if ([self.user getUserMessageFromLocation].isLogin == YES) {
        [self.view addSubview:self.choicePhotoView];
        [self.choicePhotoView  addCon:self andView:self.view.window andImageCount:1];
    }

}


#pragma mark--------------------------------------------------------------ASChoicePhotoViewDelegate  update headerImage-------------------------------------
-(void)getImageArray:(NSMutableArray *)array{
    self.sectionImage.image = array[0];
    [self updateUserPhoto:array];
 
}

-(void)updateUserPhoto:(NSMutableArray *)array
{
    [ASLoadingView showActivity:self.view];
    [ASURLConnection requestImage:@{@"win":@1} method:kUploadImg version:@"" img:array name:@"user_img" completeBlock:^(NSData *data, id responseObject){
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            NSDictionary *dic = AFNdata[0];
            NSString *str  = [dic objectForKey:@"imageList"];
            
            [self requestDataImage:str];
            [ASLoadingView hidenActivity:self.view];
        }
    } errorBlock:^(NSError *error) {
    }];
    
}


- (void)requestDataImage:(NSString *)string
{
    
    
    [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId ],@"user_img":string} method:@"jumper.user.image.update" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            self.user = [ASUserInfoModel objectWithKeyValues:AFNdata[0]];
            self.user.isLogin = YES;
            [self.user saveMessageToLocation];
            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            
        }
        
        else{
            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);

        }
    } errorBlock:^(NSError *error) {
        
    }];
}
#pragma mark ---------------------------------------------------------------WYPopoverControllerDelegate-start---------------------------------
- (void)popoverControllerDidPresentPopover:(WYPopoverController *)controller
{
    NSLog(@"popoverControllerDidPresentPopover");
    
}
- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}
- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    self.simanPopoverController.delegate = nil;
    NSLog(@"popoverControllerDidDismissPopover");
}
- (BOOL)popoverControllerShouldIgnoreKeyboardBounds:(WYPopoverController *)popoverController
{
    return NO;
}
- (void)popoverController:(WYPopoverController *)popoverController willTranslatePopoverWithYOffset:(float *)value
{
    // keyboard is shown and the popover will be moved up by 163 pixels for example ( *value = 163 )
    *value = 0; // set value to 0 if you want to avoid the popover to be moved
}
- (void)popoverController:(WYPopoverController *)popoverController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView **)view
{
    
}
#pragma mark ------------------------------------------------------  popoverActionsEnd--------------------------

#pragma mark - UIViewControllerRotation
// Applications should use supportedInterfaceOrientations and/or shouldAutorotate..
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (BOOL)shouldAutorotate   // New Autorotation support.
{
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        
    }];
}
#pragma mark WYpopEnd


- (void)makeHeaderView
{
    self.sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 45)];
    self.sectionView.backgroundColor = KHexColor(@"#ffffff");
    [self.tableView addSubview:_sectionView];
    self.sectionLabel = [UILabel new];
    self.sectionLabel.textColor = KHexColor(@"#666666");
    self.sectionLabel.font = KFontSize(14);
    self.sectionLabel.text = @"我的头像";
    [self.sectionView addSubview:_sectionLabel];
    
    self.arrowImage = [UIImageView new];
    self.arrowImage.image = [UIImage imageNamed:@"3-1monitordata"];
    [self.sectionView addSubview:_arrowImage];
    
    self.sectionImage = [UIImageView new];
    self.sectionImage.layer.cornerRadius = 13.5;
    self.sectionImage.layer.masksToBounds = YES;
    self.sectionImage.image = [UIImage imageNamed:@"mine"];
    [self.sectionView addSubview:_sectionImage];
    
    self.iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.iconButton addTarget:self action:@selector(sectionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.sectionView addSubview:_iconButton];
    
    self.line0 = [UIView new];
    self.line0.backgroundColor = KHexColor(@"#e4e4e4");
    [self.sectionView addSubview:_line0];
    
    
    
    self.headerView = [[UIView alloc]init];
    self.headerView.frame = CGRectMake(0, 45, CoreWidth, CoreHeight-45);
    self.headerView.backgroundColor = KHexColor(@"#ffffff");
    [self.tableView addSubview:_headerView];
    
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"#e4e4e4");
    [self.headerView addSubview:_line];
    
    self.titleLabel = [TTTAttributedLabel new];
    self.titleLabel.textColor = KHexColor(@"#666666");
    self.titleLabel.font = KFontSize(14);
    self.titleLabel.text = @"我的昵称:";
    [self.headerView addSubview:_titleLabel];
    
    self.detailTF = [UITextField new];
    self.detailTF.textColor = KHexColor(@"#666666");
    self.detailTF.font = KFontSize(14);
    self.detailTF.textAlignment = NSTextAlignmentRight;
    [self.headerView addSubview:_detailTF];
    
    
    
    self.line2 = [UIView new];                          ///2
    self.line2.backgroundColor = KHexColor(@"#e4e4e4");
    [self.headerView addSubview:_line2];
    
    self.titleLabel2 = [TTTAttributedLabel new];
    self.titleLabel2.textColor = KHexColor(@"#666666");
    self.titleLabel2.font = KFontSize(14);
    self.titleLabel2.text = @"真实姓名:";
    [self.headerView addSubview:_titleLabel2];
    
    self.detailTF2 = [UITextField new];
    self.detailTF2.textColor = KHexColor(@"#666666");
    self.detailTF2.font = KFontSize(14);
    self.detailTF2.textAlignment = NSTextAlignmentRight;
    [self.headerView addSubview:_detailTF2];
    
    
    self.line3 = [UIView new];                          ///3
    self.line3.backgroundColor = KHexColor(@"#e4e4e4");
    [self.headerView addSubview:_line3];
    
    self.titleLabel3 = [TTTAttributedLabel new];
    self.titleLabel3.textColor = KHexColor(@"#666666");
    self.titleLabel3.font = KFontSize(14);
    self.titleLabel3.text = @"手机:";
    [self.headerView addSubview:_titleLabel3];
    
    self.detailTF3 = [UITextField new];
    self.detailTF3.textColor = KHexColor(@"#666666");
    self.detailTF3.font = KFontSize(14);
    self.detailTF3.textAlignment = NSTextAlignmentRight;
    [self.headerView addSubview:_detailTF3];
    
    
    self.line4 = [UIView new];                      ///4
    self.line4.backgroundColor = KHexColor(@"#e4e4e4");
    [self.headerView addSubview:_line4];
    
    self.titleLabel4 = [TTTAttributedLabel new];
    self.titleLabel4.textColor = KHexColor(@"#666666");
    self.titleLabel4.font = KFontSize(14);
    self.titleLabel4.text = @"年龄:";
    [self.headerView addSubview:_titleLabel4];
    
    self.detailTF4 = [UITextField new];
    self.detailTF4.textColor = KHexColor(@"#666666");
    self.detailTF4.font = KFontSize(14);
    self.detailTF4.textAlignment = NSTextAlignmentRight;
    [self.headerView addSubview:_detailTF4];
    
    
    
    self.line5 = [UIView new];                      ///5
    self.line5.backgroundColor = KHexColor(@"#e4e4e4");
    [self.headerView addSubview:_line5];
    
    self.titleLabel5 = [TTTAttributedLabel new];
    self.titleLabel5.textColor = KHexColor(@"#666666");
    self.titleLabel5.font = KFontSize(14);
    self.titleLabel5.text = @"身高(cm):";
    [self.headerView addSubview:_titleLabel5];
    
    self.detailTF5 = [UITextField new];
    self.detailTF5.textColor = KHexColor(@"#666666");
    self.detailTF5.font = KFontSize(14);
    self.detailTF5.textAlignment = NSTextAlignmentRight;
    [self.headerView addSubview:_detailTF5];
    
    
    
    
    self.line6 = [UIView new];                          ///6
    self.line6.backgroundColor = KHexColor(@"#e4e4e4");
    [self.headerView addSubview:_line6];
    
    self.titleLabel6 = [TTTAttributedLabel new];
    self.titleLabel6.textColor = KHexColor(@"#666666");
    self.titleLabel6.font = KFontSize(14);
    self.titleLabel6.text = @"体重(kg):";
    [self.headerView addSubview:_titleLabel6];
    
    self.detailTF6 = [UITextField new];
    self.detailTF6.textColor = KHexColor(@"#666666");
    self.detailTF6.font = KFontSize(14);
    self.detailTF6.textAlignment = NSTextAlignmentRight;
    [self.headerView addSubview:_detailTF6];
    
    
    
    self.line7 = [UIView new];                          ///7
    self.line7.backgroundColor = KHexColor(@"#e4e4e4");
    [self.headerView addSubview:_line7];
    
    self.titleLabel7 = [TTTAttributedLabel new];
    self.titleLabel7.textColor = KHexColor(@"#666666");
    self.titleLabel7.font = KFontSize(14);
    self.titleLabel7.text = @"地址:";
    [self.headerView addSubview:_titleLabel7];
    
    self.detailTF7 = [UITextField new];
    self.detailTF7.textColor = KHexColor(@"#666666");
    self.detailTF7.font = KFontSize(14);
    self.detailTF7.textAlignment = NSTextAlignmentRight;
    [self.headerView addSubview:_detailTF7];
    
    
    
    self.line8 = [UIView new];                          ///8
    self.line8.backgroundColor = KHexColor(@"#e4e4e4");
    [self.headerView addSubview:_line8];
    
    self.titleLabel8 = [TTTAttributedLabel new];
    self.titleLabel8.textColor = KHexColor(@"#666666");
    self.titleLabel8.font = KFontSize(14);
    self.titleLabel8.text = @"状态:";
    [self.headerView addSubview:_titleLabel8];
    
    self.detailTF8 = [UITextField new];
    self.detailTF8.textColor = KHexColor(@"#666666");
    self.detailTF8.font = KFontSize(14);
    self.detailTF8.delegate = self;
    self.detailTF8.tag = 8;
    self.detailTF8.textAlignment = NSTextAlignmentRight;
    [self.headerView addSubview:_detailTF8];
    
    
    
    self.line9 = [UIView new];                          ///9
    self.line9.backgroundColor = KHexColor(@"#e4e4e4");
    [self.headerView addSubview:_line9];
    
    self.titleLabel9 = [TTTAttributedLabel new];
    self.titleLabel9.textColor = KHexColor(@"#666666");
    self.titleLabel9.font = KFontSize(14);
    self.titleLabel9.text = @"预产期:";
    [self.headerView addSubview:_titleLabel9];
    
    self.detailTF9 = [UITextField new];
    self.detailTF9.textColor = KHexColor(@"#666666");
    self.detailTF9.font = KFontSize(14);
    self.detailTF9.textAlignment = NSTextAlignmentRight;
    self.detailTF9.delegate = self;
    self.detailTF9.tag = 9;
    [self.headerView addSubview:_detailTF9];
    
    
   
    
  
    
    
    [_line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sectionView.mas_top).offset(45);
        make.left.equalTo(self.sectionView.mas_left).offset(0);
        make.right.equalTo(self.sectionView.mas_right).offset(0);
        make.height.equalTo(0.5);
    }];
    
    
    [_sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sectionView.mas_centerY).offset(0);
        make.left.equalTo(self.sectionView.mas_left).offset(30);
        make.width.equalTo(self.sectionLabel.mas_width);
        make.height.equalTo(14);
    }];
    [_arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sectionView.mas_centerY).offset(0);
        make.right.equalTo(self.sectionView.mas_right).offset(-10);
        make.width.equalTo(10);
        make.height.equalTo(14);
    }];
    [_sectionImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sectionView.mas_centerY).offset(0);
        make.right.equalTo(self.arrowImage.mas_left).offset(-10);
        make.width.equalTo(27);
        make.height.equalTo(27);
    }];
    
    [_iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.sectionView);
    }];
    
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(45);
        make.left.equalTo(self.headerView.mas_left).offset(15);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.height.equalTo(0.5);
    }];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line.mas_centerY).offset(-22.5);
        make.left.equalTo(self.headerView.mas_left).offset(30);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    
    [_detailTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.mas_centerY).offset(0);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.width.equalTo(150);
        make.height.equalTo(30);
    }];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(45*2);
        make.left.equalTo(self.headerView.mas_left).offset(15);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.height.equalTo(0.5);
    }];
    
    
    [_titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line2.mas_centerY).offset(-22.5);
        make.left.equalTo(self.headerView.mas_left).offset(30);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    
    [_detailTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel2.mas_centerY).offset(0);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.width.equalTo(150);
        make.height.equalTo(30);
    }];
    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(45*3);
        make.left.equalTo(self.headerView.mas_left).offset(15);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.height.equalTo(0.5);
    }];
    
    
    [_titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line3.mas_centerY).offset(-22.5);
        make.left.equalTo(self.headerView.mas_left).offset(30);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    
    [_detailTF3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel3.mas_centerY).offset(0);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.width.equalTo(150);
        make.height.equalTo(30);
    }];
    [_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(45*4);
        make.left.equalTo(self.headerView.mas_left).offset(15);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.height.equalTo(0.5);
    }];
    
    
    [_titleLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line4.mas_centerY).offset(-22.5);
        make.left.equalTo(self.headerView.mas_left).offset(30);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    
    [_detailTF4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel4.mas_centerY).offset(0);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.width.equalTo(150);
        make.height.equalTo(30);
    }];
    [_line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(45*5);
        make.left.equalTo(self.headerView.mas_left).offset(15);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.height.equalTo(0.5);
    }];
    
    
    [_titleLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line5.mas_centerY).offset(-22.5);
        make.left.equalTo(self.headerView.mas_left).offset(30);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    
    [_detailTF5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel5.mas_centerY).offset(0);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.width.equalTo(150);
        make.height.equalTo(30);
    }];
    [_line6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(45*6);
        make.left.equalTo(self.headerView.mas_left).offset(15);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.height.equalTo(0.5);
    }];
    
    
    [_titleLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line6.mas_centerY).offset(-22.5);
        make.left.equalTo(self.headerView.mas_left).offset(30);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    
    [_detailTF6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel6.mas_centerY).offset(0);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.width.equalTo(150);
        make.height.equalTo(30);
    }];
    
    [_line7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(45*7);
        make.left.equalTo(self.headerView.mas_left).offset(15);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.height.equalTo(0.5);
    }];
    
    
    [_titleLabel7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line7.mas_centerY).offset(-22.5);
        make.left.equalTo(self.headerView.mas_left).offset(30);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    
    [_detailTF7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel7.mas_centerY).offset(0);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.width.equalTo(150);
        make.height.equalTo(30);
    }];
    
    
    [_line8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(45*8);
        make.left.equalTo(self.headerView.mas_left).offset(15);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.height.equalTo(0.5);
    }];
    
    
    [_titleLabel8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line8.mas_centerY).offset(-22.5);
        make.left.equalTo(self.headerView.mas_left).offset(30);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    
    [_detailTF8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel8.mas_centerY).offset(0);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.width.equalTo(150);
        make.height.equalTo(30);
    }];
    
    
    [_line9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(45*9);
        make.left.equalTo(self.headerView.mas_left).offset(15);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.height.equalTo(0.5);
    }];
    
    
    [_titleLabel9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line9.mas_centerY).offset(-22.5);
        make.left.equalTo(self.headerView.mas_left).offset(30);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    
    [_detailTF9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel9.mas_centerY).offset(0);
        make.right.equalTo(self.headerView.mas_right).offset(-15);
        make.width.equalTo(150);
        make.height.equalTo(30);
    }];
}

@end
