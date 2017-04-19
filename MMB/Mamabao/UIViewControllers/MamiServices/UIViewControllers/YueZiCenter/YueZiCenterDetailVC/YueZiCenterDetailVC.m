//
//  YueZiCenterDetail.m
//  Mamabao
//
//  Created by Michael on 15/11/12.
//  Copyright © 2015年 Michael. All rights reserved.
//
/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface YueZiCenterDetailModel  : NSObject

@property (nonatomic, strong) NSString *package_id;  //套餐列表啊
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *timeNum;

@property (nonatomic, strong) NSString *pingLun_id; //评论列表
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *userimg;
@property (nonatomic, strong) NSString *discuss;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *grade;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
- (instancetype)initWithPingLunDictionary:(NSDictionary *)dicP;
@end



@interface YueZiCenterDetailModel ()

@end

@implementation YueZiCenterDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([dic objectForKey:@"name"]) {
            self.name = [dic objectForKey:@"name"];
        }
        if ([[dic objectForKey:@"price"] isKindOfClass:[NSNumber class]]) {
            self.price = [[dic objectForKey:@"price"] stringValue];
        }
        if ([dic objectForKey:@"imgUrl"]) {
            self.imgUrl = [dic objectForKey:@"imgUrl"];
        }
        if ([dic objectForKey:@"timeNum"]) {
            self.timeNum = [dic objectForKey:@"timeNum"];
        }
        if ([[dic objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
            self.package_id = [[dic objectForKey:@"id"] stringValue];
        }
    }
    return self;
}

- (instancetype)initWithPingLunDictionary:(NSDictionary *)dicP
{
    if (self == [super init]) {
        
        if ([dicP objectForKey:@"username"]) {
            self.username = [dicP objectForKey:@"username"];
        }
        if ([dicP objectForKey:@"userimg"]) {
            self.userimg = [dicP objectForKey:@"userimg"];
        }
        
        if ([dicP objectForKey:@"discuss"]) {
            self.discuss = [dicP objectForKey:@"discuss"];
        }
        
        if ([dicP objectForKey:@"addTime"]) {
            self.addTime = [dicP objectForKey:@"addTime"];
        }

    }
    return self;
}
@end


/*-----------------------------------------------------------------------V-------------------------------------------*/
@interface YueZiCenterDetailCustomCell : UITableViewCell
@property (nonatomic, strong) void(^reserverBlock)();
@property (nonatomic, strong) YueZiCenterDetailModel *yueZiDetailModel;

@end



@interface YueZiCenterDetailCustomCell ()

@property (nonatomic, strong) NSString *package_id;
@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) TTTAttributedLabel *taoCanLabel;
@property (nonatomic, strong) TTTAttributedLabel *ServiceTime;
@property (nonatomic, strong) TTTAttributedLabel *moneyLabel;
@property (nonatomic, strong) UIButton *payButton;

@end

@implementation YueZiCenterDetailCustomCell

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
        self.iconImage.layer.cornerRadius = 5;
        self.iconImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconImage];
        
        
        
        self.taoCanLabel = [TTTAttributedLabel new];
        self.taoCanLabel.textColor = KHexColor(@"#333333");
        self.taoCanLabel.font = KFontSize(13);
        [self.contentView addSubview:_taoCanLabel];
        
        
        
        self.ServiceTime = [TTTAttributedLabel new];
        self.ServiceTime.textColor = KHexColor(@"#999999");
        self.ServiceTime.font = KFontSize(13);
        [self.contentView addSubview:_ServiceTime];
        
        
        
        self.moneyLabel = [TTTAttributedLabel new];
        self.moneyLabel.font = KFontSize(13);
        self.moneyLabel.textColor = KHexColor(@"#ff7e79");
        [self.contentView addSubview:_moneyLabel];
        
        
        
        self.payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.payButton.titleLabel.font = KFontSize(15);
        self.payButton.layer.cornerRadius = 5;
        self.payButton.layer.masksToBounds = YES;
        self.payButton.titleLabel.font = KFontSize(14);
        [self.payButton addTarget:self action:@selector(reservationButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.payButton setTitle:@"预定" forState:UIControlStateNormal];
        [self.payButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
        [self.payButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff9742")] forState:UIControlStateNormal];
        [self.contentView addSubview:_payButton];
        
        
        
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
        
        
        
        
        [_taoCanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImage.mas_top).offset(8);
            make.left.equalTo(self.iconImage.mas_right).offset(15);
            make.width.equalTo(self.taoCanLabel.mas_width);
            make.height.equalTo(13);
        }];
        
        
        [_ServiceTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.iconImage.mas_bottom).offset(-8);
            make.left.equalTo(self.iconImage.mas_right).offset(15);
            make.width.equalTo(self.ServiceTime.mas_width);
            make.height.equalTo(13);
        }];

        
        
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.taoCanLabel.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(160);
            make.width.equalTo(self.moneyLabel.mas_width);
            make.height.equalTo(15);
            
        }];
        
        [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.right.equalTo(self.cellView.mas_right).offset(-15);
            make.width.equalTo(50);
            make.height.equalTo(25);
        }];
        
        
    }
    return self;
}


- (void)reservationButtonClick
{
 
    if (self.reserverBlock) {
        self.reserverBlock();
    }
}

- (void)setYueZiDetailModel:(YueZiCenterDetailModel *)yueZiDetailModel
{
    if (nil == yueZiDetailModel) {
        return;
    }
    self.package_id = yueZiDetailModel.package_id;
    self.taoCanLabel.text = yueZiDetailModel.name;
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元", yueZiDetailModel.price];
    self.ServiceTime.text = [NSString stringWithFormat:@"服务时间       %@",yueZiDetailModel.timeNum];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:yueZiDetailModel.imgUrl] placeholderImage:nil];

}

@end
/*-----------------------------------------------------------------------V-------------------------------------------*/
@interface  PingLunCustomCell: UITableViewCell

@property (nonatomic, strong) YueZiCenterDetailModel *pingLunModel;

@end

@interface PingLunCustomCell ()
@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIImageView *xinImage1;
@property (nonatomic, strong) TTTAttributedLabel *nameLabel;
@property (nonatomic, strong) TTTAttributedLabel *pingLunLabel;

@end

@implementation PingLunCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellView = [UIView new];
        self.cellView.backgroundColor = KHexColor(@"#ffffff");
        self.cellView.layer.cornerRadius = 5;
        self.cellView.layer.masksToBounds = YES;
        self.cellView.layer.borderColor = KHexColor(@"#e6e6e6").CGColor;
        self.cellView.layer.borderWidth = 1;
        [self.contentView addSubview:_cellView];
        
        
        
        self.iconImage = [UIImageView new];
        [self.contentView addSubview:_iconImage];
        
        self.xinImage1 = [UIImageView new];
        //self.xinImage1.image = [UIImage imageNamed:@"evaluation"];//满意evaluation3  不满意evaluation2
        [self.contentView addSubview:_xinImage1];
        
        
        self.nameLabel = [TTTAttributedLabel new];
        self.nameLabel.textColor = KHexColor(@"#333333");
        self.nameLabel.font = KFontSize(13);
        [self.contentView addSubview:_nameLabel];
        
        
        self.pingLunLabel = [TTTAttributedLabel new];
        self.pingLunLabel.font = KFontSize(13);
        self.pingLunLabel.textColor = KHexColor(@"#999999");
        [self.contentView addSubview:_pingLunLabel];
        
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
        
        
        [_xinImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImage.mas_centerY).offset(0);
            make.right.equalTo(self.cellView.mas_right).offset(-20);
            make.width.equalTo(15);
            make.height.equalTo(15);
        }];
        
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImage.mas_centerY).offset(0);
            make.left.equalTo(self.iconImage.mas_right).offset(15);
            make.width.equalTo(self.nameLabel.mas_width);
            make.height.equalTo(13);
        }];
        
        
        
        [_pingLunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.cellView.mas_bottom).offset(-7);
            make.left.equalTo(self.nameLabel.mas_left).offset(0);
            make.width.equalTo(self.pingLunLabel.mas_width);
            make.height.equalTo(15);
            
        }];
        
    }
    
    return self;
}

- (void)setPingLunModel:(YueZiCenterDetailModel *)pingLunModel
{
    if (nil == pingLunModel) {
        return;
    }
    self.iconImage.image = [UIImage imageNamed:@"circle_12mothe"];
    self.nameLabel.text = pingLunModel.username;
    self.pingLunLabel.text = pingLunModel.discuss;
    self.xinImage1.image = [pingLunModel.grade isEqualToString:@"1"] ? [UIImage imageNamed:@"evaluation"] : [pingLunModel.grade isEqualToString:@"0"] ?  [UIImage imageNamed:@"evaluation2"] :[UIImage imageNamed:@"evaluation3"] ;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:pingLunModel.userimg] placeholderImage:nil];
    
}
@end

/*-----------------------------------------------------------------------C-------------------------------------------*/
#import "YueZiCenterDetailVC.h"
#import "YueZiDetailTaoCanVC.h"
#import "KeYuYueCanGuanVC.h"
#import "SQImagePlayerView.h"               //滑动的图片
#import "UIScrollView+SQParallaxHeader.h"   //滑动的图片
@interface YueZiCenterDetailVC ()<UITableViewDataSource,UITableViewDelegate,SQImagePlayerViewDelegate>
@property (nonatomic, strong) SQImagePlayerView *imagePlayerView;
@property (nonatomic, strong) NSArray *dataImage;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *taoCanDataArray;
@property (nonatomic, strong) NSMutableArray *pingLunArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *sectionView0;
@property (nonatomic, strong) UIView *sectionView1;
@property (nonatomic, strong) UIView *sectionView2;
@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UIImageView *bottomImage;
@property (nonatomic, strong) UIView *callView;
@property (nonatomic, strong) UIView *locationView;
@property (nonatomic, strong) UIImageView *callImage;
@property (nonatomic, strong) UIImageView *locationImage;
@property (nonatomic, strong) TTTAttributedLabel *callLabel;
@property (nonatomic, strong) TTTAttributedLabel *locationLabel;
@property (nonatomic, strong) TTTAttributedLabel *indroduceLabel;
@property (nonatomic, strong) UIButton *callButton;
@property (nonatomic, strong) UIButton *locationButton;
@property (nonatomic, strong) UIImageView *sectionImage;
@property (nonatomic, strong) UILabel *sectionLabel;
@property (nonatomic, strong) UIImageView *sectionImage2;
@property (nonatomic, strong) UILabel *sectionLabel2;

@end

@implementation YueZiCenterDetailVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"预约参观" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightClick)];
        self.navigationItem.rightBarButtonItem = right;
        right.tintColor = KHexColor(@"#ffffff");
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.navigationTitle;
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.dataArray = [NSMutableArray array];
    self.taoCanDataArray = [NSMutableArray array];
    self.pingLunArray = [NSMutableArray array];
    self.dataImage = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    self.tableView.backgroundColor = KHexColor(@"#ffffff");
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 80;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    self.imagePlayerView = [[SQImagePlayerView alloc]initWithFrame:CGRectMake(0, 0, CoreWidth, 167)];   //滑动图片
    self.imagePlayerView.pageControlPosition = SQPageControlPosition_BottomRight;
    [self.imagePlayerView initWithCount:_dataImage.count == 0 ? 0 : _dataImage.count delegate:self];
    [_tableView setParallaxHeaderView:_imagePlayerView mode:SQParallaxHeaderModeFill height:167];
    [self requestData];
}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------

- (void)callButtonClick
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.callLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)locationButtonClick
{
    
}
- (void)sectionButtonClick
{
    
}

- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightClick
{
    KeYuYueCanGuanVC *ke = [KeYuYueCanGuanVC new];
    [self.navigationController pushViewController:ke animated:YES];
}

#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
+ (CGFloat)heightFotIntroduce:(NSString *)string
{
    CGFloat bottomSpace = 16;
    CGFloat stringHeight = [NSAttributedString contentHeightWithText:string width:CoreWidth - 20 fontSize:14 lineSpacing:4];
    return bottomSpace + stringHeight + 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return section == 0 ? 40 : section == 1 ? 100 : 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        if (section == 0)
    {
        [self makeSection0View];
        if (_dataArray.count > 0)
        {
            self.indroduceLabel.text = [self.dataArray[0] objectForKey:@"content"];
        }

        return _sectionView0;
    }
    else if (section == 1)
    {
        [self makesection1View];
        if (_dataArray.count > 0)
        {
            self.callLabel.text = [self.dataArray[0] objectForKey:@"phone"];
            self.locationLabel.text = [self.dataArray[0] objectForKey:@"address"];
        }

        return _sectionView1;
    }
    
    else
    {
        [self makesection2View];
        return _sectionView2;
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 0 : section == 1 ? [_taoCanDataArray count] : [_pingLunArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return nil;
    }
    else if (indexPath.section == 1)
    {
        static NSString *identifier = @"cell";
        YueZiCenterDetailCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (nil == cell)
        {
            cell = [[YueZiCenterDetailCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        }
        cell.yueZiDetailModel = _taoCanDataArray[indexPath.row];
        [cell setReserverBlock:^{
            YueZiDetailTaoCanVC *vc = [YueZiDetailTaoCanVC new];
            vc.package_id = cell.package_id;
            vc.packageName = cell.taoCanLabel.text;
            vc.entity_id = self.entity_id;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        return cell;
    }
    else
    {
        static NSString *identifierP = @"pingLun_cell";
        PingLunCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierP];
        if (nil == cell) {
            cell = [[PingLunCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifierP];
        }
        cell.pingLunModel = _pingLunArray[indexPath.row];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       
}
#pragma mark ------------------------------------------------------------------ASURLConnection-------------------------------------------------------------------
- (void)requestData
{
    //套餐
    [ASURLConnection requestAFNJSon:@{@"entity_id":self.entity_id} method:@"renhe.momService.entityDetail" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            self.dataArray = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"];//字典接受没有objectAtIndex
            self.callLabel.text = [self.dataArray[0] objectForKey:@"phone"];
            self.locationLabel.text = [self.dataArray[0] objectForKey:@"address"];
            self.indroduceLabel.text = [self.dataArray[0] objectForKey:@"content"];
            [self backData];
        }
        
        [_tableView reloadData];
    } errorBlock:^(NSError *error) {
    }];
    
    //评论
    [ASURLConnection requestAFNJSon:@{@"entity_id":self.entity_id,@"pageNum":@1} method:@"renhe.momService.entityDiscussCutPage" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            NSArray *dataArrP = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            for (NSDictionary *dic in dataArrP)
            {
                YueZiCenterDetailModel *model = [[YueZiCenterDetailModel alloc] initWithPingLunDictionary:dic];
                [self.pingLunArray  addObject:model];
            }
            [_tableView reloadData];
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
    
 }

- (void)backData
{

    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[self.dataArray[0] objectForKey:@"imageUrl"]] placeholderImage:nil];
    NSString *string = [self.dataArray[0] objectForKey:@"imageUrl"];
    _dataImage = [string componentsSeparatedByString:@";"];
    [self.imagePlayerView initWithCount:_dataImage.count == 0 ? 0 : _dataImage.count delegate:self];
    
    if ([self.isNanny isEqualToString:@"0"]) {
        NSArray *dataArray = [self.dataArray[0] objectForKey:@"records"];                               //月子中心
        for (NSDictionary *dic in  dataArray)
        {
            YueZiCenterDetailModel *model = [[YueZiCenterDetailModel alloc] initWithDictionary:dic];
            [_taoCanDataArray addObject:model];
        }
    }
    
}

#pragma mark - SQImagePlayerViewDelegate
- (NSInteger)numberOfItems
{
    return _dataImage.count;
}
- (void)imagePlayerView:(SQImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:_dataImage[index]] placeholderImage:nil];
}

#pragma mark - Action
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView shouldPositionParallaxHeader];
}
#pragma mark ------------------------------------------------------------------Self makeUI -------------------------------------------------------------------
- (void)makeSection0View
{
    self.sectionView0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 40)];
    self.indroduceLabel = [TTTAttributedLabel new];
    self.indroduceLabel.textColor = KHexColor(@"#616161");
    self.indroduceLabel.lineSpacing = 4;
    self.indroduceLabel.numberOfLines = 0;
    self.indroduceLabel.font = KFontSize(14);
    [self.sectionView0 addSubview:_indroduceLabel];
    
    [_indroduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sectionView0.mas_top).offset(10);
        make.left.equalTo(self.sectionView0.mas_left).offset(10);
        make.right.equalTo(self.sectionView0.mas_right).offset(-10);
        make.height.equalTo(40);
    }];

}
- (void)makesection2View
{
    self.sectionView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 30)];
    self.sectionView2.backgroundColor = KHexColor(@"#ffffff");
    
    
    self.sectionImage2 = [UIImageView new];
    self.sectionImage2.image = [UIImage imageNamed:@"list_information"];
    [self.sectionView2 addSubview:_sectionImage2];
    
    self.sectionLabel2 = [UILabel new];
    self.sectionLabel2.textColor = KHexColor(@"#856b6a");
    self.sectionLabel2.font = KFontSize(14);
    self.sectionLabel2.text = @"评论列表";
    [self.sectionView2 addSubview:_sectionLabel2];
    
    [_sectionImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sectionView2.mas_top).offset(10);
        make.left.equalTo(self.sectionView2.mas_left).offset(10);
        make.width.equalTo(15);
        make.height.equalTo(15);
    }];
    
    [_sectionLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sectionImage2.mas_centerY).offset(0);
        make.left.equalTo(self.sectionImage2.mas_right).offset(5);
        make.width.equalTo(self.sectionLabel2.mas_width);
        make.height.equalTo(15);
    }];

}
- (void)makesection1View
{
    
    self.sectionView1 = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 80)];
    self.sectionView1.backgroundColor = KHexColor(@"#ffffff");
    
    
    self.bottomImage = [UIImageView new];
    self.bottomImage.image = [UIImage imageNamed:@"the_bottom_bar"];
    [self.sectionView1 addSubview:_bottomImage];
    
    
    self.callView = [UIView new];
    [self.sectionView1 addSubview:_callView];
    
    
    self.callImage = [UIImageView new];
    self.callImage.image = [UIImage imageNamed:@"telephone"];
    [self.callView  addSubview:_callImage];
    
    
    self.callLabel = [TTTAttributedLabel new];
    self.callLabel.textColor = KHexColor(@"#666666");
    self.callLabel.font = KFontSize(14);
    [self.callView addSubview:_callLabel];
    
    
    self.callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.callButton addTarget:self action:@selector(callButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.sectionView1 addSubview:_callButton];
    
    
    self.locationView = [UIView new];
    [self.sectionView1 addSubview:_locationView];
    
    
    self.locationImage = [UIImageView new];
    self.locationImage.image = [UIImage imageNamed:@"address"];
    [self.callView  addSubview:_locationImage];
    
    
    self.locationLabel = [TTTAttributedLabel new];
    self.locationLabel.textColor = KHexColor(@"#666666");
    self.locationLabel.font = KFontSize(14);
    [self.callView addSubview:_locationLabel];
    
    
    
    self.locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.locationButton addTarget:self action:@selector(locationButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.sectionView1 addSubview:_locationButton];
    
    
    self.sectionImage = [UIImageView new];
    self.sectionImage.image = [UIImage imageNamed:@"service_19mother"];
    [self.sectionView1 addSubview:_sectionImage];
    
    self.sectionLabel = [UILabel new];
    self.sectionLabel.textColor = KHexColor(@"#856b6a");
    self.sectionLabel.font = KFontSize(14);
    self.sectionLabel.text = @"推荐列表";
    [self.sectionView1 addSubview:_sectionLabel];
    
    
    [_bottomImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sectionView1.mas_top).offset(5);
        make.left.equalTo(self.sectionView1.mas_left).offset(4);
        make.right.equalTo(self.sectionView1.mas_right).offset(-4);
        make.height.equalTo(65);
    }];
    
    [_callView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sectionView1.mas_top).offset(5);
        make.left.equalTo(self.sectionView1);
        make.right.equalTo(self.sectionView1.mas_centerX).offset(0);
        make.height.equalTo(65);
    }];
    [_callImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.callView.mas_centerX).offset(0);
        make.top.equalTo(self.callView.mas_top).offset(15);
        make.width.equalTo(21);
        make.height.equalTo(21);
    }];
    
    [_callLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.callView.mas_centerX).offset(0);
        make.top.equalTo(self.callImage.mas_bottom).offset(0);
        make.width.equalTo(self.callLabel.mas_width);
        make.height.equalTo(21);
    }];
    
    [_callButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.callView);
    }];
    
    
    [_locationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sectionView1.mas_top).offset(5);
        make.right.equalTo(self.sectionView1);
        make.left.equalTo(self.sectionView1.mas_centerX).offset(0);
        make.height.equalTo(65);
    }];
    
    [_locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.locationView.mas_centerX).offset(0);
        make.top.equalTo(self.locationView.mas_top).offset(15);
        make.width.equalTo(21);
        make.height.equalTo(21);
    }];
    
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.locationView.mas_centerX).offset(0);
        make.top.equalTo(self.locationImage.mas_bottom).offset(0);
        make.width.equalTo(self.locationLabel.mas_width);
        make.height.equalTo(21);
    }];
    
    [_locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.locationView);
    }];
    
    [_sectionImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sectionView1.mas_bottom).offset(-5);
        make.left.equalTo(self.sectionView1.mas_left).offset(10);
        make.width.equalTo(15);
        make.height.equalTo(15);
    }];
    
    [_sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sectionImage.mas_centerY).offset(0);
        make.left.equalTo(self.sectionImage.mas_right).offset(5);
        make.width.equalTo(self.sectionLabel.mas_width);
        make.height.equalTo(15);
    }];
}

@end


