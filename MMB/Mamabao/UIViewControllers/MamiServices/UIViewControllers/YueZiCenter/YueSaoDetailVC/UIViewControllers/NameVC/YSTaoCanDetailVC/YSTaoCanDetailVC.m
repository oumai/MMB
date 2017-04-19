//
//  YSTaoCanDetailVC.m
//  Mamabao
//
//  Created by Michael on 15/12/14.
//  Copyright © 2015年 Michael. All rights reserved.
//

/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface   YSTaoCanDetailModel: NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface YSTaoCanDetailModel ()

@property (nonatomic, strong) NSString *canBuyStart;
@property (nonatomic, strong) NSString *canBuyEnd;

@end

@implementation YSTaoCanDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([dic objectForKey:@"canBuyEnd"]) {
            self.canBuyEnd = [dic objectForKey:@"canBuyEnd"];
        }
        if ([dic objectForKey:@"canBuyStart"]) {
            self.canBuyStart = [dic objectForKey:@"canBuyStart"];
        }
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/
@interface YSTaoCanDetailTaoCanContenCell : UITableViewCell

+(CGFloat)heightForRowString:(NSString *)string;

@end



@interface YSTaoCanDetailTaoCanContenCell ()

@property (nonatomic, strong) TTTAttributedLabel *detailLabel;

@end

@implementation YSTaoCanDetailTaoCanContenCell

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
@interface YSXuZhiCustomCell : UITableViewCell

+(CGFloat)heightForRowString:(NSString *)string;

@end



@interface YSXuZhiCustomCell ()
@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) TTTAttributedLabel *xuZhiLabel;

@end

@implementation YSXuZhiCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        self.cellView = [UIView new];
        self.cellView.layer.cornerRadius = 5;
        self.cellView.layer.masksToBounds = YES;
        self.cellView.layer.borderColor = KHexColor(@"#ecebec").CGColor;
        self.cellView.layer.borderWidth = 1;
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


/*-----------------------------------------------------------------------V-------------------------------------------*/
@interface YSKeYuYueTimeCell : UITableViewCell
@property (nonatomic, strong) YSTaoCanDetailModel *keYuModel;
@property (nonatomic, strong) void(^myBlock)();
@end



@interface YSKeYuYueTimeCell ()
@property (nonatomic, strong) TTTAttributedLabel *daoLabel;
@property (nonatomic, strong) TTTAttributedLabel *canBuyStartLabel;
@property (nonatomic, strong) TTTAttributedLabel *canBuyEndLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *goYuYueButton;
@end

@implementation YSKeYuYueTimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.daoLabel = [TTTAttributedLabel new];
        self.daoLabel.font = KFontSize(14);
        self.daoLabel.textColor = KHexColor(@"#906e50");
        self.daoLabel.lineSpacing = 5;
        self.daoLabel.numberOfLines = 0;
        self.daoLabel.text = @"到";
        [self.contentView addSubview:_daoLabel];
        
        
        self.canBuyStartLabel = [TTTAttributedLabel new];
        self.canBuyStartLabel.font = KFontSize(14);
        self.canBuyStartLabel.textColor = KHexColor(@"#906e50");
        self.canBuyStartLabel.lineSpacing = 5;
        self.canBuyStartLabel.numberOfLines = 0;
        [self.contentView addSubview:_canBuyStartLabel];
        
        
        self.canBuyEndLabel = [TTTAttributedLabel new];
        self.canBuyEndLabel.font = KFontSize(14);
        self.canBuyEndLabel.textColor = KHexColor(@"#906e50");
        self.canBuyEndLabel.lineSpacing = 5;
        self.canBuyEndLabel.numberOfLines = 0;
        [self.contentView addSubview:_canBuyEndLabel];
        
        self.goYuYueButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.goYuYueButton.layer.cornerRadius = 3;
        self.goYuYueButton.layer.masksToBounds = YES;
        self.goYuYueButton.titleLabel.font = KFontSize(14);
        [self.goYuYueButton setTitle:@"预约" forState:UIControlStateNormal];
        [self.goYuYueButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
        [self.goYuYueButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff879a")] forState:UIControlStateNormal];
        [self.goYuYueButton addTarget:self action:@selector(goYuYueButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_goYuYueButton];
        
        self.line = [UIView new];
        self.line.frame = CGRectMake(0, 44.5, CoreWidth, 0.5);
        self.line.backgroundColor = KHexColor(@"#c5c5c5");
        [self.contentView addSubview:_line];
       
        
        [_canBuyStartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.width.equalTo(self.canBuyStartLabel.mas_width);
            make.height.equalTo(14);
        }];
        
        [_daoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.left.equalTo(self.canBuyStartLabel.mas_right).offset(10);
            make.width.equalTo(self.daoLabel.mas_width);
            make.height.equalTo(14);
        }];

        
        
        [_canBuyEndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.left.equalTo(self.daoLabel.mas_right).offset(10);
            make.width.equalTo(self.canBuyEndLabel.mas_width);
            make.height.equalTo(14);
        }];
        
        [_goYuYueButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.width.equalTo(60);
            make.height.equalTo(30);
        }];

    }

    return self;
}

- (void)setKeYuModel:(YSTaoCanDetailModel *)keYuModel
{
    if (nil ==keYuModel) {
        return;
    }
    self.canBuyStartLabel.text = keYuModel.canBuyStart;
    self.canBuyEndLabel.text = keYuModel.canBuyEnd;
}



- (void)goYuYueButtonClick
{
    if (self.myBlock) {
        self.myBlock();
    }
}

@end




/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "YSTaoCanDetailVC.h"
#import "GeRenXinXiVC.h"
@interface YSTaoCanDetailVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSArray *xuZhiArray;
@property (nonatomic, strong) NSMutableArray *keYuYueTimeArray;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) UIView *gouMaiView;
@property (nonatomic, strong) UIImageView *gouMaiImage;
@property (nonatomic, strong) TTTAttributedLabel *gouMaiLabel;
@property (nonatomic, strong) UIView *gouMaiLine;
@property (nonatomic, strong) TTTAttributedLabel *gouMaiLabel1;
@property (nonatomic, strong) TTTAttributedLabel *gouMaiLabel2;

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
@property (nonatomic, strong) UITextField *gerRenstartTF;
@property (nonatomic, strong) UITextField *gerRenendTF;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation YSTaoCanDetailVC

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
    self.xuZhiArray = [NSArray array];
    self.keYuYueTimeArray = [NSMutableArray array];
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
}

#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 35)];
    sectionView.backgroundColor = KHexColor(@"#eeedee");
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = 0 == section ?[UIImage imageNamed:@"detail"] : 1 == section ? [UIImage imageNamed:@"remind"] : [UIImage imageNamed:@"information"];
    [sectionView addSubview:imageView];
    
    UILabel *sectionLabel = [UILabel new];
    sectionLabel.font = KFontSize(14);
    sectionLabel.textColor = KHexColor(@"#5d5d5d");
    sectionLabel.text = 0 == section ? @"套餐详情" : 1 == section ? @"购买须知" : @"可预约时间";
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2 == section ? [_keYuYueTimeArray count] : 1 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 0 == indexPath.section ? [YSTaoCanDetailTaoCanContenCell heightForRowString:[self.dataDic objectForKey:@"text"]] : 1 == indexPath.section ? [YSTaoCanDetailTaoCanContenCell heightForRowString:[self.dataDic objectForKey:@"text"]] : 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *identifier = @"cell";
        YSTaoCanDetailTaoCanContenCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (nil == cell) {
            cell = [[YSTaoCanDetailTaoCanContenCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        }
        
        cell.detailLabel.text= [self.dataDic objectForKey:@"text"];
        
        return cell;
        
    }
    
    else if (indexPath.section == 1)
    {
        static NSString *identifier = @"cellXZ";
        YSXuZhiCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (nil == cell) {
            cell = [[YSXuZhiCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        }
        cell.xuZhiLabel.text =  [self.dataDic objectForKey:@"buyKnow"];
        return cell;

    }
    else
    {
        static NSString *identifier = @"cellXK";
        YSKeYuYueTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (nil == cell) {
            cell = [[YSKeYuYueTimeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        }
        cell.keYuModel = _keYuYueTimeArray[indexPath.row];
        [cell setMyBlock:^{
            GeRenXinXiVC *vc = [[GeRenXinXiVC alloc] init];
            vc.startString = cell.canBuyStartLabel.text;
            vc.endString = cell.canBuyEndLabel.text;
            vc.entity_id = self.entity_id;
            vc.nanny_id = self.nanny_id;
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
        return cell;

    }
}


#pragma mark ------------------------------------------------------------------ASURLConnection----------------------------------------------------------------
- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{@"package_id":self.nanny_id,@"isPerson":@1} method:@"renhe.momService.queryPackage" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {

        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            self.dataDic = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"][0];
            NSArray *dataArray = [self.dataDic objectForKey:@"times"];
            for (NSDictionary *dic in dataArray) {
                YSTaoCanDetailModel *model = [[YSTaoCanDetailModel alloc] initWithDictionary:dic];
                [_keYuYueTimeArray addObject:model];
            }
            [_tableView reloadData];
        }
    } errorBlock:^(NSError *error) {

    }];
}

@end
