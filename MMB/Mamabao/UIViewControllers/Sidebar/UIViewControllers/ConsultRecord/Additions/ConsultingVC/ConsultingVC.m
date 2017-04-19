//
//  ConsultingVC.m
//  Mamabao
//
//  Created by Michael on 15/11/14.
//  Copyright © 2015年 Michael. All rights reserved.
//




/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface ConsultingModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *major;
@property (nonatomic, strong) NSString *doc_name;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *status_name;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface ConsultingModel ()

@end

@implementation ConsultingModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([[dic objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
            self.id = [[dic objectForKey:@"id"] stringValue];
        }
        if ([[dic objectForKey:@"status"] isKindOfClass:[NSNumber class]]) {
            self.status = [[dic objectForKey:@"status"] stringValue];
        }
        if ([dic objectForKey:@"time"]) {
            self.time = [dic objectForKey:@"time"];
        }
        if ([dic objectForKey:@"doc_name"]) {
            self.doc_name = [dic objectForKey:@"doc_name"];
        }
        if ([dic objectForKey:@"content"]) {
            self.content = [dic objectForKey:@"content"];
        }
        if ([dic objectForKey:@"major"]) {
            self.major = [dic objectForKey:@"major"];
        }
//        if ([dic objectForKey:@"status_name"]) {
//            self.status_name = [dic objectForKey:@"status_name"];
//        }

        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface ConsultingCustomCell : UITableViewCell

@property (nonatomic, strong) ConsultingModel *conModel;

@end



@interface ConsultingCustomCell ()

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *payButton;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation ConsultingCustomCell

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
        
        
        self.nameLabel = [UILabel new];
        self.nameLabel.textColor = KHexColor(@"#999999");
        self.nameLabel.font = KFontSize(14);
        [self.contentView addSubview:_nameLabel];
        
        
        self.payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.payButton.titleLabel.font = KFontSize(15);
        self.payButton.layer.cornerRadius = 5;
        self.payButton.layer.masksToBounds = YES;
        [self.payButton addTarget:self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_payButton];
        
        
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#cbcbcb");
        [self.contentView addSubview:_line];
        
        
        
        self.questionLabel = [UILabel new];
        self.questionLabel.textColor = KHexColor(@"#333333");
        self.questionLabel.font = KFontSize(14);
        [self.contentView addSubview:_questionLabel];
        
        
        
        
        
        self.timeLabel = [UILabel new];
        self.timeLabel.textColor = KHexColor(@"#cecece");
        self.timeLabel.font = KFontSize(14);
        [self.contentView addSubview:_timeLabel];
        
        [_cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(7);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-7);
            make.right.equalTo(self.contentView.mas_right).offset(-7);
            
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cellView.mas_top).offset(15);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.width.equalTo(self.nameLabel.mas_width);
            make.height.equalTo(14);
            
        }];
        [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel.mas_centerY).offset(0);
            make.right.equalTo(self.cellView.mas_right).offset(-15);
            make.width.equalTo(50);
            make.height.equalTo(25);
        }];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.right.equalTo(self.cellView.mas_right).offset(0);
            make.top.equalTo(self.cellView.mas_top).offset(45);
            make.height.equalTo(0.5);
        }];
        [_questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.line.mas_top).offset(15);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.right.equalTo(self.cellView.mas_right).offset(-15);
            make.height.equalTo(14);
            
        }];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.questionLabel.mas_bottom).offset(15);
            make.left.equalTo(self.cellView.mas_left).offset(15);
            make.width.equalTo(self.timeLabel.mas_width);
            make.height.equalTo(14);
            
        }];
    }
    return self;
}


- (void)payButtonClick
{
    
}
- (void)setConModel:(ConsultingModel *)conModel
{
    if (nil == conModel) {
        return;
    }
    self.nameLabel.text = conModel.major;
    self.questionLabel.text = conModel.content;
    self.timeLabel.text = [NSString stringWithFormat:@"%@",conModel.time];
    
    if ([conModel.status isEqualToString:@"0"]) {
        //status 0:未认领 1:已认领 2:未回复 3:已回复 4:待处理 5: 已结束 6 :已拒绝 7:未评价 8:已评价
        [self.payButton setTitle:@"未认领" forState:UIControlStateNormal];
        [self.payButton setTitleColor:KHexColor(@"#ff627e") forState:UIControlStateNormal];
    }
    if ([conModel.status isEqualToString:@"1"]) {
        [self.payButton setTitle:@"已认领" forState:UIControlStateNormal];
        [self.payButton setTitleColor:KHexColor(@"#999999") forState:UIControlStateNormal];
    }

}

@end


/*-----------------------------------------------------------------------C-------------------------------------------*/
#import "ConsultingVC.h"
#import "ConsultingChat.h"
#import "ConsultOverChat.h"
@interface ConsultingVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger leftPage;
@property (nonatomic, strong) NSMutableArray *leftArray;

@end

@implementation ConsultingVC






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
    NavigationBarTitleColor
    self.view.backgroundColor = KHexColor(@"#ffffff");
    self.leftPage = 1;
    self.leftArray = [NSMutableArray array];
    self.menuController.panEnabel = NO;
    self.user = [[ASUserInfoModel alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 120;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
   
    [self requestData];
    
}
#pragma mark ----------------------------------------------------------------------------UITableViewDatasource delegate--------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_leftArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    ConsultingCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[ConsultingCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.conModel = _leftArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConsultingModel *model = _leftArray[indexPath.row];
    ConsultingChat *chat = [ConsultingChat new];
    chat.detailId = [model.id intValue];
    [self.navigationController pushViewController:chat animated:YES];
}

- (void)requestData
{
    NSDictionary *json = @{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],
                           @"page_index":[NSNumber numberWithInteger:self.leftPage],
                           @"page_size":@10,
                           @"type":self.type};
    [ASURLConnection requestAFNJSon:json method:@"renh.consultant.getList" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqual:@1])
        {
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject]objectFromJSONString]objectForKey:@"data"];
            if (dataArr.count == 0) {
                k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            }
            for (NSDictionary *dic in dataArr) {
                
                ConsultingModel *model = [[ConsultingModel alloc] initWithDictionary:dic];
                [_leftArray addObject:model];
            }
            [_tableView reloadData];

        }
       
    } errorBlock:^(NSError *error) {
    }];

}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ConsultingModel *model = _leftArray[indexPath.row];
    [ASURLConnection requestAFNJSon:@{@"problem_id":model.id} method:@"jumper.consultant.delete" view:nil version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject]isEqual:@1]) {
            [_leftArray removeObjectAtIndex:indexPath.row];
            [_tableView reloadData];
            k_NSlogHUD(@"删除成功")
        }else{
        }
    } errorBlock:^(NSError *error) {
    }];

}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
@end

