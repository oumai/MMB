//
//  BabyAndMotherChangeVC.m
//  Mamabao
//
//  Created by Michael on 15/11/9.
//  Copyright © 2015年 Michael. All rights reserved.
//

/*-----------------------------------------------------------------------M-------------------------------------------*/




@interface BabyAndMotherModel: NSObject


@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *title;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface BabyAndMotherModel ()

@end

@implementation BabyAndMotherModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([dic objectForKey:@"content"]) {
            self.content = [dic objectForKey:@"content"];
        }
        
        if ([dic objectForKey:@"title"]) {
            self.title = [dic objectForKey:@"title"];
        }
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface BabyAndMotherCustomCell :  UITableViewCell

@property (nonatomic, strong) BabyAndMotherModel *babyModel;
+ (CGFloat)heightForCellRow:(NSString *)string;

@end



@interface BabyAndMotherCustomCell ()
@property (nonatomic, strong) TTTAttributedLabel *babyChangeDetailLabel;
@property (nonatomic, strong) UIView *bgView;
@end

@implementation BabyAndMotherCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = KHexColor(@"#ffe0e5");
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.bgView = [UIView new];
        self.bgView.layer.cornerRadius = 4;
        self.bgView.layer.masksToBounds = YES;
        self.bgView.layer.borderColor = KHexColor(@"#ffffff").CGColor;
        self.bgView.layer.borderWidth = 1;
        self.bgView.backgroundColor = KHexColor(@"#fff3f5");
        [self.contentView addSubview:_bgView];
        
       
        
        self.babyChangeDetailLabel = [TTTAttributedLabel new];
        self.babyChangeDetailLabel.backgroundColor =  KHexColor(@"#fff3f5");
        self.babyChangeDetailLabel.textColor = KHexColor(@"#999999");
        self.babyChangeDetailLabel.font = KFontSize(14);
        self.babyChangeDetailLabel.numberOfLines = 0;
        self.babyChangeDetailLabel.lineSpacing = 5;
        [self.contentView addSubview:_babyChangeDetailLabel];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(7);
            make.left.equalTo(self.contentView.mas_left).offset(7);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-7);
            make.right.equalTo(self.contentView.mas_right).offset(-7);
            
            
        }];
        
        [_babyChangeDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(13);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.right.equalTo(self.contentView.mas_right).offset(-13);

            
        }];

    }
    return self;
}

+ (CGFloat)heightForCellRow:(NSString *)string
{
    if (![string isValid]) {
        return 0;
    }
    CGFloat bottomSpace = 16;
    CGFloat detail = [NSAttributedString contentHeightWithText:string width:CoreWidth - 14-10  fontSize:14 lineSpacing:5];
    return bottomSpace + detail+20;
}

- (void)setBabyModel:(BabyAndMotherModel *)babyModel
{
    if (nil == babyModel) {
        return;
    }
    self.babyChangeDetailLabel.text = [NSString stringWithFormat:@"%@: %@",babyModel.title,babyModel.content];
    
    
}

@end


/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "BabyAndMotherChangeVC.h"



@interface BabyAndMotherChangeVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSString *baobao;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) NSInteger lastButtonTag;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *babyChangeView;
@property (nonatomic, strong) UIView *motherChangeView;
@end

@implementation BabyAndMotherChangeVC

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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"宝妈变化";
    NavigationBarTitleColor;
    self.view.backgroundColor = KHexColor(@"#ffffff");
    self.menuController.panEnabel = NO;
    self.user = [[ASUserInfoModel alloc] init];
    self.dataArray = [NSMutableArray array];
    [self makeUI];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = KHexColor(@"#ffe0e5");
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64+40);
        make.left.bottom.right.equalTo(self.view);
    }];
    [self requestData];
}

- (void)makeUI
{
    //UIScrollView
    NSArray* titleArray =@[@"0周",@"1周",@"2周",@"3周",@"4周",@"5周",@"6周",@"7周",@"8周",@"9周",@"10周",@"11周",@"12周",@"13周",@"14周",@"15周",@"16周",@"17周",@"18周",@"19周",@"20周",@"21周",@"22周",@"23周",@"24周",@"25周",@"26周",@"27周",@"28周",@"29周",@"30周",@"31周",@"32周",@"33周",@"34周",@"35周",@"36周",@"37周",@"38周",@"39周"];
    self.lastButtonTag = 1;
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = KHexColor(@"#ffffff");
    self.scrollView.frame = CoreWidth == 320 ? CGRectMake(60, 64, 200, 40) : CGRectMake(CoreWidth*80/320, 64, 200, 40);
    for (int i = 0; i < titleArray.count; i ++) {
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(20 + (50 + 30)*i, 5, 50,28);
        [self.button setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [self.button setTitleColor:KHexColor(@"#ff5873") forState:UIControlStateNormal];
        self.button.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if (i == 0)
        {
            
            [self.button setBackgroundImage:[UIImage imageNamed:@"kuangkuang_red"] forState:UIControlStateNormal];
        }
        self.button.tag = i + 1;
        [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:self.button];
    }
    [self.scrollView setContentSize:CGSizeMake(10 + (80 + 30) * 40-1100, 0)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_scrollView];
}


- (void)buttonClick:(UIButton* )button
{
    
    UIButton* lastButton = (UIButton* )[self.view viewWithTag:self.lastButtonTag];
    [lastButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"kuangkuang_red"] forState:UIControlStateNormal];
    self.lastButtonTag = button.tag;
    [_scrollView setContentOffset:CGPointMake(button.center.x - 100, 0) animated:YES];
    
    [self requestData];
}

#pragma mark ----------------------------------------------------------------------------UITableViewDatasource delegate---------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 40)];
    sectionView.backgroundColor = KHexColor(@"#fff3f5");
    
    UIView *shu = [UIView new];
    shu.backgroundColor = KHexColor(@"#ffe0e5");
    [sectionView addSubview:shu];
    
       
    UIImageView *baoChangeImage = [UIImageView new];
    baoChangeImage.image = section == 0 ?[UIImage imageNamed:@"pregnant_14mother"] :[UIImage imageNamed:@"pregnant_15mother"];
    [sectionView addSubview:baoChangeImage];
    
      
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = section == 0 ? @"宝宝变化" : @"宝妈变化";
    [sectionView addSubview:titleLabel];
    
    [shu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sectionView.mas_top).offset(0);
        make.left.equalTo(25);
        make.width.equalTo(10);
        make.height.equalTo(40);
    }];
    [baoChangeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(shu.mas_centerX);
        make.centerY.equalTo(shu.mas_centerY);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shu.mas_right).offset(20);
        make.centerY.equalTo(shu.mas_centerY);
        make.width.equalTo(titleLabel.mas_width);
        make.height.equalTo(17);
    }];
    
    return sectionView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0 == section ? 1 : _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return [BabyAndMotherCustomCell heightForCellRow:self.baobao];
    }
    else
    {
        BabyAndMotherModel *model = _dataArray[indexPath.row];
        return [BabyAndMotherCustomCell heightForCellRow:[NSString stringWithFormat:@"%@: %@",model.title,model.content]];
        return  200;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    BabyAndMotherCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[BabyAndMotherCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
  
    if (indexPath.section == 0) {
        cell.babyChangeDetailLabel.text = self.baobao;
    }
    else
    {
        cell.babyModel = _dataArray[indexPath.row];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],@"week":[NSNumber numberWithInteger:self.week]} method:@"renhe.system.getMomChange" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            self.dataDic = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"][0];
            self.baobao = [self.dataDic objectForKey:@"babyChange"];
            NSArray *dataArr = [self.dataDic objectForKey:@"momChange"];
            
            for (int i = 0; i <dataArr.count; i++) {
                BabyAndMotherModel *model = [[BabyAndMotherModel alloc] initWithDictionary:dataArr[i]];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
        
    } errorBlock:^(NSError *error) {
    }];
}

@end
