
//
//  BenZhouRenWuVC.m
//  Mamabao
//
//  Created by Michael on 15/12/8.
//  Copyright © 2015年 Michael. All rights reserved.
//

/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface BenZhouRenWuModel  : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *state; //0未完场  1 已完成
@property (nonatomic, strong) NSString *taskId;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface BenZhouRenWuModel ()

@end

@implementation BenZhouRenWuModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([dic objectForKey:@"name"]) {
            self.name = [dic objectForKey:@"name"];
        }
        if ([[dic objectForKey:@"state"]isKindOfClass:[NSNumber class]]) {
            self.state = [[dic objectForKey:@"state"] stringValue];
        }
        if ([[dic objectForKey:@"taskId"]isKindOfClass:[NSNumber class]]) {
            self.taskId = [[dic objectForKey:@"taskId"] stringValue];
        }
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/
@interface BenZhouRenWuCustomCell : UITableViewCell
@property (nonatomic, strong) BenZhouRenWuModel *benZhouModel;
@property (nonatomic, strong) void(^finishBlock)(NSString *);
@end


@interface BenZhouRenWuCustomCell ()

@property (nonatomic, strong) NSString *taskString;
@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIButton *finishButton;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@end

@implementation BenZhouRenWuCustomCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellView = [UIView new];
        self.cellView.layer.cornerRadius = 5;
        self.cellView.layer.masksToBounds = YES;
        self.cellView.backgroundColor = KHexColor(@"#ffcfc9");
        [self.contentView addSubview:_cellView];
        
              
        self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.finishButton setTitle:@"待完成" forState:UIControlStateNormal];
        [self.finishButton setTitleColor:KHexColor(@"#807864") forState:UIControlStateNormal];
        [self.finishButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ffeec2")] forState:UIControlStateNormal];
        [self.finishButton addTarget:self action:@selector(finishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.cellView addSubview:_finishButton];
        
           
        self.titleLabel = [TTTAttributedLabel new];
        self.titleLabel.font = KFontSize(14);
        self.titleLabel.textColor = KHexColor(@"#332b29");
        self.titleLabel.text = @"测量胎心胎动";
        [self.contentView addSubview:_titleLabel];
        
        [_cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        [_finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.cellView);
            make.width.equalTo(120);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.cellView.mas_centerY).offset(0);
            make.left.equalTo(self.cellView.mas_left).offset(10);
            make.width.equalTo(self.titleLabel.mas_width);
            make.height.equalTo(14);
        }];

    }
    return self;
}

- (void)finishButtonClick:(UIButton *)button
{
   
    
    if (self.finishBlock)
    {
        self.finishBlock(self.taskString);
    }
    
    [self.finishButton setTitle:@"已完成" forState:UIControlStateNormal];
    [self.finishButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.finishButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ffb5b0")] forState:UIControlStateNormal];

}

-  (void)setBenZhouModel:(BenZhouRenWuModel *)benZhouModel
{
    if (benZhouModel == nil) {
        return;
    }
    self.titleLabel.text = benZhouModel.name;
    self.taskString = benZhouModel.taskId;
    if ([benZhouModel.state intValue] == 0)
    {
        [self.finishButton setTitle:@"待完成" forState:UIControlStateNormal];
        [self.finishButton setTitleColor:KHexColor(@"#807864") forState:UIControlStateNormal];
        [self.finishButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ffeec2")] forState:UIControlStateNormal];

    }
    else if ([benZhouModel.state intValue] == 1)
    {
        [self.finishButton setTitle:@"已完成" forState:UIControlStateNormal];
        [self.finishButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
        [self.finishButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ffb5b0")] forState:UIControlStateNormal];
    }
}
@end


/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "BenZhouRenWuVC.h"
@interface BenZhouRenWuVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BenZhouRenWuVC

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
    self.title = @"本周任务";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.dataArray = [NSMutableArray array];
    self.user = [[ASUserInfoModel alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 90;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [self requestData];
}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------
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
    BenZhouRenWuCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[BenZhouRenWuCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.benZhouModel = _dataArray[indexPath.row];
    [cell setFinishBlock:^(NSString *taskId) {
        
    
        [ASURLConnection requestAFNJSon:@{@"user_id":@32,@"task_id":taskId } method:@"jumper.classroom.plan.finish" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
            
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                
                k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
                
            }
            else
            {
                k_yjHUD([ASURLConnection getMessage:responseObject], self.view);

            }
        } errorBlock:^(NSError *error) {
        }];

    }];
   
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{@"user_id":@32} method:@"renhe.system.getTaskList" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"];
            for (int i = 0;  i <dataArr.count; i++) {
                BenZhouRenWuModel *model = [[BenZhouRenWuModel alloc] initWithDictionary:dataArr[i]];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
            
        }
        
    } errorBlock:^(NSError *error) {
    }];
}
@end
