//
//  OximeterRecordVC.m
//  Mamabao
//
//  Created by Michael on 15/11/20.
//  Copyright © 2015年 Michael. All rights reserved.
//
/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface  OximeterRecordModel  : NSObject
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString *remark;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface OximeterRecordModel ()

@end

@implementation OximeterRecordModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([dic objectForKey:@"time"]) {
            self.time = [dic objectForKey:@"time"];
        }
        if ([dic objectForKey:@"value"]) {
            self.value = [dic objectForKey:@"value"];
        }
        if ([dic objectForKey:@"unit"]) {
            self.unit = [dic objectForKey:@"unit"];
        }
        if ([[dic objectForKey:@"remark"] isKindOfClass:[NSNumber class]]) {
            self.remark = [[dic objectForKey:@"remark"] stringValue];
        }
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface OximeterRecordCustomCell : UITableViewCell

@property (nonatomic, strong) OximeterRecordModel *oximeterModel;

@end



@interface OximeterRecordCustomCell ()


@property (nonatomic, strong) TTTAttributedLabel *timeTitleLabel;
@property (nonatomic, strong) TTTAttributedLabel *xiangMtitleLabel;
@property (nonatomic, strong) TTTAttributedLabel *dataTitleLabel;
@property (nonatomic, strong) TTTAttributedLabel *unitTitleLabel;
@property (nonatomic, strong) TTTAttributedLabel *resultTitleLabel;
@property (nonatomic, strong) UIView *line;
@end

@implementation OximeterRecordCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.timeTitleLabel = [TTTAttributedLabel new];
        self.timeTitleLabel.textColor = KHexColor(@"#999999");
        self.timeTitleLabel.font = KFontSize(14);
        [self.contentView addSubview:_timeTitleLabel];
        
        self.xiangMtitleLabel = [TTTAttributedLabel new];
        self.xiangMtitleLabel.textColor = KHexColor(@"#999999");
        self.xiangMtitleLabel.font = KFontSize(14);
        [self.contentView addSubview:_xiangMtitleLabel];
        
        self.dataTitleLabel = [TTTAttributedLabel new];
        self.dataTitleLabel.textColor = KHexColor(@"#999999");
        self.dataTitleLabel.font = KFontSize(14);
        [self.contentView addSubview:_dataTitleLabel];
        
        self.unitTitleLabel = [TTTAttributedLabel new];
        self.unitTitleLabel.textColor = KHexColor(@"#999999");
        self.unitTitleLabel.font = KFontSize(14);
        [self.contentView addSubview:_unitTitleLabel];
        
        self.resultTitleLabel = [TTTAttributedLabel new];
        self.resultTitleLabel.textColor = KHexColor(@"#999999");
        self.resultTitleLabel.font = KFontSize(14);
        [self.contentView addSubview:_resultTitleLabel];
        
        
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#999999");
        [self.contentView addSubview:_line];
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.height.equalTo(0.5);
            
        }];

        
        
        [_timeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.width.equalTo(self.timeTitleLabel.mas_width);
            make.height.equalTo(16);
        }];
        [_dataTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.centerX.equalTo(self.contentView.mas_centerX).offset(0);
            make.width.equalTo(self.dataTitleLabel.mas_width);
            make.height.equalTo(16);
        }];
        [_resultTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.width.equalTo(self.resultTitleLabel.mas_width);
            make.height.equalTo(16);
        }];
        
        [_xiangMtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.centerX.equalTo(self.contentView.mas_centerX).offset(-CoreWidth/4+15+10);
            make.width.equalTo(self.xiangMtitleLabel.mas_width);
            make.height.equalTo(16);
        }];
        [_unitTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.centerX.equalTo(self.contentView.mas_centerX).offset(CoreWidth/4-10);
            make.width.equalTo(self.xiangMtitleLabel.mas_width);
            make.height.equalTo(18);
        }];
        
        
    }
    return self;
}


- (void)setOximeterModel:(OximeterRecordModel *)oximeterModel
{
    if (nil ==oximeterModel) {
        return;
    }
    self.timeTitleLabel.text = oximeterModel.time;
    self.dataTitleLabel.text = oximeterModel.value;
    self.unitTitleLabel.text = oximeterModel.unit;
    
    if ([oximeterModel.remark intValue ] == 0) {
        self.resultTitleLabel.text = @"正常";

    }
    else if ([oximeterModel.remark intValue ] == 1) {
        self.resultTitleLabel.text = @"异常";
        
    }


}


@end


/*-----------------------------------------------------------------------C-------------------------------------------*/


#import "OximeterRecordVC.h"

@interface OximeterRecordVC ()<UITableViewDataSource,UITableViewDelegate,DateDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *changeDateView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) TTTAttributedLabel *timeTitleLabel;
@property (nonatomic, strong) TTTAttributedLabel *xiangMtitleLabel;
@property (nonatomic, strong) TTTAttributedLabel *dataTitleLabel;
@property (nonatomic, strong) TTTAttributedLabel *unitTitleLabel;
@property (nonatomic, strong) TTTAttributedLabel *resultTitleLabel;

@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) TTTAttributedLabel *timeLable;//picker
@property (nonatomic, strong) ASDayPicker *dayPicker;
@property (nonatomic, strong) NSString  *dayStr;//时间
@end

@implementation OximeterRecordVC


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  =  [self.typeRecordString integerValue] == 2 ? @"血氧记录" : [self.typeRecordString integerValue] == 3 ? @"心率记录" : [self.typeRecordString integerValue] == 4 ? @"体温记录" :[self.typeRecordString integerValue] == 5 ? @"体重记录" :[self.typeRecordString integerValue] == 6 ? @"血压记录" :[self.typeRecordString integerValue] == 7 ? @"血糖记录" : @"胎动记录";
    NavigationBarTitleColor
    self.view.backgroundColor = KHexColor(@"#ffffff");
    self.menuController.panEnabel = NO;
    self.user = [[ASUserInfoModel alloc] init];
    self.dataArray = [NSMutableArray array];
    [self makeUI];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(0);
        make.left.bottom.right.equalTo(self.view);
    }];
    [self requestData];
}
#pragma mark ------------------------------------------------------------------makeUI  -----------------------------------------------------------

- (void)makeUI  //title
{
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, CoreWidth, 120+28)];
    self.headerView.backgroundColor = KHexColor(@"#f5f5f5");
    [self.view addSubview:_headerView];
    
    self.changeDateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 75+28)];
    self.changeDateView.backgroundColor = KHexColor(@"#ffffff");
    [self.headerView addSubview:_changeDateView];
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 75+28, CoreWidth, 45)];
    self.titleView.backgroundColor = KHexColor(@"#ffa8b8");
    [self.headerView addSubview:_titleView];
    
    
    self.timeTitleLabel = [TTTAttributedLabel new];
    self.timeTitleLabel.textColor = KHexColor(@"#ffffff");
    self.timeTitleLabel.font = KFontSize(16);
    self.timeTitleLabel.text = @"时间";
    [self.titleView addSubview:_timeTitleLabel];
    
    
    self.dataTitleLabel = [TTTAttributedLabel new];
    self.dataTitleLabel.textColor = KHexColor(@"#ffffff");
    self.dataTitleLabel.font = KFontSize(16);
    self.dataTitleLabel.text = @"数据";
    [self.titleView addSubview:_dataTitleLabel];
    
    
    
    self.resultTitleLabel = [TTTAttributedLabel new];
    self.resultTitleLabel.textColor = KHexColor(@"#ffffff");
    self.resultTitleLabel.font = KFontSize(16);
    self.resultTitleLabel.text = @"结论";
    [self.titleView addSubview:_resultTitleLabel];
    
    
    
    
    self.xiangMtitleLabel = [TTTAttributedLabel new];
    self.xiangMtitleLabel.textColor = KHexColor(@"#ffffff");
    self.xiangMtitleLabel.font = KFontSize(16);
    self.xiangMtitleLabel.text = @"项目";
    [self.titleView addSubview:_xiangMtitleLabel];
    
    
    
    self.unitTitleLabel = [TTTAttributedLabel new];
    self.unitTitleLabel.textColor = KHexColor(@"#ffffff");
    self.unitTitleLabel.font = KFontSize(16);
    self.unitTitleLabel.text = @"单位";
    [self.titleView addSubview:_unitTitleLabel];
    
    [_timeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleView.mas_centerY).offset(0);
        make.left.equalTo(self.titleView.mas_left).offset(15);
        make.width.equalTo(self.timeTitleLabel.mas_width);
        make.height.equalTo(16);
    }];
    [_dataTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleView.mas_centerY).offset(0);
        make.centerX.equalTo(self.titleView.mas_centerX).offset(0);
        make.width.equalTo(self.dataTitleLabel.mas_width);
        make.height.equalTo(16);
    }];
    [_resultTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleView.mas_centerY).offset(0);
        make.right.equalTo(self.titleView.mas_right).offset(-15);
        make.width.equalTo(self.resultTitleLabel.mas_width);
        make.height.equalTo(16);
    }];
    [_xiangMtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleView.mas_centerY).offset(0);
        make.centerX.equalTo(self.titleView.mas_centerX).offset(-CoreWidth/4+15);
        make.width.equalTo(self.xiangMtitleLabel.mas_width);
        make.height.equalTo(16);
    }];
    
    [_unitTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleView.mas_centerY).offset(0);
        make.centerX.equalTo(self.titleView.mas_centerX).offset(CoreWidth/4-15);
        make.width.equalTo(self.xiangMtitleLabel.mas_width);
        make.height.equalTo(16);
    }];
    
    [self makeDdePicker];
    
}
#pragma mark ------------------------------------------------------------------UIPickerViewGetData-----------------------------------------------------------
- (void)makeDdePicker
{
    
    self.timeLable = [[TTTAttributedLabel alloc]initWithFrame:CGRectMake(0, 0, CoreWidth, 35)];
    self.timeLable.font = [UIFont systemFontOfSize:18.0];
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    self.timeLable.textColor = RGBA(83, 83, 83, 1);
    [self.changeDateView addSubview:_timeLable];
    
    self.dayPicker = [[ASDayPicker alloc]initWithFrame:CGRectMake(CoreWidth/2-160, 35, 320, 68)];
    self.dayPicker.delegate = self;
    NSDateComponents *weeks = [[NSDateComponents alloc] init];
    weeks.week = 0;
    NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:weeks toDate:[NSDate date] options:0];
    self.dayPicker.selectedDateBackgroundColor = [UIColor colorWithRed:255/255.0 green:104/225.0 blue:97/255.0 alpha:1];
    [self.dayPicker setStartDate:nil endDate:endDate];
    [self.dayPicker addObserver:self forKeyPath:@"selectedDate" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    [self.changeDateView addSubview:self.dayPicker];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.dayPicker removeObserver:self forKeyPath:@"selectedDate"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSDate *day = change[NSKeyValueChangeNewKey];
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    self.dayStr = [dateformatter stringFromDate:day];
    NSString *str2 = [NSString stringWithFormat:@"%@",[self.dayStr substringToIndex:7]];
    self.timeLable.text = str2;
}
-(void)getdate:(NSString *)date{
    NSString *dateString = self.dayStr;
    [self getTemPreture:dateString];
}
-(void)getTemPreture:(NSString *)dateString
{
    [ASLoadingView showActivity:_tableView];
    [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[_user getUserMessageFromLocation].userId],@"date":dateString} method:kGetTemRequestRecord view:nil version:@"" completeBlock:^(NSData *data, id responseObject) {
        [ASLoadingView hidenActivity:_tableView];
        [_dataArray removeAllObjects];
        NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
        if ([[ASURLConnection getMsg:responseObject]isEqual:@1]) {
            if (dataArr.count == 0) {
                k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            }
            else
            {
                for (int i = 0; i <dataArr.count; i++)
                {
                    OximeterRecordModel *model = [[OximeterRecordModel alloc] initWithDictionary:dataArr[i]];
                    [_dataArray addObject:model];
                }
            }
            [_tableView reloadData];
        }
        else
        {
            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
        }
    } errorBlock:^(NSError *error) {
        [ASLoadingView hidenActivity:_tableView];
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
#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    OximeterRecordCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[OximeterRecordCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
   
    cell.xiangMtitleLabel.text =  [self.typeRecordString integerValue] == 2 ? @"血氧" : [self.typeRecordString integerValue] == 3 ? @"心率" : [self.typeRecordString integerValue] == 4 ? @"体温" :[self.typeRecordString integerValue] == 5 ? @"体重" :[self.typeRecordString integerValue] == 6 ? @"血压" :[self.typeRecordString integerValue] == 7 ? @"血糖" : @"胎动";
    cell.oximeterModel = _dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
#pragma mark ------------------------------------------------------------------ASURLConnection  -----------------------------------------------------------
- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],@"date":self.dayStr,@"type":self.typeRecordString} method:@"renhe.system.healthy1Data" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        [_dataArray removeAllObjects];
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            if (dataArr.count == 0) {
                k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            }
            else
            {
                for (int i = 0; i <dataArr.count; i++) {
                    OximeterRecordModel *model = [[OximeterRecordModel alloc] initWithDictionary:dataArr[i]];
                    [_dataArray addObject:model];
                }
               
            }
            [_tableView reloadData];
        }
        else
        {
            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
}

@end

