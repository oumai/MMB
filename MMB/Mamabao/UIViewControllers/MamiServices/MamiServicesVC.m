//
//  MamiServicesVC.m
//  Benevolence
//
//  Created by Michael on 15/10/27.
//  Copyright © 2015年 Michael. All rights reserved.
//

/*-----------------------------------------------------------------------M-------------------------------------------*/





@interface MamiServicesModel  : NSObject

@property (nonatomic, strong) NSString *mamaServices_id;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, strong) NSString *detailName;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

@interface MamiServicesModel ()

@end

@implementation MamiServicesModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([dic objectForKey:@"name"]) {
            self.titleName = [dic objectForKey:@"name"];
        }
        if ([dic objectForKey:@"text"]) {
            self.detailName = [dic objectForKey:@"text"];
            NSLog(@"self.detailName%@",self.detailName);

        }
        if ([dic objectForKey:@"imageUrl"]) {
            self.imageName = [dic objectForKey:@"imageUrl"];
        }
        if ([[dic objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
            self.mamaServices_id = [[dic objectForKey:@"id"] stringValue];
        }
        
    }
    return self;
}

@end

/*-----------------------------------------------------------------------V-------------------------------------------*/

@interface MamiServicesCustomCell : UITableViewCell

@property (nonatomic, strong) MamiServicesModel *mamiModel;

@end

@interface MamiServicesCustomCell ()

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) TTTAttributedLabel *detailLabel;

@end

@implementation MamiServicesCustomCell

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
        [self.contentView addSubview:_iconImage];
        
        self.titleLabel = [TTTAttributedLabel new];
        self.titleLabel.textColor = KHexColor(@"#333433");
        self.titleLabel.font = KFontSize(14);
        [self.contentView addSubview:_titleLabel];
        
       
        self.detailLabel = [TTTAttributedLabel new];
        self.detailLabel.numberOfLines = 0;
        self.detailLabel.lineSpacing = 5;
        self.detailLabel.font = KFontSize(12);
        self.detailLabel.textColor = KHexColor(@"#5c5c5c");
        [self.contentView addSubview:_detailLabel];
        
        
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
            make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
            make.left.equalTo(self.iconImage.mas_right).offset(5);
            make.bottom.equalTo(self.cellView.mas_bottom).offset(-5);
            make.right.equalTo(self.cellView.mas_right).offset(-5);
            
        }];
        
        
    }
    return self;
}


- (void)setMamiModel:(MamiServicesModel *)mamiModel
{
    if (nil == mamiModel) {
        return;
    }
    self.titleLabel.text = mamiModel.titleName;
    self.detailLabel.text = mamiModel.detailName;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:mamiModel.imageName] placeholderImage:nil];
}
@end


/*-----------------------------------------------------------------------C-------------------------------------------*/



#import "MamiServicesVC.h"
#import "ZYMenuController.h"
#import <CoreLocation/CoreLocation.h> //定位
#import <MapKit/MapKit.h>             //定位
#import "YueZiCenterVC.h"
@interface MamiServicesVC ()<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) CLLocationManager* locationManager;//定位当前城市
@property (nonatomic, strong) UIButton *locationButton;

@end
@implementation MamiServicesVC
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"1-First-level-navigation"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClick)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
        self.locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.locationButton.frame = CGRectMake(0, 0, 60,14);
        [self.locationButton setTitle:@"定位" forState:UIControlStateNormal];
        [self.locationButton addTarget:self action:@selector(locationButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:_locationButton];
        self.navigationItem.rightBarButtonItem = right;
        right.tintColor = KHexColor(@"#ffffff");
    }
    return self;
}

- (void)leftClick
{
    [self.menuController showLeftViewController:YES];
}



#pragma mark -----------------------------------------------------------------------CLLocationManagerDelegate-------------------

- (void)locationButtonClick
{
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 10;
    [_locationManager requestAlwaysAuthorization];//添加这句
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currLocation = [locations lastObject];
    NSLog(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             NSString *city = placemark.locality;
             if (!city)
             {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             [self.locationButton setTitle:city forState:UIControlStateNormal];
             NSLog(@"city = %@", city);
         }
         else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }
         else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];
    
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied)
    {
        //访问被拒绝
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
}





- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_locationManager stopUpdatingLocation];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.menuController.panEnabel = YES;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"妈妈服务";
    NavigationBarTitleColor
    self.view.backgroundColor =  KHexColor(@"#f3f3f3");
    self.dataArray = [NSMutableArray array];
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
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell_ma";
    MamiServicesCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[MamiServicesCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.mamiModel = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YueZiCenterVC *yuezi = [YueZiCenterVC new];
    MamiServicesModel *info = _dataArray[indexPath.row];
    yuezi.navigationTitle = info.titleName;
    yuezi.type_id = info.mamaServices_id;
    [self.navigationController pushViewController:yuezi animated:YES];
}

#pragma mark ------------------------------------------------------------------ASURLConnection----------------------------------------------------------------
- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{} method:@"renhe.momService.serviceType" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"];
            for (int i = 0; i<dataArr.count; i ++)
            {
                
                MamiServicesModel *model = [[MamiServicesModel alloc] initWithDictionary:dataArr[i]];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

@end
