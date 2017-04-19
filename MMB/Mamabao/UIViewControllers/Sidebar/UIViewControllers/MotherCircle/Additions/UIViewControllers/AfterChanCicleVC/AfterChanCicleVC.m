//
//  AfterChanCicleVC.m
//  Mamabao
//
//  Created by Michael on 15/11/13.
//  Copyright © 2015年 Michael. All rights reserved.
//
/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface AfterChanCicleModel: NSObject

@property (nonatomic, strong) NSString *circle_id;
@property (nonatomic, strong) NSString *isFocus;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, strong) NSString *detailName;
@property (nonatomic, strong) NSString *personNumberName;
@property (nonatomic, strong) NSString *commentNumberName;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface AfterChanCicleModel ()

@end

@implementation AfterChanCicleModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([dic objectForKey:@"name"]) {
            self.titleName = [dic objectForKey:@"name"];
        }
        if ([dic objectForKey:@"title"]) {
            self.detailName = [dic objectForKey:@"title"];
        }
        if ([dic objectForKey:@"imageUrl"]) {
            self.iconName = [dic objectForKey:@"imageUrl"];
        }
        if ([[dic objectForKey:@"focusUser"] isKindOfClass:[NSNumber class]]) {
            self.personNumberName = [[dic objectForKey:@"focusUser"] stringValue];
        }
        if ([[dic objectForKey:@"postNum"] isKindOfClass:[NSNumber class]]) {
            self.commentNumberName = [[dic objectForKey:@"postNum"] stringValue];
        }
        if ([[dic objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
            self.circle_id = [[dic objectForKey:@"id"] stringValue];
        }
        if ([[dic objectForKey:@"isFocus"] isKindOfClass:[NSNumber class]]) {
            self.isFocus = [[dic objectForKey:@"isFocus"] stringValue];
        }


    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface AfterChanCicleCustomCell : UITableViewCell
@property (nonatomic, strong) NSString *isAttentioned;
@property (nonatomic, strong) AfterChanCicleModel *afterMoel;
@property (nonatomic, strong) void(^induceAndReduceButtonBlock)();
@end



@interface AfterChanCicleCustomCell ()

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) NSString *circle_id;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIButton *induceAndReduceButton;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) TTTAttributedLabel *detailLabel;
@property (nonatomic, strong) TTTAttributedLabel *personNumberLabel;
@property (nonatomic, strong) TTTAttributedLabel *commentNumberLabel;
@property (nonatomic, strong) UIImageView *personNumberImage;
@property (nonatomic, strong) UIImageView *conmmentNumberImage;



@end

@implementation AfterChanCicleCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KHexColor(@"#f5f5f5");
        
        self.cellView = [UIView new];
        self.cellView.backgroundColor = KHexColor(@"#ffffff");
        self.cellView.layer.cornerRadius = 5;
        self.cellView.layer.masksToBounds = YES;
        [self.contentView addSubview:_cellView];
        
        
        self.iconImage = [UIImageView new];
        self.iconImage.layer.cornerRadius = 55/2;
        self.iconImage.layer.masksToBounds = YES;
        self.iconImage.image = [UIImage imageNamed:@"introduction_picture"];
        [self.contentView addSubview:_iconImage];
        
        
        
        self.titleLabel = [TTTAttributedLabel new];
        self.titleLabel.textColor = KHexColor(@"#333333");
        self.titleLabel.font = KFontSize(14);
        self.titleLabel.text = @"妈妈联盟";
        [self.contentView addSubview:_titleLabel];
        
        
        self.detailLabel = [TTTAttributedLabel new];
        self.detailLabel.numberOfLines = 0;
        self.detailLabel.lineSpacing = 5;
        self.detailLabel.font = KFontSize(12);
        self.detailLabel.textColor = KHexColor(@"#666666");
        self.detailLabel.text = @"提供专门为妈妈服务的月子中心";
        [self.contentView addSubview:_detailLabel];
        
        
        self.commentNumberLabel = [TTTAttributedLabel new];
        self.commentNumberLabel.numberOfLines = 0;
        self.commentNumberLabel.lineSpacing = 5;
        self.commentNumberLabel.font = KFontSize(12);
        self.commentNumberLabel.textColor = KHexColor(@"#999999");
        self.commentNumberLabel.text = @"555";
        [self.contentView addSubview:_commentNumberLabel];
        
        
        self.conmmentNumberImage = [UIImageView new];
        self.conmmentNumberImage.image = [UIImage imageNamed:@"circle_6mother"];
        [self.contentView addSubview:_conmmentNumberImage];
        
        self.personNumberLabel = [TTTAttributedLabel new];
        self.personNumberLabel.numberOfLines = 0;
        self.personNumberLabel.lineSpacing = 5;
        self.personNumberLabel.font = KFontSize(12);
        self.personNumberLabel.textColor = KHexColor(@"#999999");
        self.personNumberLabel.text = @"555";
        [self.contentView addSubview:_personNumberLabel];
        
        
        
        self.personNumberImage = [UIImageView new];
        self.personNumberImage.image = [UIImage imageNamed:@"circle_8mother"];
        [self.contentView addSubview:_personNumberImage];
        
        
        self.induceAndReduceButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.induceAndReduceButton addTarget:self action:@selector(induceAndReduceButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_induceAndReduceButton];
        
        
        [_cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(3);
            make.left.equalTo(self.contentView.mas_left).offset(6);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-3);
            make.right.equalTo(self.contentView.mas_right).offset(-6);
            
        }];
        
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.width.equalTo(55);
            make.height.equalTo(55);
        }];
        
        
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImage.mas_top).offset(0);
            make.left.equalTo(self.iconImage.mas_right).offset(5);
            make.width.equalTo(self.titleLabel.mas_width);
            make.height.equalTo(14);
        }];
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.equalTo(self.iconImage.mas_right).offset(5);
            make.width.equalTo(self.detailLabel.mas_width);
            make.height.equalTo(12);
            
        }];
        
        [_commentNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.cellView.mas_bottom).offset(-7);
            make.right.equalTo(self.cellView.mas_right).offset(-7);
            make.width.equalTo(20);
            make.height.equalTo(12);
            
        }];
        [_conmmentNumberImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.commentNumberLabel.mas_centerY).offset(3);
            make.right.equalTo(self.commentNumberLabel.mas_left).offset(-5);
            make.width.equalTo(14);
            make.height.equalTo(13);
        }];
        [_personNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.commentNumberLabel.mas_centerY).offset(0);
            make.right.equalTo(self.conmmentNumberImage.mas_left).offset(-10);
            make.width.equalTo(20);
            make.height.equalTo(12);
            
        }];
        [_personNumberImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.commentNumberLabel.mas_centerY).offset(3);
            make.right.equalTo(self.personNumberLabel.mas_left).offset(-5);
            make.width.equalTo(14);
            make.height.equalTo(13);
        }];
        
        [_induceAndReduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel.mas_centerY).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.width.equalTo(40);
            make.height.equalTo(30);
        }];

        
        
    }
    return self;
}

- (void)setAfterMoel:(AfterChanCicleModel *)afterMoel
{
    if (nil == afterMoel)
    {
        return;
    }
    self.isAttentioned = afterMoel.isFocus;
    self.circle_id = afterMoel.circle_id;
    self.titleLabel.text = afterMoel.titleName;
    self.detailLabel.text = afterMoel.detailName;
    self.personNumberLabel.text = afterMoel.personNumberName;
    self.commentNumberLabel.text = afterMoel.commentNumberName;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:afterMoel.iconName] placeholderImage:nil];
    
    if ([self.isAttentioned isEqualToString:@"0"])
    {
        [self.induceAndReduceButton setImage:[UIImage imageNamed: @"circle_2mother"] forState:UIControlStateNormal];
    }
    if ([self.isAttentioned isEqualToString:@"1"])
    {
        [self.induceAndReduceButton setImage:[UIImage imageNamed: @"circle_1mother"] forState:UIControlStateNormal];
    }
}

- (void)induceAndReduceButtonClick
{
    if (self.induceAndReduceButtonBlock) {
        self.induceAndReduceButtonBlock();
    }
}

@end
/*-----------------------------------------------------------------------C-------------------------------------------*/
#import "AfterChanCicleVC.h"
#import "AfterChanOfChiHuoVC.h"

@interface AfterChanCicleVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL *isOpen;

@property (nonatomic, strong) ASUserInfoModel *user;
@end


@implementation AfterChanCicleVC
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
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"妈妈圈";
    NavigationBarTitleColor
    self.view.backgroundColor = KHexColor(@"#f5f5f5");
    self.menuController.panEnabel = NO;
    self.user = [[ASUserInfoModel alloc] init];
    self.dataArray = [NSMutableArray array];
    _isOpen = malloc(sizeof(BOOL) *_dataArray.count);
    memset(_isOpen, 0, sizeof(BOOL) *_dataArray.count);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 80;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.bottom.right.equalTo(self.view);
    }];
    [self requestData];
    
    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    AfterChanCicleCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[AfterChanCicleCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.afterMoel = _dataArray[indexPath.row];
    [cell setInduceAndReduceButtonBlock:^{
        if ([cell.isAttentioned isEqualToString:@"1"])
        {
            [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],@"circle_id":cell.circle_id,@"type":@0} method:@"renhe.momCircle.focusCircle" view:self.view  version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
                if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                    {
                        [cell.induceAndReduceButton setImage:[UIImage imageNamed:@"circle_2mother"] forState:UIControlStateNormal];
                        cell.isAttentioned = @"0";
                    }
                    
                    k_yjHUD([ASURLConnection getMessage:responseObject], self.view)
                }
            } errorBlock:^(NSError *error) {
            }];
        }
        if ([cell.isAttentioned isEqualToString:@"0"])
        {
            [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],@"circle_id":cell.circle_id,@"type":@1} method:@"renhe.momCircle.focusCircle" view:self.view  version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
                if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                    [cell.induceAndReduceButton setImage:[UIImage imageNamed:@"circle_1mother"] forState:UIControlStateNormal];
                    cell.isAttentioned = @"1";
                    k_yjHUD([ASURLConnection getMessage:responseObject], self.view)
                }
                
            } errorBlock:^(NSError *error) {
                
            }];
            
        }
    }];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AfterChanOfChiHuoVC *chihuo = [AfterChanOfChiHuoVC new];
    AfterChanCicleModel *after = _dataArray[indexPath.row];
    chihuo.navigaitonTitle = after.titleName;
    chihuo.circle_id = after.circle_id;
    [self.navigationController pushViewController:chihuo animated:YES];
}

#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------
- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],@"type_id":self.type_id} method:@"renhe.momCircle.allMotherCircle" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            for (int i= 0; i <dataArr.count; i++)
            {
                AfterChanCicleModel *model = [[AfterChanCicleModel alloc] initWithDictionary:dataArr[i]];
                [self.dataArray addObject:model];
            }
            if (dataArr.count == 0)
            {
                k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            }
            [_tableView reloadData];
            
        }
        else{k_yjHUD([ASURLConnection getMessage:responseObject], self.view)}
    } errorBlock:^(NSError *error) {
        
    }];
}
@end
