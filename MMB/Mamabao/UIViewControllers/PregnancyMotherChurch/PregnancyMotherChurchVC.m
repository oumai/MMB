//
//  PregnancyMotherChurchVC.m
//  Benevolence
//
//  Created by Michael on 15/10/27.
//  Copyright © 2015年 Michael. All rights reserved.
//
/*-----------------------------------------------------------------------M-------------------------------------------*/

#import <UIKit/UIKit.h>

@interface PregnancyMotherChurchModel  : NSObject

@property (nonatomic, strong) NSString *share;                  //推荐
@property (nonatomic, strong) NSString *pageView;
@property (nonatomic, strong) NSString *collect;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *tui_id;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *ben_id;
@property (nonatomic, strong) NSString *b_title;
@property (nonatomic, strong) NSString *b_imgUrl;
@property (nonatomic, strong) NSString *b_content;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
- (instancetype)initWithDictionaryBenZhou:(NSDictionary *)dic;

@end



@interface PregnancyMotherChurchModel ()

@end

@implementation PregnancyMotherChurchModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([[dic objectForKey:@"share"] isKindOfClass:[NSNumber class]]) {
            self.share = [[dic objectForKey:@"share"] stringValue];
        }
        if ([[dic objectForKey:@"pageView"] isKindOfClass:[NSNumber class]]) {
            self.pageView = [[dic objectForKey:@"pageView"] stringValue];
        }
        if ([[dic objectForKey:@"collect"] isKindOfClass:[NSNumber class]]) {
            self.collect = [[dic objectForKey:@"collect"] stringValue];
        }
        if ([dic objectForKey:@"imageUrl"]) {
            self.imageUrl = [dic objectForKey:@"imageUrl"];
        }
        if ([dic objectForKey:@"title"]) {
            self.title = [dic objectForKey:@"title"];
        }
        
        if ([[dic objectForKey:@"collect"] isKindOfClass:[NSNumber class]]) {
            self.collect = [[dic objectForKey:@"collect"] stringValue];
        }

        
    }
    return self;
}

- (instancetype)initWithDictionaryBenZhou:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        
        if ([dic objectForKey:@"title"]) {
            self.b_title = [dic objectForKey:@"title"];
        }
        if ([dic objectForKey:@"imgUrl"]) {
            self.b_imgUrl = [dic objectForKey:@"imgUrl"];
        }

        if ([dic objectForKey:@"content"]) {
            self.b_content = [dic objectForKey:@"content"];
        }
        if ([[dic objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
            self.ben_id = [[dic objectForKey:@"id"] stringValue];
        }

    }
    return self;
}


@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface PregnancyMotherChurchCustomCell : UITableViewCell

@property (nonatomic, strong) PregnancyMotherChurchModel *jinRiTuiModel;
@end



@interface PregnancyMotherChurchCustomCell ()

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) UIImageView *weiboImage;
@property (nonatomic, strong) UIImageView *hideImage;
@property (nonatomic, strong) UIImageView *shareImage;
@property (nonatomic, strong) TTTAttributedLabel *weiboLabel;
@property (nonatomic, strong) TTTAttributedLabel *hideLabel;
@property (nonatomic, strong) TTTAttributedLabel *shareLabel;


@end

@implementation PregnancyMotherChurchCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellView = [UIView new];
        //self.cellView.backgroundColor = KHexColor(@"#d9d9d9");
        self.cellView.layer.borderWidth = 1;
        self.cellView.layer.borderColor = KHexColor(@"#d9d9d9").CGColor;
        self.cellView.layer.cornerRadius = 5;
        self.cellView.layer.masksToBounds = YES;
        [self.contentView addSubview:_cellView];
        
        self.iconImage = [UIImageView new];
        self.iconImage.image = [UIImage imageNamed:@"pregnant_6mother"];
        [self.contentView addSubview:_iconImage];
        
        
        self.titleLabel = [TTTAttributedLabel new];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLabel];
        
        
        self.shareLabel = [TTTAttributedLabel new];
        self.shareLabel.font = [UIFont systemFontOfSize:15];
        self.shareLabel.textColor = KHexColor(@"#8a8a8a");
        [self.contentView addSubview:_shareLabel];
        
        self.shareImage  = [UIImageView new];
        self.shareImage.image = [UIImage imageNamed:@"icon_notshare"];
        [self.contentView addSubview:_shareImage];
        
       
        
        self.hideLabel = [TTTAttributedLabel new];
        self.hideLabel.font = [UIFont systemFontOfSize:15];
        self.hideLabel.textColor = KHexColor(@"#8a8a8a");
        [self.contentView addSubview:_hideLabel];
        
        self.hideImage  = [UIImageView new];
        self.hideImage.image = [UIImage imageNamed:@"icon_notlike"];
        [self.contentView addSubview:_hideImage];
        
        
        self.weiboLabel = [TTTAttributedLabel new];
        self.weiboLabel.font = [UIFont systemFontOfSize:15];
        self.weiboLabel.textColor = KHexColor(@"#8a8a8a");
        [self.contentView addSubview:_weiboLabel];
        
        self.weiboImage  = [UIImageView new];
        self.weiboImage.image = [UIImage imageNamed:@"icon_seen"];
        [self.contentView addSubview:_weiboImage];
       
        
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cellView.mas_top).offset(10);
            make.left.equalTo(self.iconImage.mas_right).offset(10);
            make.right.equalTo(self.cellView.mas_right).offset(-5);
            make.height.equalTo(17);
        }];
       
        
        [_cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(4);
            make.left.equalTo(self.contentView.mas_left).offset(8);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-4);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
            
        }];
        
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.cellView.mas_left).offset(10);
            make.width.equalTo(75);
            make.height.equalTo(75);
        }];
        
        [_shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.cellView.mas_bottom).offset(-10);
            make.right.equalTo(self.cellView.mas_right).offset(0);
            make.width.equalTo(30);
            make.height.equalTo(17);
        }];
        [_shareImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shareLabel.mas_centerY).offset(0);
            make.right.equalTo(self.shareLabel.mas_left).offset(-5);
            make.width.equalTo(8);
            make.height.equalTo(7);
        }];
        [_hideLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.cellView.mas_bottom).offset(-10);
            make.right.equalTo(self.shareImage.mas_right).offset(-20);
            make.width.equalTo(30);
            make.height.equalTo(17);
        }];
        
        [_hideImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shareLabel.mas_centerY).offset(0);
            make.right.equalTo(self.hideLabel.mas_left).offset(-5);
            make.width.equalTo(10);
            make.height.equalTo(8);
        }];
        
        [_weiboLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.cellView.mas_bottom).offset(-10);
            make.right.equalTo(self.hideImage.mas_right).offset(-20);
            make.width.equalTo(30);
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

- (void)setJinRiTuiModel:(PregnancyMotherChurchModel *)jinRiTuiModel
{
    if (nil == jinRiTuiModel) {
        return;
    }
    self.titleLabel.text = jinRiTuiModel.title;
    self.weiboLabel.text = jinRiTuiModel.pageView;
    self.hideLabel.text = jinRiTuiModel.collect;
    self.shareLabel.text = jinRiTuiModel.share;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:jinRiTuiModel.imageUrl] placeholderImage:[UIImage imageNamed:@"default"]];
}


@end
/*-----------------------------------------------------------------------V-------------------------------------------*/
@interface BenZhouTiXingCustomeCell : UITableViewCell

@property (nonatomic, strong) PregnancyMotherChurchModel *benZhouTiXingModel;

@end

@interface BenZhouTiXingCustomeCell ()
@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) TTTAttributedLabel *detailLabel;
@end

@implementation BenZhouTiXingCustomeCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellView = [UIView new];
        self.cellView.layer.borderWidth = 1;
        self.cellView.layer.borderColor = KHexColor(@"#d9d9d9").CGColor;
        self.cellView.layer.cornerRadius = 5;
        self.cellView.layer.masksToBounds = YES;
        [self.contentView addSubview:_cellView];
        
        self.iconImage = [UIImageView new];
        self.iconImage.image = [UIImage imageNamed:@"pregnant_6mother"];
        self.iconImage.layer.cornerRadius = 37.5;
        self.iconImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconImage];
        
        
        self.titleLabel = [TTTAttributedLabel new];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = KHexColor(@"#ff6a81");
        [self.contentView addSubview:_titleLabel];
        
        self.detailLabel = [TTTAttributedLabel new];
        self.detailLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_detailLabel];
  
        
        [_cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(4);
            make.left.equalTo(self.contentView.mas_left).offset(8);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-4);
            make.right.equalTo(self.contentView.mas_right).offset(-8);
            
        }];
        
        
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.cellView.mas_left).offset(10);
            make.width.equalTo(75);
            make.height.equalTo(75);
        }];
        
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cellView.mas_top).offset(20);
            make.left.equalTo(self.iconImage.mas_right).offset(10);
            make.width.equalTo(self.titleLabel.mas_width);
            make.height.equalTo(17);
        }];
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.equalTo(self.iconImage.mas_right).offset(10);
            make.right.equalTo(self.cellView.mas_right).offset(-5);
            make.height.equalTo(17);
        }];

    }
    return self;
}

- (void)setBenZhouTiXingModel:(PregnancyMotherChurchModel *)benZhouTiXingModel
{
    if (nil == benZhouTiXingModel) {
        return;
    }
    self.titleLabel.text = benZhouTiXingModel.b_title;
    self.detailLabel.text = benZhouTiXingModel.b_content;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:benZhouTiXingModel.b_imgUrl] placeholderImage:[UIImage imageNamed:@"default"]];
}
@end


/*-----------------------------------------------------------------------C-------------------------------------------*/
#import "PregnancyMotherChurchVC.h"
#import "ZYMenuController.h"
#import "VideoVC.h"
#import "ChanJianTimesVC.h"
#import "BabyAndMotherChangeVC.h"
#import "PregnancyArticle.h"
#import "BenZhouRenWuVC.h"
#import "ArticleDetailVC.h"
#import "ASChoicePhotoView.h" //图片选择
#import "ASSecondView.h"



@interface PregnancyMotherChurchVC ()<UITableViewDelegate,UITableViewDataSource,ASChoicePhotoViewDelegate>
@property (nonatomic, strong) NSMutableArray *jinRiTuiJianArray;
@property (nonatomic, strong) NSMutableArray *benZhouTiShiArray;
@property (nonatomic, strong) NSDictionary *chanJianDic;
@property (nonatomic, strong) NSDictionary *yunZhouDic;
@property (nonatomic, strong) UIView *segmentView;
@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) UIImageView *rightImage;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger lastButtonTag;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UITableView *tableView;
//上一部分
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UIImageView *boFangImage;
@property (nonatomic, strong) UIButton *videoButton;
@property (nonatomic, strong) UIButton *chanJianButton;
@property (nonatomic, strong) UIButton *pregnancyButton;
@property (nonatomic, strong) UIView *pregnancyView;
@property (nonatomic, strong) TTTAttributedLabel *pregnancyLabel;

@property (nonatomic, strong) TTTAttributedLabel *babyLengthTitle;
@property (nonatomic, strong) TTTAttributedLabel *babyLength;
@property (nonatomic, strong) TTTAttributedLabel *babyBirthTitle;
@property (nonatomic, strong) TTTAttributedLabel *babyBirth;
@property (nonatomic, strong) TTTAttributedLabel *babyWeightTitle;
@property (nonatomic, strong) TTTAttributedLabel *babyWeight;
@property (nonatomic, strong) UIView *leftVerticalLine;
@property (nonatomic, strong) UIView *rightVerticalLine;
@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) ASChoicePhotoView *choicePhotoView;
@property (nonatomic, strong) NSString *babyUrl_image;  //已出生宝宝的照片

@end

@implementation PregnancyMotherChurchVC


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"1-First-level-navigation"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
    }
    return self;
}

- (void)leftClicked
{
    
    [self.menuController showLeftViewController:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.menuController.panEnabel = YES;
    self.tabBarController.tabBar.hidden = NO;
    //[self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NavigationBarTitleColor
    self.view.backgroundColor = KHexColor(@"#ff637d");
    self.user = [[ASUserInfoModel alloc] init];//status
    NSLog(@"%ld---------status%ld",(long)[self.user getUserMessageFromLocation].currentIdentity,(long)[self.user getUserMessageFromLocation].userStatus);
    self.benZhouTiShiArray = [NSMutableArray array];
    self.jinRiTuiJianArray = [NSMutableArray array];
    [self makeSementUI];                                //segmentView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
    self.tableView.backgroundColor = KHexColor(@"#ffffff");
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentView.mas_bottom).offset(0);
        make.left.bottom.right.equalTo(self.view);
    }];
    self.choicePhotoView = [[ASChoicePhotoView alloc]initWithFrame:self.view.frame];
    self.choicePhotoView.delegate = self;//delegate
    [self makeUI];                                      //tableHeaderView
    [self requestData];
}


- (void)makeSementUI
{
    
    
    self.segmentView = [UIView new];
    self.segmentView.frame = CGRectMake(0, 64, CoreWidth, 40);
    self.segmentView.backgroundColor = KHexColor(@"#ff637d");
    [self.view addSubview:_segmentView];

    self.leftImage = [UIImageView new];
    self.leftImage.image = [UIImage imageNamed:@"pregnant_1mother"];
    [self.segmentView addSubview:_leftImage];
    
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.segmentView addSubview:_leftButton];
    
    
    self.rightImage = [UIImageView new];
    self.rightImage.image = [UIImage imageNamed:@"pregnant_2mother"];
    [self.segmentView addSubview:_rightImage];
    
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.segmentView addSubview:_rightButton];

    
    
    //UIScrollView
    NSArray *titleArray = nil;
    if ([self.user getUserMessageFromLocation].currentIdentity == 1) {
        titleArray = @[@"0月",@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月"];
    }
    else
    {
        titleArray =@[@"0周",@"1周",@"2周",@"3周",@"4周",@"5周",@"6周",@"7周",@"8周",@"9周",@"10周",@"11周",@"12周",@"13周",@"14周",@"15周",@"16周",@"17周",@"18周",@"19周",@"20周",@"21周",@"22周",@"23周",@"24周",@"25周",@"26周",@"27周",@"28周",@"29周",@"30周",@"31周",@"32周",@"33周",@"34周",@"35周",@"36周",@"37周",@"38周",@"39周"];
    }
    self.lastButtonTag = 1;
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CoreWidth == 320 ? CGRectMake(60, 0, 200, 40) : CGRectMake(CoreWidth*80/320, 0, 200, 40);
    
    for (int i = 0; i < titleArray.count; i ++) {
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(20 + (50 + 30)*i, 5, 50,28);
        [self.button setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.button.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if (i == 0)
        {
            
            [self.button setBackgroundImage:[UIImage imageNamed:@"kuangkuang_white"] forState:UIControlStateNormal];
        }
        self.button.tag = i + 1;
        [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:self.button];
    }
    self.scrollView.showsHorizontalScrollIndicator = NO;
    if ([self.user getUserMessageFromLocation].currentIdentity == 0)
    {self.scrollView.contentSize = CGSizeMake( 10 + (80 + 30) * titleArray.count-1100, 40);}
    else{self.scrollView.contentSize = CGSizeMake( 10 + (80 + 30) * titleArray.count-300, 40);}

    [self.segmentView addSubview:_scrollView];
    
  
    
    [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.segmentView.mas_centerY).offset(0);
        make.left.equalTo(self.segmentView.mas_left).offset(30);
        make.width.equalTo(6);
        make.height.equalTo(8.5);
    }];
    
    
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentView.mas_top).offset(0);
        make.left.equalTo(self.segmentView.mas_left).offset(0);
        make.width.equalTo(60);
        make.height.equalTo(40);
    }];
    
    
    [_rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.segmentView.mas_centerY).offset(0);
        make.right.equalTo(self.segmentView.mas_right).offset(-30);
        make.width.equalTo(6);
        make.height.equalTo(8.5);
    }];
    
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentView.mas_top).offset(0);
        make.right.equalTo(self.segmentView.mas_right).offset(0);
        make.width.equalTo(60);
        make.height.equalTo(40);
    }];
    
}



#pragma mark -----------------------------------------------------------ActionsButton-------------------------------------------------------

- (void)leftButtonClick:(UIButton *)button
{
}
- (void)rightButtonClick:(UIButton *)button
{
}
- (void)videoButtonClick
{
    if ([self.user getUserMessageFromLocation].currentIdentity == 1)
    {
        if ([self.user getUserMessageFromLocation].isLogin == YES) {
            [self.view addSubview:self.choicePhotoView];
            [self.choicePhotoView  addCon:self andView:self.view.window andImageCount:1];
        }

    }
    else
    {
        VideoVC *video = [VideoVC new];
        [self.navigationController pushViewController:video animated:YES];
    }
    
   
}
#pragma mark--------------------------------------------------------------ASChoicePhotoViewDelegate  update headerImage-------------------------------------
-(void)getImageArray:(NSMutableArray *)array{
    self.headerImage.image = array[0];
    [self updateUserPhoto:array];
    
}

-(void)updateUserPhoto:(NSMutableArray *)array
{
    [ASLoadingView showActivity:self.view];
    [ASURLConnection requestImage:@{@"win":@1} method:kUploadImg version:@"" img:array name:@"img_url" completeBlock:^(NSData *data, id responseObject){
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            NSDictionary *dic = AFNdata[0];
            NSString *str  = [dic objectForKey:@"imageList"];
            
            [self requestDataImage:str];
            [ASLoadingView hidenActivity:self.view];
        }
    } errorBlock:^(NSError *error) {
    }];
    
}


- (void)requestDataImage:(NSString *)string
{
    
    
    [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId ],@"img_url":string} method:@"renhe.system.updateBabyImg" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
        }
        else{k_yjHUD([ASURLConnection getMessage:responseObject], self.view);}
    } errorBlock:^(NSError *error) {
        
    }];
}

- (void)chanJianButtonClick
{
    ChanJianTimesVC *chan = [ChanJianTimesVC new];
    chan.checkId = [[self.chanJianDic objectForKey:@"checkNotice"] integerValue];
    [self.navigationController pushViewController:chan animated:YES];
}
- (void)pregnancyButtonClick
{
    BabyAndMotherChangeVC *baby = [BabyAndMotherChangeVC new];
    baby.week = self.lastButtonTag;
    [self.navigationController pushViewController:baby animated:YES];
}
- (void)buttonClick:(UIButton* )button
{
    
    UIButton* lastButton = (UIButton* )[self.view viewWithTag:self.lastButtonTag];
    [lastButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"kuangkuang_white"] forState:UIControlStateNormal];
    self.lastButtonTag = button.tag;
    [_scrollView setContentOffset:CGPointMake(button.center.x - 100, 0) animated:YES];
    
    [self requestData];
}


#pragma mark -----------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
       return  0 == section ? [_jinRiTuiJianArray count] == 0 ? 0.001 : 40 : [_benZhouTiShiArray count] == 0 ? 0.001 : 40;
    //return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 40)];
        sectionView.backgroundColor = KHexColor(@"#ffffff");
        UIImageView *sectionIcon = [UIImageView new];
        sectionIcon.image =  [UIImage imageNamed:@"pregnant_5mother"] ;
        [sectionView addSubview:sectionIcon];
        
        
        UILabel *sectionTitle = [UILabel new];
        sectionTitle.textColor = KHexColor(@"#9e7979");
        sectionTitle.font = [UIFont boldSystemFontOfSize:14];
        sectionTitle.text = @"今日推荐" ;
        [sectionView addSubview:sectionTitle];
        
        
        [sectionIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(sectionView.mas_centerY).offset(0);
            make.left.equalTo(sectionView.mas_left).offset(10);
            make.width.equalTo(15);
            make.height.equalTo(15);
        }];
        
        [sectionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(sectionView.mas_centerY).offset(0);
            make.left.equalTo(sectionIcon.mas_right).offset(10);
            make.width.equalTo(sectionTitle.mas_width);
            make.height.equalTo(14);
        }];
        
        return [_jinRiTuiJianArray count] == 0 ? nil : sectionView;
    }
    else
    {
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 40)];
        sectionView.backgroundColor = KHexColor(@"#ffffff");
        UIImageView *sectionIcon = [UIImageView new];
        sectionIcon.image = [UIImage imageNamed:@"pregnant_12mother"];
        [sectionView addSubview:sectionIcon];
        
        
        UILabel *sectionTitle = [UILabel new];
        sectionTitle.textColor = KHexColor(@"#9e7979");
        sectionTitle.font = [UIFont boldSystemFontOfSize:14];
        sectionTitle.text =  @"本周提醒";
        [sectionView addSubview:sectionTitle];
        
        
        [sectionIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(sectionView.mas_centerY).offset(0);
            make.left.equalTo(sectionView.mas_left).offset(10);
            make.width.equalTo(15);
            make.height.equalTo(15);
        }];
        
        [sectionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(sectionView.mas_centerY).offset(0);
            make.left.equalTo(sectionIcon.mas_right).offset(10);
            make.width.equalTo(sectionTitle.mas_width);
            make.height.equalTo(14);
        }];
        
        return [_benZhouTiShiArray count] == 0 ? nil : sectionView;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section

{
    return 0.001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0 == section ? [_jinRiTuiJianArray count] : [_benZhouTiShiArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section == 0) {
        static NSString *identifier = @"cell";
        PregnancyMotherChurchCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (nil == cell) {
            cell = [[PregnancyMotherChurchCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        }
        cell.jinRiTuiModel = _jinRiTuiJianArray[indexPath.row];
        return cell;
    }
  
    else
    {
        static NSString *benZhouIdentifier = @"benZhouIdentifier";
        BenZhouTiXingCustomeCell *cellB = [tableView dequeueReusableCellWithIdentifier:benZhouIdentifier];
        if (nil == cellB) {
            cellB = [[BenZhouTiXingCustomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:benZhouIdentifier] ;
        }
        cellB.benZhouTiXingModel = _benZhouTiShiArray[indexPath.row];
        return cellB;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            //第一篇文章
            PregnancyArticle *article = [PregnancyArticle new];
            [self.navigationController pushViewController:article animated:YES];
            
            
        }else if (indexPath.row == 1)
        {
            //第二篇文章
            PregnancyArticle *article = [PregnancyArticle new];
            [self.navigationController pushViewController:article animated:YES];
        }else if (indexPath.row == 2)
        {
            //第三篇文章
            PregnancyArticle *article = [PregnancyArticle new];
            [self.navigationController pushViewController:article animated:YES];
        }

    }
    else
    {
        if (indexPath.row == 0)
        {
            
            BenZhouRenWuVC *vc = [BenZhouRenWuVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 1)
        {
            ChanJianTimesVC *chanjian = [ChanJianTimesVC new];
            chanjian.checkId = [[self.chanJianDic objectForKey:@"checkNotice"] integerValue];
            [self.navigationController pushViewController:chanjian animated:YES];
        }
        else
        {
            PregnancyMotherChurchModel *b_model = _benZhouTiShiArray[indexPath.row];
            ArticleDetailVC *article = [ArticleDetailVC new];
            article.news_id = b_model.ben_id;
            [self.navigationController pushViewController:article animated:YES];
        }
    }
}
#pragma mark ----------------------------------------------------------- ASURLConnection -------------------------------------------------------

- (void)requestData
{

    //[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId]
    NSDictionary *json = @{@"user_id":@4210,@"period":[NSNumber numberWithInteger:self.lastButtonTag]};
    [ASURLConnection requestAFNJSon:json method:@"renhe.system.motherTodayInfos" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        [_jinRiTuiJianArray removeAllObjects];
        [_benZhouTiShiArray removeAllObjects];
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            
           
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject]objectFromJSONString]objectForKey:@"data"];
            self.babyUrl_image = [[dataArr[0] objectForKey:@"babyChange"] objectForKey:@"url"];
            NSArray *jinRiTuiJianArray = [dataArr[0] objectForKey:@"news"];
            self.chanJianDic = [dataArr[0] objectForKey:@"fetusChange"];//今日推荐
            for (int i = 0; i<jinRiTuiJianArray.count; i++) {
                PregnancyMotherChurchModel *model = [[PregnancyMotherChurchModel alloc] initWithDictionary:jinRiTuiJianArray[i]];
                [_jinRiTuiJianArray addObject:model];
            }
            NSArray *benZhouArray = [dataArr[0] objectForKey:@"task"];                                          //本周提示
            for (NSDictionary *dic in benZhouArray) {
                PregnancyMotherChurchModel *b_model = [[PregnancyMotherChurchModel alloc] initWithDictionaryBenZhou:dic];
                [_benZhouTiShiArray addObject:b_model];
            }
            [self backData];
            [_tableView reloadData];
            
            
        }
        
    } errorBlock:^(NSError *error) {
    }];
}

- (void)backData
{
    [self.chanJianButton setTitle:[self.chanJianDic objectForKey:@"checkNotice"] forState:UIControlStateNormal];
    self.pregnancyLabel.text = [self.chanJianDic objectForKey:@"content"];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:self.babyUrl_image] placeholderImage:[UIImage imageNamed:@"baby"]];
}
#pragma mark ----------------------------------------------------------- makeUI -------------------------------------------------------

- (void)makeUI
{
    
    UIView *bgV = [[UIView alloc] init];
    bgV.frame = CGRectMake(0, -300, CoreWidth, 300);
    bgV.backgroundColor = KHexColor(@"#ff637d");//#ff5874
    [self.tableView addSubview:bgV];
    
    self.headerView = [[UIView alloc] init];
    self.headerView.frame = CGRectMake(0, 0, CoreWidth,  [self.user getUserMessageFromLocation].currentIdentity == 0 ? 290 : 140);
    self.tableView.tableHeaderView = self.headerView;
    
    self.bgImage = [UIImageView new];
    self.bgImage.image = [UIImage imageNamed:@"background_red"];
    [self.headerView addSubview:_bgImage];
    
    
    self.headerImage = [UIImageView new];
    self.headerImage.layer.cornerRadius = 40.5;
    self.headerImage.layer.masksToBounds = YES;
    self.headerImage.image = [UIImage imageNamed:@"baby"];
    [self.headerView addSubview:_headerImage];
    
    
    self.boFangImage = [UIImageView new];
    self.boFangImage.image = [UIImage imageNamed: [self.user getUserMessageFromLocation].currentIdentity == 1 ? @"paizhao" : @"paly"];
    [self.headerView addSubview:_boFangImage];
    
    self.videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.videoButton addTarget:self action:@selector(videoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:_videoButton];
    
    
   
    
    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.centerX).offset(0);
        make.top.equalTo(self.headerView.top).offset(10);
        make.width.equalTo(81);
        make.height.equalTo(81);
    }];
    
    
    
    [_bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(0);
        make.left.right.equalTo(self.headerView);
        make.height.equalTo(140);
    }];
    
    
    [_boFangImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerImage.mas_centerX).offset(0);
        make.centerY.equalTo(self.headerImage.mas_centerY).offset(0);
        make.width.equalTo(123);
        make.height.equalTo(123);
    }];
    
    
    
    [_videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.boFangImage.mas_centerY).offset(0);
        make.centerX.equalTo(self.boFangImage.mas_centerX).offset(0);
        make.width.equalTo(123);
        make.height.equalTo(123);
    }];
    
    
    if ([self.user getUserMessageFromLocation].currentIdentity == 1) {
        
    }
    else
    {
        [self chanJianYiXiaUI];
    }

   
    
}
- (void)chanJianYiXiaUI
{
    self.chanJianButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.chanJianButton.titleLabel.font = KFontSize(12);
    [self.chanJianButton setTitleColor:KHexColor(@"#ff5f77") forState:UIControlStateNormal];
    [self.chanJianButton addTarget:self action:@selector(chanJianButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:_chanJianButton];
    
    
    self.pregnancyView = [UIView new];
    self.pregnancyView.layer.cornerRadius = 5;
    self.pregnancyView.layer.masksToBounds = YES;
    self.pregnancyView.layer.borderWidth = 1;
    self.pregnancyView.layer.borderColor = KHexColor(@"#ffb1bd").CGColor;
    self.pregnancyView.backgroundColor = KHexColor(@"#fff0f3");
    [self.headerView addSubview:_pregnancyView];
    
    
    self.pregnancyLabel = [TTTAttributedLabel new];
    self.pregnancyLabel.textColor = KHexColor(@"#ff5f77");
    self.pregnancyLabel.backgroundColor = KHexColor(@"#fff0f3");
    self.pregnancyLabel.font = [UIFont systemFontOfSize:12];
    self.pregnancyLabel.numberOfLines = 0;
    [self.headerView addSubview:_pregnancyLabel];
    
    
    
    self.pregnancyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pregnancyButton addTarget:self action:@selector(pregnancyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:_pregnancyButton];
    
    
    self.babyLength = [TTTAttributedLabel new];
    self.babyLength.font = [UIFont systemFontOfSize:12];
    self.babyLength.textColor = KHexColor(@"#9e7979");
    self.babyLength.text = @"352mm";
    [self.headerView addSubview:_babyLength];
    
    
    
    self.babyLengthTitle = [TTTAttributedLabel new];
    self.babyLengthTitle.font = [UIFont systemFontOfSize:14];
    self.babyLengthTitle.textColor = KHexColor(@"#9e7979");
    self.babyLengthTitle.text = @"宝宝身长";
    [self.headerView addSubview:_babyLengthTitle];
    
    
    
    
    self.babyBirth = [TTTAttributedLabel new];
    self.babyBirth.font = [UIFont systemFontOfSize:12];
    self.babyBirth.textColor = KHexColor(@"#9e7979");
    self.babyBirth.text = @"90天";
    [self.headerView addSubview:_babyBirth];
    
    
    
    self.babyBirthTitle = [TTTAttributedLabel new];
    self.babyBirthTitle.font = [UIFont systemFontOfSize:14];
    self.babyBirthTitle.textColor = KHexColor(@"#9e7979");
    self.babyBirthTitle.text = @"距离宝宝出生";
    [self.headerView addSubview:_babyBirthTitle];
    
    
    
    self.babyWeight = [TTTAttributedLabel new];
    self.babyWeight.font = [UIFont systemFontOfSize:12];
    self.babyWeight.textColor = KHexColor(@"#9e7979");
    self.babyWeight.text = @"960g";
    [self.headerView addSubview:_babyWeight];
    
    
    
    self.babyWeightTitle = [TTTAttributedLabel new];
    self.babyWeightTitle.font = [UIFont systemFontOfSize:14];
    self.babyWeightTitle.textColor = KHexColor(@"#9e7979");
    self.babyWeightTitle.text = @"宝宝体重";
    [self.headerView addSubview:_babyWeightTitle];
    
    
    
    
    self.leftVerticalLine = [UIView new];
    self.leftVerticalLine.backgroundColor = KHexColor(@"#efdddd");
    [self.headerView addSubview:_leftVerticalLine];
    
    
    self.rightVerticalLine = [UIView new];
    self.rightVerticalLine.backgroundColor = KHexColor(@"#efdddd");
    [self.headerView addSubview:_rightVerticalLine];
    
    [_chanJianButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImage.mas_bottom).offset(8);
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.width.equalTo(self.chanJianButton.mas_width);
        make.height.equalTo(18);
    }];
    
    [_pregnancyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chanJianButton.mas_bottom).offset(8);
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.width.equalTo(300);
        make.height.equalTo(50);
    }];
    
    [_pregnancyLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.centerY.equalTo(self.pregnancyView.mas_centerY).offset(0);
        make.centerX.equalTo(self.pregnancyView.mas_centerX).offset(0);
        make.width.equalTo(290);
        make.height.equalTo(48);
    }];
    
    [_pregnancyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.pregnancyView.mas_centerY).offset(0);
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.width.equalTo(300);
        make.height.equalTo(50);
    }];
    
    [_babyLength mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.bottom.equalTo(self.headerView.mas_bottom).offset(-10);
        make.width.equalTo(self.babyLength.mas_width);
        make.height.equalTo(15);
        
    }];
    [_babyLengthTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.babyLength.mas_centerX).offset(0);
        make.bottom.equalTo(self.babyLength.mas_top).offset(-10);
        make.width.equalTo(self.babyLengthTitle.mas_width);
        make.height.equalTo(15);
        
    }];
    [_babyBirth mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.babyLength.mas_centerX).offset(-90);
        make.bottom.equalTo(self.headerView.mas_bottom).offset(-10);
        make.width.equalTo(self.babyBirth.mas_width);
        make.height.equalTo(15);
        
    }];
    
    [_babyBirthTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.babyBirth.mas_centerX).offset(0);
        make.bottom.equalTo(self.babyBirth.mas_top).offset(-10);
        make.width.equalTo(self.babyBirthTitle.mas_width);
        make.height.equalTo(15);
        
    }];
    [_babyWeight mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.babyLength.mas_centerX).offset(80);
        make.bottom.equalTo(self.headerView.mas_bottom).offset(-10);
        make.width.equalTo(self.babyWeight.mas_width);
        make.height.equalTo(15);
        
    }];
    
    [_babyWeightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.babyWeight.mas_centerX).offset(0);
        make.bottom.equalTo(self.babyBirth.mas_top).offset(-10);
        make.width.equalTo(self.babyWeightTitle.mas_width);
        make.height.equalTo(15);
        
    }];
    [_leftVerticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headerView.mas_bottom).offset(-8);
        make.right.equalTo(self.babyLength.mas_left).offset(-15);
        make.width.equalTo(1);
        make.height.equalTo(40);
    }];
    [_rightVerticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headerView.mas_bottom).offset(-8);
        make.left.equalTo(self.babyLength.mas_right).offset(15);
        make.width.equalTo(1);
        make.height.equalTo(40);
    }];
}

@end
