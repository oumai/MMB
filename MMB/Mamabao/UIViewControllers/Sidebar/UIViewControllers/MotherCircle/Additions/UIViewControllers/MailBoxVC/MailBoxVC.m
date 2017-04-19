//
//  MailBoxVC.m
//  Mamabao
//
//  Created by Michael on 15/12/8.
//  Copyright © 2015年 Michael. All rights reserved.
//

/*-----------------------------------------------------------------------M-------------------------------------------*/
@interface MailBoxModel  : NSObject

@property (nonatomic, strong) NSString *backUserId;
@property (nonatomic, strong) NSString *discuss_id;
@property (nonatomic, strong) NSString *post_id;
@property (nonatomic, strong) NSString *backId;


@property (nonatomic, strong) NSString *discuss;
@property (nonatomic, strong) NSString *backUserName;
@property (nonatomic, strong) NSString *backText;
@property (nonatomic, strong) NSString *backUserImg;
@property (nonatomic, strong) NSString *isRead;
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

@interface MailBoxModel ()

@end

@implementation MailBoxModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([[dic objectForKey:@"backUserId"] isKindOfClass:[NSNumber class]])
        {
            self.backUserId = [[dic objectForKey:@"backUserId"] stringValue];
        }
        if ([[dic objectForKey:@"backId"] isKindOfClass:[NSNumber class]])
        {
            self.backId = [[dic objectForKey:@"backId"] stringValue];
        }
        if ([[dic objectForKey:@"discuss_id"] isKindOfClass:[NSNumber class]])
        {
            self.discuss_id = [[dic objectForKey:@"discuss_id"] stringValue];
        }
        if ([[dic objectForKey:@"post_id"] isKindOfClass:[NSNumber class]])
        {
            self.post_id = [[dic objectForKey:@"post_id"] stringValue];
        }
        
        if ([dic objectForKey:@"backUserName"]) {
            self.backUserName = [dic objectForKey:@"backUserName"];
        }
        if ([dic objectForKey:@"backText"]) {
            self.backText = [dic objectForKey:@"backText"];
            
        }
        if ([dic objectForKey:@"backUserImg"]) {
            self.backUserImg = [dic objectForKey:@"backUserImg"];
        }
        if ([[dic objectForKey:@"isRead"] isKindOfClass:[NSNumber class]]) {
            self.isRead = [[dic objectForKey:@"isRead"] stringValue];
        }
       
        
    }
    return self;
}

@end

/*-----------------------------------------------------------------------V-------------------------------------------*/
@interface MailBoxCustomCell : UITableViewCell

@property (nonatomic, strong) MailBoxModel *mamiModel;

@end

@interface MailBoxCustomCell ()

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIImageView *readImage;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) TTTAttributedLabel *backText;

@end

@implementation MailBoxCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = KHexColor(@"#f3f3f3");
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        self.cellView = [UIView new];
        self.cellView.backgroundColor = KHexColor(@"#ffffff");
        self.cellView.layer.cornerRadius = 5;
        self.cellView.layer.masksToBounds = YES;
        [self.contentView addSubview:_cellView];
        
        
        self.iconImage = [UIImageView new];
        self.iconImage.layer.cornerRadius = 27.5;
        self.iconImage.layer.masksToBounds = YES;
        self.iconImage.image = [UIImage imageNamed:@"circle_3mother"];
        [self.contentView addSubview:_iconImage];
        
        self.titleLabel = [TTTAttributedLabel new];
        self.titleLabel.textColor = KHexColor(@"#333333");
        self.titleLabel.font = KFontSize(14);
        self.titleLabel.text = @"我是昵称";
        [self.contentView addSubview:_titleLabel];
        
        
        self.backText = [TTTAttributedLabel new];
        self.backText.numberOfLines = 0;
        self.backText.font = KFontSize(12);
        self.backText.textColor = KHexColor(@"#666666");
        self.backText.lineSpacing = 5;
        [self.contentView addSubview:_backText];
        
        self.readImage = [UIImageView new];
        [self.contentView addSubview:_readImage];
        
        
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
        
        [_backText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
            make.left.equalTo(self.iconImage.mas_right).offset(5);
            make.right.equalTo(self.cellView.mas_right).offset(-5);
            make.height.equalTo(12);
            //make.bottom.equalTo(self.cellView.mas_bottom).offset(-5);
        }];
        
        [_readImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel.mas_centerY).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.width.equalTo(28);
            make.height.equalTo(13);
        }];

        
    }
    return self;
}


- (void)setMamiModel:(MailBoxModel *)mamiModel
{
    if (nil == mamiModel) {
        return;
    }
    if ([mamiModel.isRead isEqualToString:@"0"]) {
        self.readImage.image = [UIImage imageNamed:@"unread"];
    }
    self.titleLabel.text = mamiModel.backUserName;
    self.backText.text = mamiModel.backText;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:mamiModel.backUserImg] placeholderImage:nil];
}
@end


/*-----------------------------------------------------------------------C-------------------------------------------*/
#import "MailBoxVC.h"
#import "MessageDetailVC.h"
@interface MailBoxVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@end
@implementation MailBoxVC
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
    self.title = @"消息列表";
    NavigationBarTitleColor
    self.user = [[ASUserInfoModel alloc] init];
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor =  KHexColor(@"#f3f3f3");
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 80;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.view.mas_top).offset(5);
         make.left.bottom.right.equalTo(self.view);
     }];
    [self requestData];
}

#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell_ma";
    MailBoxCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[MailBoxCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.mamiModel = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MailBoxModel *model = _dataArray[indexPath.row];
    MessageDetailVC *message = [MessageDetailVC new];
    message.backUserName = model.backUserName;
    message.backText = model.backText;
    message.backId = model.backId;
    message.post_id = model.post_id;
    message.discuss_id = model.discuss_id;
    message.backUserId = model.backUserId;
    [_tableView reloadData];
    [self.navigationController pushViewController:message animated:YES];
    
}
#pragma mark ------------------------------------------------------------------ASURLConnection----------------------------------------------------------------
- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],@"pageNum":@1,@"pageSize":@10} method:@"renhe.momCircle.noReadMsgDetail" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"];
            for (int i = 0; i<dataArr.count; i ++)
            {
                
                MailBoxModel *model = [[MailBoxModel alloc] initWithDictionary:dataArr[i]];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
}

@end
