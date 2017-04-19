//
//  ChanJianTimesVC.m
//  Mamabao
//
//  Created by Michael on 15/12/2.
//  Copyright © 2015年 Michael. All rights reserved.
//

/*-----------------------------------------------------------------------M-------------------------------------------*/
@interface ChanJianTimesModel  : NSObject

@property (nonatomic, strong) NSString *id_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *remind;
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface ChanJianTimesModel ()

@end

@implementation ChanJianTimesModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([[dic objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
            self.id_id = [[dic objectForKey:@"id"] stringValue];
        }
        if ([dic objectForKey:@"name"]) {
            self.name = [dic objectForKey:@"name"];
        }
        if ([dic objectForKey:@"desc"]) {
            self.desc = [dic objectForKey:@"desc"];
        }
        if ([dic objectForKey:@"remind"]) {
            self.remind = [dic objectForKey:@"remind"];
        }
        
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/
@interface ChanJianTimesCollectionCell : UICollectionViewCell

@end
@interface ChanJianTimesCollectionCell ()
@property (nonatomic, strong) TTTAttributedLabel *kindOfLabel;


@end

@implementation ChanJianTimesCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = KHexColor(@"#ff999a");
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        
        self.kindOfLabel = [TTTAttributedLabel new];
        self.kindOfLabel.font = KFontSize(14);
        self.kindOfLabel.textAlignment = NSTextAlignmentCenter;
        self.kindOfLabel.textColor = KHexColor(@"#ffffff");
        self.kindOfLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:_kindOfLabel];
        
        [_kindOfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX).offset(0);
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.width.equalTo(CoreWidth*0.3*0.75);
            make.height.equalTo(16);
        }];

    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/

@interface ChanJianTimesCustomCell : UITableViewCell
@property (nonatomic, strong) ChanJianTimesModel *customModel;
+(CGFloat) heightForRowString:(NSString *)string;

@end



@interface ChanJianTimesCustomCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) TTTAttributedLabel *contentLabel;

@end

@implementation ChanJianTimesCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KHexColor(@"#ebf7ec");
        self.bgView = [UIView new];
        self.bgView.layer.cornerRadius = 4;
        self.bgView.layer.masksToBounds = YES;
        self.bgView.layer.borderColor = KHexColor(@"#ffffff").CGColor;
        self.bgView.layer.borderWidth = 1;
        self.bgView.backgroundColor = KHexColor(@"#f6fbf6");
        [self.contentView addSubview:_bgView];
        
        
        
        self.contentLabel = [TTTAttributedLabel new];
        self.contentLabel.textColor = KHexColor(@"#999999");
        self.contentLabel.font = KFontSize(14);
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.lineSpacing = 5;
        [self.contentView addSubview:_contentLabel];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(7);
            make.left.equalTo(self.contentView.mas_left).offset(7);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-7);
            make.right.equalTo(self.contentView.mas_right).offset(-7);
            
            
        }];
        
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(13);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.right.equalTo(self.contentView.mas_right).offset(-13);
            
            
        }];

    }
    return self;
}

- (void)setCustomModel:(ChanJianTimesModel *)customModel
{
    if (nil == customModel) {
        return;
    }
    self.contentLabel.text = customModel.desc;
}
+(CGFloat) heightForRowString:(NSString *)string
{
    if (![string isValid]) {
        return 0;
    }
    
    CGFloat bottom = 16;
    CGFloat detailString = [NSAttributedString contentHeightWithText:string width:CoreWidth-20 fontSize:14 lineSpacing:5];
    return bottom + detailString +20;
}


@end

/*-----------------------------------------------------------------------V-------------------------------------------*/ //第二个cell

@interface ChanJianTimesCustomCellS : UITableViewCell
@property (nonatomic, strong) ChanJianTimesModel *customModel;
+(CGFloat) heightForRowString:(NSString *)string;

@end



@interface ChanJianTimesCustomCellS ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) TTTAttributedLabel *contentLabel;

@end

@implementation ChanJianTimesCustomCellS

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KHexColor(@"#ebf7ec");
        self.bgView = [UIView new];
        self.bgView.layer.cornerRadius = 4;
        self.bgView.layer.masksToBounds = YES;
        self.bgView.layer.borderColor = KHexColor(@"#ffffff").CGColor;
        self.bgView.layer.borderWidth = 1;
        self.bgView.backgroundColor = KHexColor(@"#f6fbf6");
        [self.contentView addSubview:_bgView];
        
        
        
        self.contentLabel = [TTTAttributedLabel new];
        self.contentLabel.textColor = KHexColor(@"#999999");
        self.contentLabel.font = KFontSize(14);
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.lineSpacing = 5;
        [self.contentView addSubview:_contentLabel];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(7);
            make.left.equalTo(self.contentView.mas_left).offset(7);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-7);
            make.right.equalTo(self.contentView.mas_right).offset(-7);
            
            
        }];
        
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(13);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
            make.right.equalTo(self.contentView.mas_right).offset(-13);
            
            
        }];
        
    }
    return self;
}

- (void)setCustomModel:(ChanJianTimesModel *)customModel
{
    if (nil == customModel) {
        return;
    }
    self.contentLabel.text = customModel.desc;
}
+(CGFloat) heightForRowString:(NSString *)string
{
    if (![string isValid]) {
        return 0;
    }
    
    CGFloat bottom = 16;
    CGFloat detailString = [NSAttributedString contentHeightWithText:string width:CoreWidth-20 fontSize:14 lineSpacing:5];
    return bottom + detailString +20;
}


@end


/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "ChanJianTimesVC.h"

static NSString *collectionID = @"ChanJianTimesCollectionCell";
static NSString  *mama = @"本产检仅供参考，不同医院产检项目略有不同请以产检医院为准";

@interface ChanJianTimesVC ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *descArray;
@property (nonatomic, strong) NSMutableArray *remindArray;
@property (nonatomic, strong) UIView *chanJianView;                 //产检项目
@property (nonatomic, strong) UIView *shuView;
@property (nonatomic, strong) UIImageView *chanJianImage;
@property (nonatomic, strong) TTTAttributedLabel *chanJianTitle;
@property (nonatomic, strong) UIView *niaoCView;                    //尿常规
@property (nonatomic, strong) TTTAttributedLabel *niaoCTitle;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) TTTAttributedLabel *niaoCContentLabel;//内容
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ChanJianTimesCustomCell *cell;
@property (nonatomic, strong) ChanJianTimesCustomCellS *cellS;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) TTTAttributedLabel *contentLabel;
//@property (nonatomic, strong) ChanJianTimesCollectionCell *collectionCell;
@property (nonatomic, assign) NSInteger isSelectedItem;
@end

@implementation ChanJianTimesVC

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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_descArray.count>0) {
        _cell.contentLabel.text = _descArray[0];
    }
    if (_remindArray.count > 0) {
        _cellS.contentLabel.text = _remindArray[0];
    }
    if (_nameArray.count>0) {
        self.niaoCTitle.text = _nameArray[0];
    }
    [_tableView reloadData];


}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"第%ld次产检",self.checkId];
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.view.backgroundColor = KHexColor(@"#ebf7ec");
    self.dataArray = [NSMutableArray array];
    self.nameArray = [NSMutableArray array];
    self.descArray = [NSMutableArray array];
    self.remindArray = [NSMutableArray array];
    [self makeChanJianTitleUI]; //产检项目
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(CoreWidth*0.3, 40);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = KHexColor(@"#ebf7ec");
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[ChanJianTimesCollectionCell class] forCellWithReuseIdentifier:collectionID];
    
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chanJianView.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(150);

    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    self.tableView.backgroundColor = KHexColor(@"#ebf7ec");
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).offset(10);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    self.footerView = [[UIView alloc] init];
    self.footerView.frame = CGRectMake(0, 0, CoreWidth, 60);
    self.footerView.layer.cornerRadius = 4;
    self.footerView.layer.masksToBounds = YES;
    self.footerView.layer.borderColor = KHexColor(@"#ffffff").CGColor;
    self.footerView.layer.borderWidth = 1;
    self.footerView.backgroundColor = KHexColor(@"#f6fbf6");
    self.tableView.tableFooterView = self.footerView;
    
    
    self.contentLabel = [TTTAttributedLabel new];
    self.contentLabel.textColor = KHexColor(@"#ff5571");
    self.contentLabel.font = KFontSize(14);
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineSpacing = 5;
    self.contentLabel.text = mama;
    [self.footerView addSubview:_contentLabel];
        
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.footerView.mas_top).offset(10);
        make.left.equalTo(self.footerView.mas_left).offset(13);
        make.bottom.equalTo(self.footerView.mas_bottom).offset(-10);
        make.right.equalTo(self.footerView.mas_right).offset(-13);
        
        
    }];
    

    
    [self requestData];
}

- (void)makeChanJianTitleUI
{
    self.chanJianView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+5, CoreWidth, 40)];
    self.chanJianView.backgroundColor = KHexColor(@"#f6fbf6");
    [self.view addSubview:_chanJianView];
    
    
    self.shuView = [UIView new];
    self.shuView.backgroundColor = KHexColor(@"#ebf7ec");
    [self.chanJianView addSubview:_shuView];
    
    
    self.chanJianImage = [UIImageView new];
    self.chanJianImage.image = [UIImage imageNamed:@"pregnant_20mother"] ;
    [self.chanJianView addSubview:_chanJianImage];
    
    self.chanJianTitle = [TTTAttributedLabel new];
    self.chanJianTitle.font = KFontSize(14);
    self.chanJianTitle.text = @"产检项目";
    [self.chanJianView addSubview:_chanJianTitle];
   
    
    
    [_shuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chanJianView.mas_top).offset(0);
        make.left.equalTo(25);
        make.width.equalTo(10);
        make.height.equalTo(40);
    }];
    
    [_chanJianImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shuView.mas_centerX);
        make.centerY.equalTo(self.shuView.mas_centerY);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    
    [_chanJianTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shuView.mas_right).offset(20);
        make.centerY.equalTo(self.shuView.mas_centerY);
        make.width.equalTo(self.chanJianTitle.mas_width);
        make.height.equalTo(17);
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
#pragma mark ------------------------------------------------------------------UICollectionViewDatasource Delegate-------------------------------------------------
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_nameArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChanJianTimesCollectionCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    if (indexPath.item == _isSelectedItem)
    {
        collectionCell.contentView.backgroundColor = KHexColor(@"#ff7576");
    }
    else
    {
        collectionCell.contentView.backgroundColor = KHexColor(@"#ff999a");
    }
    collectionCell.kindOfLabel.text = _nameArray[indexPath.item];
    return collectionCell;
}
//行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 10;
}
//列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _isSelectedItem = indexPath.item;
    [_collectionView reloadData];
    _niaoCTitle.text = _nameArray[indexPath.item];
    _cell.contentLabel.text = _descArray[indexPath.item];
    _cellS.contentLabel.text = _remindArray[indexPath.item];
    
}
#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        self.niaoCView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CoreWidth, 40)];
        self.niaoCView.backgroundColor = KHexColor(@"#f6fbf6");
        
        self.niaoCTitle = [TTTAttributedLabel new];
        self.niaoCTitle.font = KFontSize(14);
        self.niaoCTitle.textColor = KHexColor(@"#ff5571");
        //self.niaoCTitle.text = @"丙型肝炎病毒筛查";
        [self.niaoCView addSubview:_niaoCTitle];
        
        [_niaoCTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.niaoCView.mas_left).offset(20);
            make.centerY.equalTo(self.niaoCView.mas_centerY);
            make.width.equalTo(self.niaoCTitle.mas_width);
            make.height.equalTo(17);
        }];
        
        return _niaoCView;

    }
    else{
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 40)];
        sectionView.backgroundColor = KHexColor(@"#f6fbf6");
        
        UIView *shu = [UIView new];
        shu.backgroundColor =  KHexColor(@"#ebf7ec");
        [sectionView addSubview:shu];
        
        
        UIImageView *baoChangeImage = [UIImageView new];
        baoChangeImage.image = [UIImage imageNamed:@"pregnant_21mother"];
        [sectionView addSubview:baoChangeImage];
        
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"温馨提示";
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
   

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //ChanJianTimesModel *model = _dataArray[indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return [ChanJianTimesCustomCell heightForRowString: _cell.contentLabel.text];//
    }
    else
    {
        return [ChanJianTimesCustomCellS heightForRowString: _cellS.contentLabel.text];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"cell";
        _cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (nil == _cell) {
            _cell = [[ChanJianTimesCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        }
        _cell.contentLabel.textColor =  indexPath.row == 1  ? KHexColor(@"#fe5c76") : KHexColor(@"#4e4d4e");
               
         return _cell;
    }
    
    else
    {
        static NSString *identifier = @"cellS";
        _cellS = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (nil == _cellS) {
            _cellS = [[ChanJianTimesCustomCellS alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        }
        return _cellS;

    }
   
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (void)requestData
{
    //[NSNumber numberWithInteger:self.checkId]
    [ASURLConnection requestAFNJSon:@{@"pae_id":@3} method:@"jumper.healthy.antenatal.getExaminaObjctList" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            for (NSDictionary *dic in dataArr)
            {
                [_nameArray addObject:[dic objectForKey:@"name"]];
                [_descArray addObject:[dic objectForKey:@"desc"]];
                [_remindArray addObject:[dic objectForKey:@"remind"]];
                
                ChanJianTimesModel *model = [[ChanJianTimesModel alloc] initWithDictionary:dic];
                [_dataArray addObject:model];
            }
            [_collectionView reloadData];
            [_tableView reloadData];
            
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
}
@end

