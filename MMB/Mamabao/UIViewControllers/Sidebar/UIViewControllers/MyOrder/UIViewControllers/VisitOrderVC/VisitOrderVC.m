//
//  VisitOrderVC.m
//  Mamabao
//
//  Created by Michael on 15/11/10.
//  Copyright © 2015年 Michael. All rights reserved.
//

/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface VisitModel : NSObject
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *entity_id;
@property (nonatomic, strong) NSString *vistit_id;
@property (nonatomic, strong) NSString *entity_name;
@property (nonatomic, strong) NSString *linkMan;
@property (nonatomic, strong) NSString *visitNum;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *datetime;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *status;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface VisitModel ()

@end

@implementation VisitModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([dic objectForKey:@"imageUrl"]) {
            self.imageUrl = [dic objectForKey:@"imageUrl"];
        }
        if ([dic objectForKey:@"entity_name"]) {
            self.entity_name = [dic objectForKey:@"entity_name"];
        }
        if ([dic objectForKey:@"linkMan"]) {
            self.linkMan = [dic objectForKey:@"linkMan"];
        }
        if ([[dic objectForKey:@"visitNum"] isKindOfClass:[NSNumber class]]) {
            self.visitNum = [[dic objectForKey:@"visitNum"] stringValue];
        }
        if ([dic objectForKey:@"datetime"]) {
            self.datetime = [dic objectForKey:@"datetime"];
        }
        if ([dic objectForKey:@"phone"]) {
            self.phone = [dic objectForKey:@"phone"];
        }
        if ([[dic objectForKey:@"entity_id"] isKindOfClass:[NSNumber class]]) {
            self.entity_id = [[dic objectForKey:@"entity_id"] stringValue];
        }
        if ([[dic objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
            self.vistit_id = [[dic objectForKey:@"id"] stringValue];
        }
        if ([[dic objectForKey:@"status"] isKindOfClass:[NSNumber class]]) {
            self.status = [[dic objectForKey:@"status"] stringValue];
        }


        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface VisitCustomCell : UITableViewCell

@property (nonatomic, strong) VisitModel *visit;
@property (nonatomic, strong) void(^cancelBlock)();


@end



@interface VisitCustomCell ()

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) TTTAttributedLabel *yueZiCenterNameLabel;
@property (nonatomic, strong) TTTAttributedLabel *nameLabel;
@property (nonatomic, strong) TTTAttributedLabel *numberPeopleLabel;
@property (nonatomic, strong) TTTAttributedLabel *timeLabel;
@property (nonatomic, strong) TTTAttributedLabel *phoneLabel;
@property (nonatomic, strong) NSString *entity_id; //预约参观的ID
@property (nonatomic, strong) NSString *vistit_id;
@end

@implementation VisitCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KHexColor(@"#f5f5f5");
        
        self.cellView = [UIView new];
        self.cellView.backgroundColor = KHexColor(@"#ffffff");
        self.cellView.layer.cornerRadius = 5;
        self.cellView.layer.masksToBounds = YES;
        self.cellView.layer.borderColor = KHexColor(@"#e6e6e6").CGColor;
        self.cellView.layer.borderWidth = 1;
        [self.contentView addSubview:_cellView];
        
               
        
        self.iconImage = [UIImageView new];
        [self.contentView addSubview:_iconImage];
        
        
        self.yueZiCenterNameLabel = [TTTAttributedLabel new];
        self.yueZiCenterNameLabel.textColor = KHexColor(@"#333333");
        self.yueZiCenterNameLabel.font = KFontSize(14);
        [self.contentView addSubview:_yueZiCenterNameLabel];
        
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelButton.titleLabel.font = KFontSize(15);
        self.cancelButton.layer.cornerRadius = 5;
        self.cancelButton.layer.masksToBounds = YES;
        [self.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.cancelButton setTitle:@"取消预约" forState:UIControlStateNormal]; //取消
//        [self.cancelButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
//        [self.cancelButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff92a5")] forState:UIControlStateNormal];
//        self.cancelButton.enabled = YES;
        [self.contentView addSubview:_cancelButton];
        
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#cccccc");
        [self.contentView addSubview:_line];
             
        self.nameLabel = [TTTAttributedLabel new];
        self.nameLabel.textColor = KHexColor(@"#808080");
        self.nameLabel.font = KFontSize(14);
        [self.contentView addSubview:_nameLabel];
        
              
        self.numberPeopleLabel = [TTTAttributedLabel new];
        self.numberPeopleLabel.textColor = KHexColor(@"#808080");
        self.numberPeopleLabel.font = KFontSize(14);
        [self.contentView addSubview:_numberPeopleLabel];
        
              
        self.timeLabel = [TTTAttributedLabel new];
        self.timeLabel.textColor = KHexColor(@"#808080");
        self.timeLabel.font = KFontSize(14);
        [self.contentView addSubview:_timeLabel];
        
      
        self.phoneLabel = [TTTAttributedLabel new];
        self.phoneLabel.textColor = KHexColor(@"#808080");
        self.phoneLabel.font = KFontSize(14);
        [self.contentView addSubview:_phoneLabel];
        
        [_cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(7);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-7);
            make.right.equalTo(self.contentView.mas_right).offset(-7);
            
        }];
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cellView.mas_top).offset(15);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.width.equalTo(54);
            make.height.equalTo(54);
        }];
        [_yueZiCenterNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImage.mas_centerY).offset(0);
            make.left.equalTo(self.iconImage.mas_right).offset(15);
            make.width.equalTo(self.yueZiCenterNameLabel.mas_width);
            make.height.equalTo(14);
            
        }];
        
        [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconImage.mas_centerY).offset(0);
            make.right.equalTo(self.cellView.mas_right).offset(-10);
            make.width.equalTo(80);
            make.height.equalTo(25);
        }];
        
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.right.equalTo(self.cellView.mas_right).offset(-15);
            make.top.equalTo(self.iconImage.mas_bottom).offset(15);
            make.height.equalTo(0.5);
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line.mas_top).offset(10);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.width.equalTo(self.nameLabel.mas_width);
            make.height.equalTo(14);
            
        }];
        [_numberPeopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.width.equalTo(self.numberPeopleLabel.mas_width);
            make.height.equalTo(14);
            
        }];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.numberPeopleLabel.mas_bottom).offset(10);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.width.equalTo(self.timeLabel.mas_width);
            make.height.equalTo(14);
            
        }];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.width.equalTo(self.phoneLabel.mas_width);
            make.height.equalTo(14);
            
        }];
        
    }
    return self;
}


- (void)cancelButtonClick
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}
- (void)setVisit:(VisitModel *)visit
{
    if (nil == visit) {
        return;
    }
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:visit.imageUrl] placeholderImage:nil];
    self.yueZiCenterNameLabel.text = visit.entity_name;
    self.nameLabel.text = [NSString stringWithFormat:@"姓名：       %@",visit.linkMan];
    self.numberPeopleLabel.text = [NSString stringWithFormat:@"参观人数：%@",visit.visitNum];
    self.timeLabel.text = [NSString stringWithFormat:@"参观时间：%@",visit.datetime];
    self.phoneLabel.text = [NSString stringWithFormat:@"联系电话：%@",visit.phone];
    self.vistit_id = visit.vistit_id;
    
    if ([visit.status isEqualToString:@"0"]) {
       
        [self.cancelButton setTitle:@"取消预约" forState:UIControlStateNormal];         //取消
        [self.cancelButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
        [self.cancelButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff92a5")] forState:UIControlStateNormal];
        self.cancelButton.enabled = YES;

    }
    else if ([visit.status isEqualToString:@"1"]) {
        [self.cancelButton setTitle:@"已完成" forState:UIControlStateNormal];          //已完成
        [self.cancelButton setTitleColor:KHexColor(@"#999999") forState:UIControlStateNormal];
        [self.cancelButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ffffff")] forState:UIControlStateNormal];
        self.cancelButton.enabled = NO;
    }
    else  if([visit.status isEqualToString:@"2"]){
        [self.cancelButton setTitle:@"已取消" forState:UIControlStateNormal];          //已取消
        [self.cancelButton setTitleColor:KHexColor(@"#999999") forState:UIControlStateNormal];
        [self.cancelButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ffffff")] forState:UIControlStateNormal];
        self.cancelButton.enabled = NO;
    }

    
}

@end


/*-----------------------------------------------------------------------C-------------------------------------------*/


#import "VisitOrderVC.h"
#import "FDAlertView.h"
@interface VisitOrderVC ()<UITableViewDataSource,UITableViewDelegate,FDAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL *isSelect;
@property (nonatomic, assign) NSInteger hang;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *entity_Id;
@property (nonatomic, strong) NSString *vistit_id;
@end

@implementation VisitOrderVC

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约参观";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.view.backgroundColor = KHexColor(@"#f5f5f5");
    self.dataArray = [NSMutableArray array];
    _isSelect = malloc(sizeof(BOOL)*_dataArray.count);//运行时动态分配内存
    memset(_isSelect,0,sizeof(BOOL)*_dataArray.count);//把内存中的初始值设为0
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 200;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [self requestData];
    
}
#pragma mark ----------------------------------------------------------------------------UITableViewDatasource delegate---------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 10)];
    sectionView.backgroundColor = [UIColor clearColor];
    return sectionView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    VisitCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[VisitCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    //VisitCustomCell *cell = [[VisitCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.visit = _dataArray[indexPath.row];
    VisitModel *model = _dataArray[indexPath.row];
    [cell setCancelBlock:^{
        self.vistit_id = model.vistit_id;  //传全局的ID
        FDAlertView *alert = [[FDAlertView alloc] initWithTitle:[NSString stringWithFormat:@"您将取消参观“%@”",cell.yueZiCenterNameLabel.text]  icon:nil message:@"" delegate:self buttonTitles:@"取消", @"确定", nil];
         alert.tag = indexPath.row;
        [alert setMessageColor:KHexColor(@"#ff6e86") fontSize:0];
        [alert setButtonTitleColor:KHexColor(@"#1b1b1b") fontSize:0 atIndex:0];
        [alert setButtonTitleColor:KHexColor(@"#ff6e86") fontSize:0 atIndex:1];
        [alert show];
    }];
    if (_isSelect[indexPath.row]) {
        [cell.cancelButton setTitle:@"已取消" forState:UIControlStateNormal];          //已取消
        [cell.cancelButton setTitleColor:KHexColor(@"#999999") forState:UIControlStateNormal];
        [cell.cancelButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ffffff")] forState:UIControlStateNormal];
        cell.cancelButton.enabled = NO;
    }
    
    else
    {
        cell.cancelButton.enabled = YES;
        [cell.cancelButton setTitle:@"取消预约" forState:UIControlStateNormal]; //取消
        [cell.cancelButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
        [cell.cancelButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff92a5")] forState:UIControlStateNormal];
    }
    
      return cell;
}
#pragma mark ----------------------------------------------------------------------------FDAlertViewDelegate -----------------------------------------------------------------
- (void)alertView:(FDAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
    }
    if (buttonIndex == 1)
    {
        if ( [self.vistit_id isValid])
        {
            [ASURLConnection requestAFNJSon:@{@"vistit_id":self.vistit_id} method:@"renhe.orderService.visitCannel" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
                if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
                {
                    _isSelect[alertView.tag] = !_isSelect[alertView.tag];
                    [_tableView reloadData];
                }
            } errorBlock:^(NSError *error) {
            }];
        }
    }
}
#pragma mark ----------------------------------------------------------------------------ASURLConnnection -----------------------------------------------------------------

- (void)requestData
{
    
    [ASURLConnection requestAFNJSon:@{@"user_id":@32,@"pageNum":@1,@"pageSize":@30} method:@"renhe.orderService.visitIsOrdered" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            for (NSDictionary *dic in dataArr)
            {
                VisitModel *model = [[VisitModel alloc] initWithDictionary:dic];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
    } errorBlock:^(NSError *error) {
    }];
}
@end






