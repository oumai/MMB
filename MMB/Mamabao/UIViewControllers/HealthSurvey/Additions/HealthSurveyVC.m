//
//  HealthSurveyVC.m
//  Benevolence
//
//  Created by Michael on 15/10/27.
//  Copyright © 2015年 Michael. All rights reserved.
//

/*-----------------------------------------------------------------------M-------------------------------------------*/
@interface HealthSurveyModel  : NSObject
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *state;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface HealthSurveyModel ()

@end

@implementation HealthSurveyModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([[dic objectForKey:@"type"] isKindOfClass:[NSNumber class]]) {
            self.type = [[dic objectForKey:@"type"] stringValue];
        }
        if ([[dic objectForKey:@"state"] isKindOfClass:[NSNumber class]]) {
            self.state = [[dic objectForKey:@"state"] stringValue];
        }

    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/
@interface HealthSurveyCustomCell : UICollectionViewCell

@property (nonatomic, strong) HealthSurveyModel *healthModel;
@property (nonatomic, strong) NSString *bgName;

@end



@interface HealthSurveyCustomCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) TTTAttributedLabel *stateLabel;
@end

@implementation HealthSurveyCustomCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        self.bgImage = [UIImageView new];
        [self.contentView addSubview:_bgImage];
        
        
        self.stateLabel = [TTTAttributedLabel new];
        self.stateLabel.font = KFontSize(12);
        self.stateLabel.textAlignment = NSTextAlignmentCenter;
        self.stateLabel.textColor = KHexColor(@"#ffffff");
        self.stateLabel.layer.cornerRadius = 9;
        self.stateLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:_stateLabel];
        
        
        [_bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.contentView);
        }];
        
        [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.width.equalTo(35);
            make.height.equalTo(18);
        }];

        
    }
     return self;
}

//背景图片
- (void)setBgName:(NSString *)bgName
{
    if (![bgName isValid]) {
        return;
    }
    
    self.bgImage.image = [UIImage imageNamed:bgName];
}
- (void)setHealthModel:(HealthSurveyModel *)healthModel
{
    
    if (nil == healthModel) {
        return;
    }
    if ([healthModel.state isEqualToString:@"0"]) {
        self.stateLabel.backgroundColor = [UIColor clearColor];
        self.stateLabel.text = @"";
    }
    else if ([healthModel.state isEqualToString:@"1"])
    {
        self.stateLabel.backgroundColor = KHexColor(@"#ff5872");
        self.stateLabel.text = @"异常";
    }
        
}

@end
/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "HealthSurveyVC.h"
#import "ZYMenuController.h"
#import "EveryDaySurveyRecordVC.h"
#import "UICollectionViewWaterfallLayout.h"//瀑布流
//#import "FetalHeartVC.h"                   //8
#import "FetalMove.h"
#import "TemperatureVC.h"
#import "BloodPressureVC.h"
#import "WeightVC.h"
#import "HeartRateVC.h"
#import "BloodSugarVC.h"
#import "OximeterVC.h"

static NSString *identifier = @"HealthItem";

@interface HealthSurveyVC ()<UICollectionViewDelegateWaterfallLayout,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation HealthSurveyVC
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
       
        
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"1-First-level-navigation"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"3_monitor"] style:(UIBarButtonItemStylePlain) target:self action:@selector(rightClick)];
        self.navigationItem.rightBarButtonItem = right;
        right.tintColor = KHexColor(@"#ffffff");
      
    }
    
    return self;
}

- (void)leftClicked
{
   [self.menuController showLeftViewController:YES];
    
}

- (void)rightClick
{
    EveryDaySurveyRecordVC *every = [EveryDaySurveyRecordVC new];
    [self.navigationController pushViewController:every animated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.menuController.panEnabel = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NavigationBarTitleColor
    self.view.backgroundColor = KHexColor(@"#ebebeb");
    self.user = [[ASUserInfoModel alloc] init];
    self.dataArray = [NSMutableArray array];
    UICollectionViewWaterfallLayout *layout = [[UICollectionViewWaterfallLayout alloc] init];
    layout.itemWidth = (CoreWidth - 14)*154/310;        //设置每个item 的宽度
    layout.columnCount = 2;                             //设置多少列
    layout.delegate = self;                             //设置delegate 通过协议获得每隔item的高度
    layout.sectionInset = UIEdgeInsetsMake(10, 5, 5, 5);//设置上左下右的间距
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = KHexColor(@"#ebebeb");
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    [self.collectionView registerClass:[HealthSurveyCustomCell class] forCellWithReuseIdentifier:identifier];
    [self requestData];
}


#pragma mark ---------------delegate-------------

//每个item 的高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewWaterfallLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath

{
    return (CoreHeight-200)/4;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    HealthSurveyCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];   //type类型(1胎心2血氧3心率4体温5体重6血压 7血糖8胎动)
    NSArray *arrayBgImage = @[@"monitor_taixin",@"monitor_xueyang",@"monitor_xinlv",@"monitor_tiwen",@"monitor_tizhong",@"monitor_xueya",@"monitor_xuetang",@"monitor_taidong"];
    cell.bgName = arrayBgImage[indexPath.item];
    cell.healthModel = _dataArray[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%ld",(long)indexPath.item);
    //HealthSurveyModel *model = _dataArray[indexPath.row];
    if (indexPath.item == 0)
    {
//        FetalHeartVC *heart = [FetalHeartVC new];
//        [self.navigationController pushViewController:heart animated:YES];
    }
    else if (indexPath.item == 1){
        
        OximeterVC *heart = [OximeterVC new];
        [self.navigationController pushViewController:heart animated:YES];
       
    }
    else if (indexPath.item == 2){
        HeartRateVC *heart = [HeartRateVC new];
        [self.navigationController pushViewController:heart animated:YES];
    }

    else if (indexPath.item == 3){
        TemperatureVC *heart = [TemperatureVC new];
        [self.navigationController pushViewController:heart animated:YES];
    }

    else if (indexPath.item == 4){
        
        WeightVC *heart = [WeightVC new];
        [self.navigationController pushViewController:heart animated:YES];
    }
    else if (indexPath.item == 5){
        
        BloodPressureVC *heart = [BloodPressureVC new];
        [self.navigationController pushViewController:heart animated:YES];
    }

    else if (indexPath.item == 6){
      
        BloodSugarVC *heart = [BloodSugarVC new];
        [self.navigationController pushViewController:heart animated:YES];
    }

    else if (indexPath.item == 7){
        
        FetalMove *move = [FetalMove new];
        [self.navigationController pushViewController:move animated:YES];
    }
    
}
#pragma mark ------------------------------------------------------------------ASURLConnection----------------------------------------------------------------

- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId]} method:@"renhe.system.healthyFirstPage" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"];
            for (NSDictionary *dic in dataArr)
            {
                HealthSurveyModel *model = [[HealthSurveyModel   alloc] initWithDictionary:dic];
                [_dataArray addObject:model];

            }
            [_collectionView reloadData];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}
@end
