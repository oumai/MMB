//
//  HospitalIntroduceVC.m
//  Mamabao
//
//  Created by Michael on 15/11/10.
//  Copyright © 2015年 Michael. All rights reserved.
//


/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface HospitalIntroduceModel  : NSObject

@property (nonatomic, strong) NSString *hospitalNmae;
@property (nonatomic, strong) NSString *hospital_id;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface HospitalIntroduceModel ()

@end

@implementation HospitalIntroduceModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([dic objectForKey:@"name"]) {
            self.hospitalNmae = [dic objectForKey:@"name"];
        }
        if ([[dic objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
            self.hospital_id = [[dic objectForKey:@"id"] stringValue];
        }
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface HospitalIntroduceCustomCell : UITableViewCell

@property (nonatomic, strong) HospitalIntroduceModel *hospitalModel;

@end



@interface HospitalIntroduceCustomCell ()

@property (nonatomic, strong) TTTAttributedLabel *hospitalLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation HospitalIntroduceCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.hospitalLabel = [TTTAttributedLabel new];
        self.hospitalLabel.font = KFontSize(14);
        self.hospitalLabel.textColor = KHexColor(@"#3f3f3f");
        [self.contentView addSubview:_hospitalLabel];
        
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#efefef");
        [self.contentView addSubview:_line];
        
        [_hospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.width.equalTo(self.hospitalLabel.mas_width);
            make.height.equalTo(14);
        }];
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(0.5);
        }];
    }
    return self;
}

- (void)setHospitalModel:(HospitalIntroduceModel *)hospitalModel
{
    if (nil == hospitalModel) {
        return;
    }
    
    self.hospitalLabel.text = hospitalModel.hospitalNmae;
}



@end


/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "HospitalIntroduceVC.h"
#import "CityVC.h"
#import "HospitalDetailVC.h"
@interface HospitalIntroduceVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *right;
@end

@implementation HospitalIntroduceVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
        self.right = [UIButton buttonWithType:UIButtonTypeCustom];
        self.right.frame = CGRectMake(50, 0, 90, 30);
        self.right.titleLabel.font = KFontSize(14);
        [self.right setTitle:@"深圳市" forState:UIControlStateNormal];
        [self.right setImage:[UIImage imageNamed:@"1_hospital_list"] forState:(UIControlStateNormal)];
        [self.right addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
        [self.right setImageEdgeInsets:UIEdgeInsetsMake(0, 80, 0, 0)];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_right];
        self.navigationItem.rightBarButtonItem = rightItem;
        rightItem.tintColor = KHexColor(@"#ffffff");
        
        
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"医院列表";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    _dataArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [self requestData];
}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------

- (void)rightClick
{
    CityVC *city = [CityVC new];
    [self.navigationController pushViewController:city animated:YES];
}
- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 45)];
    sectionView.backgroundColor = KHexColor(@"#f3f3f3");
    
    UIImageView *iconImage = [UIImageView new];
    iconImage.image = [UIImage  imageNamed:@"3_hospital_list"];
    [sectionView addSubview:iconImage];
    
    
    UILabel *sectionLabel = [UILabel new];
    sectionLabel.font = KFontSize(14);
    sectionLabel.textColor = KHexColor(@"#684242");
    sectionLabel.text = @"选择医院";
    [sectionView addSubview:sectionLabel];
    
    
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sectionView.mas_centerY).offset(0);
        make.left.equalTo(sectionView.mas_left).offset(10);
        make.width.equalTo(15);
        make.height.equalTo(15);
    }];

    [sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sectionView.mas_centerY).offset(0);
        make.left.equalTo(iconImage.mas_right).offset(10);
        make.width.equalTo(sectionLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    

    return sectionView;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    HospitalIntroduceCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[HospitalIntroduceCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.hospitalModel = _dataArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HospitalDetailVC *detail = [HospitalDetailVC new];
    HospitalIntroduceModel *infoObject = _dataArray[indexPath.row];
    detail.hospital_id = infoObject.hospital_id;
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark ------------------------------------------------------------------ASURLConnection----------------------------------------------------------------
- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{} method:@"jumper.hospital.hospital.getlist" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"];
            for (NSDictionary *dic in dataArr)
            {
                
                HospitalIntroduceModel *model = [[HospitalIntroduceModel alloc] initWithDictionary:dic];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];

        }
        
    } errorBlock:^(NSError *error) {
        
    }];
}

@end
