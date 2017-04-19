//
//  YueZiDetailTaoCanVC.m
//  Mamabao
//
//  Created by Michael on 15/11/27.
//  Copyright © 2015年 Michael. All rights reserved.
//

/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface YueZiDetailTaoCanModel  : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface YueZiDetailTaoCanModel ()

@end

@implementation YueZiDetailTaoCanModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/
@interface YueZiDetailTaoCanCustomCell : UITableViewCell

+(CGFloat)heightForRowString:(NSString *)string;

@end



@interface YueZiDetailTaoCanCustomCell ()

@property (nonatomic, strong) TTTAttributedLabel *detailLabel;

@end

@implementation YueZiDetailTaoCanCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        self.detailLabel = [TTTAttributedLabel new];
        self.detailLabel.font = KFontSize(13);
        self.detailLabel.textColor = KHexColor(@"#906e50");
        self.detailLabel.lineSpacing = 5;
        self.detailLabel.numberOfLines = 0;
        [self.contentView addSubview:_detailLabel];
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
        }];
        
        
    }
    return self;
}

+(CGFloat)heightForRowString:(NSString *)string
{
    CGFloat bottomSpace = 16;
    CGFloat detailHeight = [NSAttributedString contentHeightWithText:string width:CoreWidth-20 fontSize:13 lineSpacing:5];
    return bottomSpace + detailHeight;
}


@end



/*-----------------------------------------------------------------------V-------------------------------------------*/
@interface XuZhiCustomCell : UITableViewCell

+(CGFloat)heightForRowString:(NSString *)string;

@end



@interface XuZhiCustomCell ()
@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) TTTAttributedLabel *xuZhiLabel;

@end

@implementation XuZhiCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        

        self.cellView = [UIView new];
        self.cellView.layer.cornerRadius = 5;
        self.cellView.layer.masksToBounds = YES;
        self.cellView.layer.borderColor = KHexColor(@"#c5c5c5").CGColor;
        self.cellView.layer.borderWidth = 0.5;
        [self.contentView addSubview:_cellView];
        
        
        self.xuZhiLabel = [TTTAttributedLabel new];
        self.xuZhiLabel.font = KFontSize(13);
        self.xuZhiLabel.textColor = KHexColor(@"#8a8a8a");
        self.xuZhiLabel.lineSpacing = 5;
        self.xuZhiLabel.numberOfLines = 0;
        [self.contentView addSubview:_xuZhiLabel];
        
        [_cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        }];

        
        [_xuZhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(30);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
        }];
        
    }
    return self;
}

+(CGFloat)heightForRowString:(NSString *)string
{
    CGFloat bottomSpace = 16;
    CGFloat detailHeight = [NSAttributedString contentHeightWithText:string width:CoreWidth-20 fontSize:13 lineSpacing:5];
    return bottomSpace + detailHeight+20;
}


@end




/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "YueZiDetailTaoCanVC.h"
#import "KeYuYueTimeVC.h"
#import "PayOrderVC.h"
@interface YueZiDetailTaoCanVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,WYPopoverControllerDelegate>
@property (nonatomic , strong) WYPopoverController *simanPopoverController;
@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSDictionary *order_idDic;
@property (nonatomic, strong) NSArray *xuZhiArray;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) UIView *gerenBGView;
@property (nonatomic, strong) UIView *gerRenView;
@property (nonatomic, strong) UIImageView *gerRenImage;
@property (nonatomic, strong) TTTAttributedLabel *gerRenLabel;
@property (nonatomic, strong) UIView *gerRenLine1;
@property (nonatomic, strong) UIView *gerRenLine2;
@property (nonatomic, strong) UIView *gerRenLine3;
@property (nonatomic, strong) TTTAttributedLabel *gerRenLabel1;
@property (nonatomic, strong) TTTAttributedLabel *gerRenLabel2;
@property (nonatomic, strong) TTTAttributedLabel *gerRenLabel4;
@property (nonatomic, strong) TTTAttributedLabel *zhiLabel;
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *startTF;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation YueZiDetailTaoCanVC

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
    self.title = @"套餐详情";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.user = [[ASUserInfoModel alloc] init];
    self.xuZhiArray = [NSArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    self.tableView.backgroundColor = KHexColor(@"#ffffff");
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [self requestData];
    
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:tap];
}
- (void)tapClick
{
    [self.view endEditing:YES];
}
#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 35)];
    sectionView.backgroundColor = KHexColor(@"#ebebeb");
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = 0 == section ?[UIImage imageNamed:@"detail"] : [UIImage imageNamed:@"remind"];
    [sectionView addSubview:imageView];
    
    UILabel *sectionLabel = [UILabel new];
    sectionLabel.font = KFontSize(14);
    sectionLabel.textColor = KHexColor(@"#5d5d5d");
    sectionLabel.text = 0 == section ? @"套餐详情" : @"购买须知";
    [sectionView addSubview:sectionLabel];
    
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sectionView.mas_centerY).offset(0);
        make.left.equalTo(sectionView.mas_left).offset(10);
        make.width.equalTo(15);
        make.height.equalTo(15);
    }];
    
    [sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sectionView.mas_centerY).offset(0);
        make.left.equalTo(imageView.mas_right).offset(10);
        make.width.equalTo(sectionLabel.mas_width);
        make.height.equalTo(14);
    }];
    return sectionView;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    else
    {
        self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 400)];
        self.footerView.backgroundColor = KHexColor(@"#ffffff");
        [self makeFooterView];
        return _footerView;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section == 0 ? 0.001 : 400;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [YueZiDetailTaoCanCustomCell heightForRowString:[self.dataDic objectForKey:@"text"]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       if (indexPath.section == 0)
       {
           static NSString *identifier = @"cell";
           YueZiDetailTaoCanCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
           if (nil == cell) {
               cell = [[YueZiDetailTaoCanCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
           }

        cell.detailLabel.text= [self.dataDic objectForKey:@"text"];
           
           return cell;
    
       }
       else
       {
           static NSString *identifier = @"cellXZ";
           XuZhiCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
           if (nil == cell) {
               cell = [[XuZhiCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
           }
           cell.xuZhiLabel.text =  [self.dataDic objectForKey:@"buyKnow"];
           return cell;
       }
}

#pragma mark ------------------------------------------------------------------ASURLConnection----------------------------------------------------------------
- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{@"package_id":self.package_id,@"isPerson":@0} method:@"renhe.momService.queryPackage" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            self.dataDic = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"][0];

            [_tableView reloadData];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
    KeYuYueTimeVC *simanPopoverViewController = [KeYuYueTimeVC new];                                            //初始化弹框
    simanPopoverViewController.preferredContentSize = CGSizeMake( CoreWidth,CoreHeight);                        //设置弹框的大小
    [simanPopoverViewController setDismissSimanPopoverViewController:^(KeYuYueTimeVC *viewController) {
        [self.simanPopoverController dismissPopoverAnimated:YES completion:^{
            
            
        }];
    }];
    [simanPopoverViewController   setSureBlock:^(NSString *yuC) {
        self.startTF.text = yuC;
    }];                                                                                                             //确定方法
    
    self.simanPopoverController = [[WYPopoverController alloc] initWithContentViewController:simanPopoverViewController];
    self.simanPopoverController.delegate = self;
    self.simanPopoverController.animationDuration = .5f;
    self.simanPopoverController.popoverLayoutMargins = UIEdgeInsetsMake(CoreHeight*300/568, 10, 10, 10);
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

    return NO;
}
- (void)submitButtonClick
{
       
    if (self.nameTF.text.length>0&&self.phoneTF.text.length>0&&self.startTF.text.length>0) {
        
        NSDictionary *jsonDic = @{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],
                                  @"isPerson":@0,
                                  @"entity_id":self.entity_id,
                                  @"package_id":self.package_id,
                                  @"username":self.nameTF.text,
                                  @"mobile":self.phoneTF.text,
                                  @"startDateTime":self.startTF.text,
                                  @"address":@"",
                                  @"endDate":@""};
        
        [ASURLConnection requestAFNJSon:jsonDic method:@"renhe.momService.sumbitOrder" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
            {
                
                self.order_idDic = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"][0];
                [self performSelector:@selector(afterDelayClick) withObject:nil afterDelay:1];
                k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
               
            }
        } errorBlock:^(NSError *error) {
        }];

       
    }
    else if (self.nameTF.text.length == 0)
    {
        k_yjHUD(@"请输入姓名", self.view);
    }
    else if (self.phoneTF.text.length == 0)
    {
        k_yjHUD(@"请输入手机号码", self.view);

    }
    else if (self.startTF.text.length == 0)
    {
        k_yjHUD(@"请输入入住时间", self.view);

    }

}
- (void)afterDelayClick
{
    PayOrderVC *pay = [PayOrderVC new];
    pay.order_id = [self.order_idDic objectForKey:@"id"];
    [self.navigationController pushViewController:pay animated:YES];
}

#pragma mark ------------------------------------------------------------------ makeFooterView---------------------------------------------------------------

- (void)makeFooterView
{
    
    self.gerenBGView = [[UIView alloc] init];
    self.gerenBGView.frame = CGRectMake(0, 0, CoreWidth, 35);
    self.gerenBGView.backgroundColor = KHexColor(@"#ebebeb");
    [self.footerView addSubview:_gerenBGView];
    
    self.gerRenImage = [UIImageView new];                           //个人
    self.gerRenImage.image = [UIImage imageNamed:@"information"];
    [self.footerView addSubview:_gerRenImage];
    
    self.gerRenLabel = [TTTAttributedLabel new];
    self.gerRenLabel.font = KFontSize(14);
    self.gerRenLabel.textColor = KHexColor(@"#5d5d5d");
    self.gerRenLabel.text = @"个人信息";
    [self.footerView addSubview:_gerRenLabel];
    
    self.gerRenView = [UIView new];
    self.gerRenView.layer.cornerRadius = 5;
    self.gerRenView.layer.masksToBounds = YES;
    self.gerRenView.layer.borderColor = KHexColor(@"#c5c5c5").CGColor;
    self.gerRenView.layer.borderWidth = 0.5;
    self.gerRenView.backgroundColor = KHexColor(@"#ffffff");
    [self.footerView addSubview:_gerRenView];
    
    
    self.gerRenLine1 = [UIView new];
    self.gerRenLine1.backgroundColor = KHexColor(@"#c5c5c5");
    [self.footerView addSubview:_gerRenLine1];
    
    self.gerRenLine2 = [UIView new];
    self.gerRenLine2.backgroundColor = KHexColor(@"#c5c5c5");
    [self.footerView addSubview:_gerRenLine2];
    
    
    
    self.gerRenLabel1 = [TTTAttributedLabel new];
    self.gerRenLabel1.font = KFontSize(14);
    self.gerRenLabel1.textColor = KHexColor(@"#8a8a8a");
    self.gerRenLabel1.text = @"姓名";
    [self.footerView addSubview:_gerRenLabel1];
    
    
    
    self.gerRenLabel2 = [TTTAttributedLabel new];
    self.gerRenLabel2.font = KFontSize(14);
    self.gerRenLabel2.textColor = KHexColor(@"#8a8a8a");
    self.gerRenLabel2.text = @"联系电话";
    [self.footerView addSubview:_gerRenLabel2];
    
    
    
    self.gerRenLabel4 = [TTTAttributedLabel new];
    self.gerRenLabel4.font = KFontSize(14);
    self.gerRenLabel4.textColor = KHexColor(@"#8a8a8a");
    self.gerRenLabel4.text = @"入住时间";
    [self.footerView addSubview:_gerRenLabel4];
    
    
    self.nameTF = [UITextField new];         //request
    self.nameTF.font = KFontSize(14);
    self.nameTF.textColor = KHexColor(@"#464646");
    self.nameTF.placeholder = @"请输入姓名";
    [self.footerView addSubview:_nameTF];
    
    
    
    self.phoneTF = [UITextField new];
    self.phoneTF.font = KFontSize(14);
    self.phoneTF.textColor = KHexColor(@"#464646");
    self.phoneTF.placeholder = @"请输入电话";
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.footerView addSubview:_phoneTF];
    
    
    self.startTF = [UITextField new];
    self.startTF.font = KFontSize(14);
    self.startTF.delegate = self;
    self.startTF.textColor = KHexColor(@"#464646");
    self.startTF.placeholder = @"选择时间";
    [self.footerView addSubview:_startTF];
    
    
    
    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitButton.layer.cornerRadius = 5;
    self.submitButton.layer.masksToBounds = YES;
    [self.submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [self.submitButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.submitButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff879a")] forState:UIControlStateNormal];
    [self.submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:_submitButton];
    
    
    
    [_gerRenImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.footerView.mas_top).offset(10);
        make.left.equalTo(self.footerView.mas_left).offset(10);
        make.width.equalTo(15);
        make.height.equalTo(15);
    }];
    
    [_gerRenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.gerRenImage.mas_centerY).offset(0);
        make.left.equalTo(self.gerRenImage.mas_right).offset(10);
        make.width.equalTo(self.gerRenLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    [_gerRenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gerRenImage.mas_bottom).offset(20);
        make.left.equalTo(self.footerView.mas_left).offset(10);
        make.right.equalTo(self.footerView.mas_right).offset(-10);
        make.height.equalTo(120);
    }];
    
    [_gerRenLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gerRenView.mas_top).offset(40);
        make.left.equalTo(self.footerView.mas_left).offset(25);
        make.right.equalTo(self.footerView.mas_right).offset(-25);
        make.height.equalTo(0.5);
    }];
    
    [_gerRenLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gerRenView.mas_top).offset(80);
        make.left.equalTo(self.footerView.mas_left).offset(25);
        make.right.equalTo(self.footerView.mas_right).offset(-25);
        make.height.equalTo(0.5);
    }];
    
    
    [_gerRenLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.gerRenView.mas_top).offset(160/8);
        make.left.equalTo(self.gerRenView.mas_left).offset(20);
        make.width.equalTo(self.gerRenLabel1.mas_width);
        make.height.equalTo(14);
    }];
    
    [_gerRenLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.gerRenView.mas_centerY).offset(0);
        make.left.equalTo(self.gerRenView.mas_left).offset(20);
        make.width.equalTo(self.gerRenLabel2.mas_width);
        make.height.equalTo(14);
    }];
    
    [_gerRenLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.gerRenView.mas_bottom).offset(-160/8);
        make.left.equalTo(self.gerRenView.mas_left).offset(20);
        make.width.equalTo(self.gerRenLabel4.mas_width);
        make.height.equalTo(14);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.gerRenView.mas_top).offset(160/8);
        make.left.equalTo(self.gerRenView.mas_left).offset(120);
        make.width.equalTo(180);
        make.height.equalTo(14);
    }];
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.gerRenView.mas_centerY).offset(0);
        make.left.equalTo(self.gerRenView.mas_left).offset(120);
        make.width.equalTo(180);
        make.height.equalTo(14);
    }];
    
    [_startTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.gerRenView.mas_bottom).offset(-160/8);
        make.left.equalTo(self.gerRenView.mas_left).offset(120);
        make.width.equalTo(80);
        make.height.equalTo(14);
    }];
    
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.footerView.mas_centerX).offset(0);
        make.top.equalTo(self.gerRenView.mas_bottom).offset(10);
        make.width.equalTo(250);
        make.height.equalTo(40);
    }];
}

@end
