//
//  ChiHuoLaMaCircleVC.m
//  Mamabao
//
//  Created by Michael on 15/11/13.
//  Copyright © 2015年 Michael. All rights reserved.
//
//
//  MyCollectionTieZiVC.m
//  Mamabao
//
//  Created by Michael on 15/11/14.
//  Copyright © 2015年 Michael. All rights reserved.
//
/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface AfterChanOfChiHuoModel: NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *post_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *context;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *userImg;
@property (nonatomic, strong) NSString *collectNum;
@property (nonatomic, strong) NSString *discussNum
;
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface AfterChanOfChiHuoModel ()

@end

@implementation AfterChanOfChiHuoModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([[dic objectForKey:@"post_id"] isKindOfClass:[NSNumber class]]) {
            self.post_id = [[dic objectForKey:@"post_id"] stringValue];
        }
        if ([[dic objectForKey:@""] isKindOfClass:[NSNumber class]]) {
            self.user_id = [[dic objectForKey:@""] stringValue];
        }
        if ([dic objectForKey:@"username"]) {
            self.username = [dic objectForKey:@"username"];
        }
        if ([dic objectForKey:@"title"]) {
            self.title = [dic objectForKey:@"title"];
        }
        if ([dic objectForKey:@"context"]) {
            self.context = [dic objectForKey:@"context"];
        }
        if ([dic objectForKey:@"userImg"]) {
            self.userImg = [dic objectForKey:@"userImg"];
        }
        if ([[dic objectForKey:@"collectNum"] isKindOfClass:[NSNumber class]]) {
            self.collectNum = [[dic objectForKey:@"collectNum"] stringValue];
        }
        if ([[dic objectForKey:@"discussNum"] isKindOfClass:[NSNumber class]]) {
            self.discussNum = [[dic objectForKey:@"discussNum"] stringValue];
        }
       
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface AfterChanOfChiHuoCustomCell: UITableViewCell

@property (nonatomic, strong) AfterChanOfChiHuoModel *afterOfChanModel;

@end


@interface AfterChanOfChiHuoCustomCell ()
@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIImageView *personNumberImage;
@property (nonatomic, strong) UIImageView *conmmentNumberImage;
@property (nonatomic, strong) TTTAttributedLabel *nameLabel;
@property (nonatomic, strong) TTTAttributedLabel *personNumberLabel;
@property (nonatomic, strong) TTTAttributedLabel *commentNumberLabel;
@property (nonatomic, strong) TTTAttributedLabel *articleTitleLabel;
@property (nonatomic, strong) TTTAttributedLabel *detailLabel;


@end

@implementation AfterChanOfChiHuoCustomCell

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
        
        
        self.iconImage = [UIImageView new];
        self.iconImage.layer.cornerRadius = 15;
        self.iconImage.layer.masksToBounds = YES;
        self.iconImage.image = [UIImage imageNamed:@"circle_12mothe"];
        [self.contentView addSubview:_iconImage];
        
        
        
        self.nameLabel = [TTTAttributedLabel new];
        self.nameLabel.textColor = KHexColor(@"#666666");
        self.nameLabel.font = KFontSize(14);
        self.nameLabel.text = [NSString stringWithFormat:@"Michael Jack"];
        [self.contentView addSubview:_nameLabel];
        
        
        
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#cccccc");
        [self.contentView addSubview:_line];
        
        self.commentNumberLabel = [TTTAttributedLabel new];
        self.commentNumberLabel.numberOfLines = 0;
        self.commentNumberLabel.lineSpacing = 5;
        self.commentNumberLabel.font = KFontSize(12);
        self.commentNumberLabel.textColor = KHexColor(@"#999999");
        [self.contentView addSubview:_commentNumberLabel];
        
        
        self.conmmentNumberImage = [UIImageView new];
        self.conmmentNumberImage.image = [UIImage imageNamed:@"circle_6mother"];
        [self.contentView addSubview:_conmmentNumberImage];
        
        
        self.personNumberLabel = [TTTAttributedLabel new];
        self.personNumberLabel.numberOfLines = 0;
        self.personNumberLabel.lineSpacing = 5;
        self.personNumberLabel.font = KFontSize(12);
        self.personNumberLabel.textColor = KHexColor(@"#999999");
        [self.contentView addSubview:_personNumberLabel];
        
        
        self.personNumberImage = [UIImageView new];
        self.personNumberImage.image = [UIImage imageNamed:@"circle_16mother"];
        [self.contentView addSubview:_personNumberImage];
        
        
        self.articleTitleLabel = [TTTAttributedLabel new];
        self.articleTitleLabel.textColor = KHexColor(@"#000000");
        self.articleTitleLabel.font = KFontSize(14);
        [self.contentView addSubview:_articleTitleLabel];
        
        
        self.detailLabel = [TTTAttributedLabel new];
        self.detailLabel.textColor = KHexColor(@"#999999");
        self.detailLabel.font = KFontSize(13);
        self.detailLabel.numberOfLines = 0;
        self.detailLabel.lineSpacing = 4;
        [self.contentView addSubview:_detailLabel];
        
        [_cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(7);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-7);
            make.right.equalTo(self.contentView.mas_right).offset(-7);
            
        }];
        
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cellView.mas_top).offset(15);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.width.equalTo(30);
            make.height.equalTo(30);
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImage.mas_centerY).offset(0);
            make.left.equalTo(self.iconImage.mas_right).offset(15);
            make.width.equalTo(self.nameLabel.mas_width);
            make.height.equalTo(14);
            
        }];
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.right.equalTo(self.cellView.mas_right).offset(-15);
            make.top.equalTo(self.iconImage.mas_bottom).offset(15);
            make.height.equalTo(0.5);
        }];
        
        [_commentNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.line.mas_bottom).offset(-7);
            make.right.equalTo(self.cellView.mas_right).offset(-20);
            make.width.equalTo(self.commentNumberLabel.mas_width);
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
            make.width.equalTo(self.commentNumberLabel.mas_width);
            make.height.equalTo(12);
            
        }];
        [_personNumberImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.commentNumberLabel.mas_centerY).offset(3);
            make.right.equalTo(self.personNumberLabel.mas_left).offset(-5);
            make.width.equalTo(14);
            make.height.equalTo(13);
        }];
        
        
        [_articleTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line.mas_top).offset(15);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.width.equalTo(self.articleTitleLabel.mas_width);
            make.height.equalTo(14);
            
        }];
        
        
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.articleTitleLabel.mas_bottom).offset(7);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.bottom.equalTo(self.cellView.mas_bottom).offset(-5);
            make.right.equalTo(self.cellView.mas_right).offset(-5);
            
        }];
        
        
    }
    return self;
}


- (void)setAfterOfChanModel:(AfterChanOfChiHuoModel *)afterOfChanModel
{
    if (nil == afterOfChanModel) {
        return;
    }
    self.nameLabel.text = afterOfChanModel.username;
    self.detailLabel.text = afterOfChanModel.context;
    self.articleTitleLabel.text = afterOfChanModel.title;
    self.personNumberLabel.text = afterOfChanModel.collectNum;
    self.commentNumberLabel.text = afterOfChanModel.discussNum;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:afterOfChanModel.userImg] placeholderImage:nil];
    
}


@end


/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "AfterChanOfChiHuoVC.h"
#import "TieZiDetailVC.h"
#import "FaBuZhuTiVC.h"
@interface AfterChanOfChiHuoVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AfterChanOfChiHuoVC




- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit"] style:(UIBarButtonItemStylePlain) target:self action:@selector(rightClicked)];
        self.navigationItem.rightBarButtonItem = right;
        right.tintColor = KHexColor(@"#ffffff");
        
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
    self.title = self.navigaitonTitle;
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.dataArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 200;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(7);
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

- (void)rightClicked
{
    FaBuZhuTiVC *faBut = [FaBuZhuTiVC new];
    faBut.circle_id = self.circle_id;
    [self.navigationController pushViewController:faBut animated:YES];
}

#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    AfterChanOfChiHuoCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[AfterChanOfChiHuoCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.afterOfChanModel = _dataArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AfterChanOfChiHuoModel *model = _dataArray[indexPath.row];
    TieZiDetailVC *detail = [TieZiDetailVC new];
    detail.post_id = model.post_id;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark ------------------------------------------------------------------ASURLConnection  -----------------------------------------------------------------------

- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{@"circle_id":self.circle_id,@"pageNum":@1,@"pageSize":@10} method:@"renhe.momCircle.circleDetail" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            for (NSDictionary *dic in dataArr) {
                AfterChanOfChiHuoModel *model = [[AfterChanOfChiHuoModel alloc] initWithDictionary:dic];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
}
@end








