//
//  KeYuYueCanGuanVC.m
//  Mamabao
//
//  Created by Michael on 15/12/7.
//  Copyright © 2015年 Michael. All rights reserved.
//
/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface KeYuYueCanGuanModel  : NSObject
@property (nonatomic, strong) NSString *datetime;
@property (nonatomic, strong) NSString *weekday;
@property (nonatomic, strong) NSString *number;
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface KeYuYueCanGuanModel ()

@end

@implementation KeYuYueCanGuanModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([dic objectForKey:@"datetime"]) {
            self.datetime = [dic objectForKey:@"datetime"];
        }
        if ([dic objectForKey:@"weekday"]) {
            self.weekday = [dic objectForKey:@"weekday"];
        }
        if ([[dic objectForKey:@"number"]isKindOfClass:[NSNumber class]]) {
            self.number = [[dic objectForKey:@"number"] stringValue];
        }
    }
    return self;
}
@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface KeYuYueCanGuanCustomCell : UITableViewCell
@property (nonatomic, strong) KeYuYueCanGuanModel *keYuYueModel;
@property (nonatomic, strong) void(^yuYueBlock)(NSInteger);
@end


@interface KeYuYueCanGuanCustomCell ()

@property (nonatomic, strong) TTTAttributedLabel *dateLabel;
@property (nonatomic, strong) TTTAttributedLabel *xingQiLabel;
@property (nonatomic, strong) UIButton *yuYueButton;

@end

@implementation KeYuYueCanGuanCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KHexColor(@"#ffffff");
        
        self.dateLabel = [TTTAttributedLabel new];
        self.dateLabel.font = KFontSize(14);
        self.dateLabel.textColor = KHexColor(@"#727272");
        self.dateLabel.text = @"2015-12-20";
        [self.contentView addSubview:_dateLabel];
        
       
        
        self.xingQiLabel = [TTTAttributedLabel new];
        self.xingQiLabel.font = KFontSize(14);
        self.xingQiLabel.textColor = KHexColor(@"#656465");
        self.xingQiLabel.text = @"星期四";
        [self.contentView addSubview:_xingQiLabel];
        
                
        self.yuYueButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.yuYueButton.layer.cornerRadius = 6;
        self.yuYueButton.layer.masksToBounds = YES;
        self.yuYueButton.titleLabel.font = KFontSize(14);
        [self.yuYueButton setTitle:@"预约" forState:UIControlStateNormal];
        [self.yuYueButton setTitleColor:KHexColor(@"#ffffff") forState:(UIControlStateNormal)];
        [self.yuYueButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff879a")] forState:UIControlStateNormal];
        [self.yuYueButton addTarget:self action:@selector(yuYueButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_yuYueButton];
        
        
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.width.equalTo(self.dateLabel.mas_width);
            make.height.equalTo(14);
        }];
        
        [_xingQiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.centerX.equalTo(self.contentView.mas_centerX).offset(0);
            make.width.equalTo(self.xingQiLabel.mas_width);
            make.height.equalTo(14);
        }];
        
        [_yuYueButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.width.equalTo(60);
            make.height.equalTo(25);
        }];

    }
    return self;
}
- (void)setKeYuYueModel:(KeYuYueCanGuanModel *)keYuYueModel
{
    if (nil == keYuYueModel) {
        return;
    }
    self.dateLabel.text = keYuYueModel.datetime;
    self.xingQiLabel.text = keYuYueModel.weekday;
}
- (void)yuYueButtonClick:(UIButton *)button
{
    if (self.yuYueBlock) {
        self.yuYueBlock(button.tag);
    }
}
@end


/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "KeYuYueCanGuanVC.h"
#import "VisitOrderVC.h"

@interface KeYuYueCanGuanVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *yuanView;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) TTTAttributedLabel *lianXTitle;
@property (nonatomic, strong) TTTAttributedLabel *peopleNumberTitle;
@property (nonatomic, strong) TTTAttributedLabel *phoneTitle;
@property (nonatomic, strong) UITextField *lianXRTF;
@property (nonatomic, strong) UITextField *peopleNumberTF;
@property (nonatomic, strong) UITextField *phoneTF;
@end

@implementation KeYuYueCanGuanVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
    }
    return self;
}


- (void)tapClick
{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约参观";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.view.backgroundColor = KHexColor(@"#f3f3f3");
    self.dataArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:tap];
    [self makeHeaderView];
    [self requestData];
    
}

- (void)makeHeaderView
{
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 155)];
    self.headerView.backgroundColor =  KHexColor(@"#f3f3f3");
    self.tableView.tableHeaderView = _headerView;
    
    self.yuanView = [UIView new];
    self.yuanView.backgroundColor = KHexColor(@"#ffffff");
    self.yuanView.layer.cornerRadius = 6;
    self.yuanView.layer.masksToBounds = YES;
    [self.headerView addSubview:_yuanView];
    
    
      
    self.lianXTitle = [TTTAttributedLabel new];
    self.lianXTitle.font = KFontSize(14);
    self.lianXTitle.textColor = KHexColor(@"#434343");
    self.lianXTitle.text = @"联系人";
    [self.yuanView addSubview:_lianXTitle];
    
       
    self.lianXRTF = [UITextField new];
    self.lianXRTF.font = KFontSize(14);
    self.lianXRTF.textColor = KHexColor(@"#585858");
    self.lianXRTF.placeholder = @"姓名";
    [self.yuanView addSubview:_lianXRTF];
    
    
    self.peopleNumberTitle = [TTTAttributedLabel new];
    self.peopleNumberTitle.font = KFontSize(14);
    self.peopleNumberTitle.textColor = KHexColor(@"#434343");
    self.peopleNumberTitle.text = @"参观人数";
    [self.yuanView addSubview:_peopleNumberTitle];
    
      
    self.peopleNumberTF = [UITextField new];
    self.peopleNumberTF.font = KFontSize(14);
    self.peopleNumberTF.textColor = KHexColor(@"#585858");
    self.peopleNumberTF.placeholder = @"人数";
    [self.yuanView addSubview:_peopleNumberTF];
    
    
    
    self.phoneTitle = [TTTAttributedLabel new];
    self.phoneTitle.font = KFontSize(14);
    self.phoneTitle.textColor = KHexColor(@"#434343");
    self.phoneTitle.text = @"联系电话";
    [self.yuanView addSubview:_phoneTitle];
    
      
    self.phoneTF = [UITextField new];
    self.phoneTF.font = KFontSize(14);
    self.phoneTF.textColor = KHexColor(@"#585858");
    self.phoneTF.placeholder = @"电话";
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.yuanView addSubview:_phoneTF];
    
       
    self.line1 = [UIView new];
    self.line1.backgroundColor = KHexColor(@"#d9d9d9");
    [self.yuanView addSubview:_line1];
    
       
    self.line2 = [UIView new];
    self.line2.backgroundColor = KHexColor(@"#d9d9d9");
    [self.yuanView addSubview:_line2];
    
    
    [_yuanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(10);
        make.left.equalTo(self.headerView.mas_left).offset(10);
        make.right.equalTo(self.headerView.mas_right).offset(-10);
        make.bottom.equalTo(self.headerView.mas_bottom).offset(-10);
    }];
    [_lianXTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.yuanView.mas_top).offset(22.5);
        make.left.equalTo(self.yuanView.mas_left).offset(15);
        make.width.equalTo(self.lianXTitle.mas_width);
        make.height.equalTo(14);
    }];
    [_lianXRTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lianXTitle.mas_centerY).offset(0);
        make.left.equalTo(self.yuanView.mas_left).offset(120);
        make.width.equalTo(60);
        make.height.equalTo(14);
    }];
    [_peopleNumberTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.yuanView.mas_centerY).offset(0);
        make.left.equalTo(self.yuanView.mas_left).offset(15);
        make.width.equalTo(self.peopleNumberTitle.mas_width);
        make.height.equalTo(14);
    }];
    
    [_peopleNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.peopleNumberTitle.mas_centerY).offset(0);
        make.left.equalTo(self.yuanView.mas_left).offset(120);
        make.width.equalTo(30);
        make.height.equalTo(14);
    }];
    [_phoneTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.yuanView.mas_bottom).offset(-22.5);
        make.left.equalTo(self.yuanView.mas_left).offset(15);
        make.width.equalTo(self.phoneTitle.mas_width);
        make.height.equalTo(14);
    }];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.phoneTitle.mas_centerY).offset(0);
        make.left.equalTo(self.yuanView.mas_left).offset(120);
        make.width.equalTo(160);
        make.height.equalTo(14);
    }];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.yuanView.mas_top).offset(45);
        make.left.equalTo(self.yuanView.mas_left).offset(15);
        make.right.equalTo(self.yuanView.mas_right).offset(-15);
        make.height.equalTo(0.5);
        
    }];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.yuanView.mas_bottom).offset(-45);
        make.left.equalTo(self.yuanView.mas_left).offset(15);
        make.right.equalTo(self.yuanView.mas_right).offset(-15);
        make.height.equalTo(0.5);
        
    }];


}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------

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
    
    UILabel *dateTitle = [UILabel new];
    dateTitle.font = KFontSize(14);
    dateTitle.textColor = KHexColor(@"#434343");
    dateTitle.text = @"参观日期";
    [sectionView addSubview:dateTitle];
    
    UIView *dateLine = [UIView new];
    dateLine.backgroundColor = KHexColor(@"#d9d9d9");
    [sectionView addSubview:dateLine];
    
    [dateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sectionView.mas_centerY).offset(0);
        make.left.equalTo(sectionView.mas_left).offset(25);
        make.width.equalTo(dateTitle.mas_width);
        make.height.equalTo(14);
    }];

    [dateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sectionView.mas_top).offset(45);
        make.left.equalTo(sectionView.mas_left).offset(15);
        make.right.equalTo(sectionView.mas_right).offset(-15);
        make.height.equalTo(0.5);
        
    }];

    return sectionView;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    KeYuYueCanGuanCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[KeYuYueCanGuanCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    [cell setYuYueBlock:^(NSInteger inf) {
        inf = indexPath.row;
        //预约参观
        if ([self.peopleNumberTF.text isValid]&&[self.lianXRTF.text isValid]&&[self.phoneTF.text isValid])
        {
            
            NSDictionary *jsonDic = @{@"user_id":@32,
                                      @"entity_id":@3,
                                      @"visitTime":cell.dateLabel.text,
                                      @"visitNum":self.peopleNumberTF.text,
                                      @"linkman":self.lianXRTF.text,
                                      @"phone":self.phoneTF.text
                                      };
            [ASURLConnection requestAFNJSon:jsonDic method:@"renhe.visitService.submitVisit" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
                if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
                {
                    k_yjHUD(@"预约成功", self.view);
                    VisitOrderVC *vc = [[VisitOrderVC alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            } errorBlock:^(NSError *error) {
            }];
        }
        else if (self.lianXRTF.text.length == 0)
        {
            k_yjHUD(@"请输入姓名", self.view);
        }
        else if (self.peopleNumberTF.text.length == 0)
        {
            k_yjHUD(@"请输入人数", self.view);

        }
        else if (self.phoneTF.text.length == 0)
        {
            k_yjHUD(@"请输入联系电话", self.view);
            
        }

    }];
    cell.keYuYueModel = _dataArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark ------------------------------------------------------------------ASURConnection----------------------------------------------------------------------------------
- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{@"entity_id":@3} method:@"renhe.visitService.getFreeVisitDays" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject)
    {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            self.dataDic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"] objectAtIndex:0];
            NSArray *dataArr = [self.dataDic objectForKey:@"records"];
            for (int i = 0; i <dataArr.count; i++)
            {
                KeYuYueCanGuanModel *model = [[KeYuYueCanGuanModel alloc] initWithDictionary:dataArr[i]];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
}
@end


