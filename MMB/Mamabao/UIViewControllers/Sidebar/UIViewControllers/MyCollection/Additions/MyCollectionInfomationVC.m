//
//  MyCollectionInfomationVC.m
//  Mamabao
//
//  Created by Michael on 15/11/14.
//  Copyright © 2015年 Michael. All rights reserved.
//
/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface MyCollectionInfomationModel  : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *share;
@property (nonatomic, strong) NSString *collect;
@property (nonatomic, strong) NSString *pageView;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *title;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface MyCollectionInfomationModel ()

@end

@implementation MyCollectionInfomationModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([[dic objectForKey:@"share"]isKindOfClass:[NSNumber class]]) {
            self.share = [[dic objectForKey:@"share"] stringValue];
        }
        if ([[dic objectForKey:@"collect"]isKindOfClass:[NSNumber class]]) {
            self.collect = [[dic objectForKey:@"collect"] stringValue];
        }
        if ([[dic objectForKey:@"pageView"]isKindOfClass:[NSNumber class]]) {
            self.pageView = [[dic objectForKey:@"pageView"] stringValue];
        }
        if ([dic objectForKey:@"title"]) {
            self.title = [dic objectForKey:@"title"];
        }
        if ([dic objectForKey:@"imageUrl"]) {
            self.imageUrl = [dic objectForKey:@"imageUrl"];
        }


        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface MyCollectionInfomationCustomCell : UITableViewCell

@property (nonatomic, strong) MyCollectionInfomationModel *myInfomationModel;

@end



@interface MyCollectionInfomationCustomCell ()

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIImageView *hideImage;
@property (nonatomic, strong) UIImageView *shareImage;
@property (nonatomic, strong) UIImageView *weiboImage;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) TTTAttributedLabel *weiboLabel;
@property (nonatomic, strong) TTTAttributedLabel *hideLabel;
@property (nonatomic, strong) TTTAttributedLabel *shareLabel;

@end

@implementation MyCollectionInfomationCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KHexColor(@"#f5f5f5");
        
        self.cellView = [UIView new];
        self.cellView.backgroundColor = KHexColor(@"#ffffff");
        self.cellView.layer.cornerRadius = 8;
        self.cellView.layer.masksToBounds = YES;
        self.cellView.layer.borderColor = KHexColor(@"#e6e6e6").CGColor;
        self.cellView.layer.borderWidth = 1;
        [self.contentView addSubview:_cellView];
        
        
        
        self.iconImage  = [UIImageView new];
        self.iconImage.image = [UIImage imageNamed:@"circle_20mother"];
        [self.contentView addSubview:_iconImage];
        
        
        
        self.titleLabel = [TTTAttributedLabel new];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textColor = KHexColor(@"#3333333");
        self.titleLabel.text = @"没住过月子中心还叫坐月子吗";
        [self.contentView addSubview:_titleLabel];
        
        self.shareLabel = [TTTAttributedLabel new];
        self.shareLabel.font = [UIFont systemFontOfSize:15];
        self.shareLabel.textColor = KHexColor(@"#8a8a8a");
        self.shareLabel.text = @"100";
        [self.contentView addSubview:_shareLabel];
        
        self.shareImage  = [UIImageView new];
        self.shareImage.image = [UIImage imageNamed:@"icon_notshare"];
        [self.contentView addSubview:_shareImage];
        
        
        
        self.hideLabel = [TTTAttributedLabel new];
        self.hideLabel.font = [UIFont systemFontOfSize:15];
        self.hideLabel.textColor = KHexColor(@"#8a8a8a");
        self.hideLabel.text = @"100";
        [self.contentView addSubview:_hideLabel];
        
        self.hideImage  = [UIImageView new];
        self.hideImage.image = [UIImage imageNamed:@"icon_notlike"];
        [self.contentView addSubview:_hideImage];
        
        
        self.weiboLabel = [TTTAttributedLabel new];
        self.weiboLabel.font = [UIFont systemFontOfSize:15];
        self.weiboLabel.textColor = KHexColor(@"#8a8a8a");
        self.weiboLabel.text = @"100";
        [self.contentView addSubview:_weiboLabel];
        
        self.weiboImage  = [UIImageView new];
        self.weiboImage.image = [UIImage imageNamed:@"icon_seen"];
        [self.contentView addSubview:_weiboImage];
        
        [_cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(7);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-7);
            make.right.equalTo(self.contentView.mas_right).offset(-7);
            
        }];

        
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cellView.mas_top).offset(7);
            make.left.equalTo(self.cellView.mas_left).offset(7);
            make.right.equalTo(self.cellView.mas_right).offset(-7);
            make.height.equalTo(94);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImage.mas_bottom).offset(10);
            make.left.equalTo(self.iconImage.mas_left).offset(0);
            make.width.equalTo(self.titleLabel.mas_width);
            make.height.equalTo(13);
        }];
        
        
        
        [_shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.cellView.mas_bottom).offset(-5);
            make.right.equalTo(self.cellView.mas_right).offset(-10);
            make.width.equalTo(self.shareLabel.mas_width);
            make.height.equalTo(17);
        }];
        [_shareImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shareLabel.mas_centerY).offset(0);
            make.right.equalTo(self.shareLabel.mas_left).offset(-5);
            make.width.equalTo(8);
            make.height.equalTo(7);
        }];
        [_hideLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.cellView.mas_bottom).offset(-5);
            make.right.equalTo(self.shareImage.mas_right).offset(-20);
            make.width.equalTo(self.hideLabel.mas_width);
            make.height.equalTo(17);
        }];
        [_hideImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shareLabel.mas_centerY).offset(0);
            make.right.equalTo(self.hideLabel.mas_left).offset(-5);
            make.width.equalTo(10);
            make.height.equalTo(8);
        }];
        [_weiboLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.cellView.mas_bottom).offset(-5);
            make.right.equalTo(self.hideImage.mas_right).offset(-20);
            make.width.equalTo(self.weiboLabel.mas_width);
            make.height.equalTo(17);
        }];
        
        [_weiboImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shareLabel.mas_centerY).offset(0);
            make.right.equalTo(self.weiboLabel.mas_left).offset(-5);
            make.width.equalTo(12);
            make.height.equalTo(7);
        }];
        
        
        
    }
    return self;
}

- (void) setMyInfomationModel:(MyCollectionInfomationModel *)myInfomationModel
{
    if (nil == myInfomationModel) {
        return;
    }
    self.hideLabel.text = myInfomationModel.collect;
    self.shareLabel.text = myInfomationModel.share;
    self.weiboLabel.text = myInfomationModel.pageView;
    self.titleLabel.text = myInfomationModel.title;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:myInfomationModel.imageUrl] placeholderImage:nil];
}

@end


/*-----------------------------------------------------------------------C-------------------------------------------*/
#import "MyCollectionInfomationVC.h"
#import "ArticleDetailVC.h"
@interface MyCollectionInfomationVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MyCollectionInfomationVC

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
    self.title = @"资讯";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.user = [[ASUserInfoModel alloc] init];
    self.dataArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 160;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
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
    MyCollectionInfomationCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[MyCollectionInfomationCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.myInfomationModel = _dataArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ArticleDetailVC *article = [ArticleDetailVC new];
    [self.navigationController pushViewController:article animated:YES];
}

- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],@"type":@1,@"pageNum":@1,@"pageSize":@10} method:@"renhe.system.myCollect" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"];
            for (NSDictionary *dic in dataArr) {
                 MyCollectionInfomationModel *model = [[MyCollectionInfomationModel alloc] initWithDictionary:dic];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
           
        }
    } errorBlock:^(NSError *error) {
    }];
    
    
}
@end




