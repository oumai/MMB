//
//  OrderDetailYueZiCenterVC.m
//  Mamabao
//
//  Created by Michael on 15/12/8.
//  Copyright © 2015年 Michael. All rights reserved.
//

/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface OrderDetailYueZiCenterModel  : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface OrderDetailYueZiCenterModel ()

@end

@implementation OrderDetailYueZiCenterModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface OrderDetailYueZiCenterCustomCell : UITableViewCell


@end

@interface OrderDetailYueZiCenterCustomCell ()

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *line3;
@property (nonatomic, strong) UIView *line4;
@property (nonatomic, strong) UIView *line5;
@property (nonatomic, strong) UIView *line6;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel2;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel3;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel4;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel5;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel6;
@property (nonatomic, strong) TTTAttributedLabel *label;
@property (nonatomic, strong) TTTAttributedLabel *label2;
@property (nonatomic, strong) TTTAttributedLabel *label3;
@property (nonatomic, strong) TTTAttributedLabel *label4;
@property (nonatomic, strong) TTTAttributedLabel *label5;
@property (nonatomic, strong) TTTAttributedLabel *label6;

@end

@implementation OrderDetailYueZiCenterCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
          NSArray *titleArray = @[@"月子中心名称",@"套餐名称",@"费用",@"姓名",@"联系电话",@"入住时间"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KHexColor(@"#ffffff");
        
        self.cellView = [UIView new];
        self.cellView.layer.cornerRadius = 5;
        self.cellView.layer.masksToBounds = YES;
        self.cellView.layer.borderColor = KHexColor(@"#e6e6e6").CGColor;
        self.cellView.layer.borderWidth = 1;
        [self.contentView addSubview:_cellView];
        
       
        
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#cccccc");
        [self.contentView addSubview:_line];

        self.titleLabel = [TTTAttributedLabel new];
        self.titleLabel.textColor = KHexColor(@"#8c8c8c");
        self.titleLabel.font = KFontSize(14);
        self.titleLabel.text = @"月子中心名称";
        [self.contentView addSubview:_titleLabel];
        
        
        self.label = [TTTAttributedLabel new];
        self.label.textColor = KHexColor(@"#6f6f6f");
        self.label.font = KFontSize(14);
        self.label.text = @"shi";
        [self.contentView addSubview:_label];
        
        
        
        self.titleLabel2 = [TTTAttributedLabel new];                ///2
        self.titleLabel2.textColor = KHexColor(@"#8c8c8c");
        self.titleLabel2.font = KFontSize(14);
        self.titleLabel2.text = @"套餐名称";
        [self.contentView addSubview:_titleLabel2];
        
        
        self.label2 = [TTTAttributedLabel new];
        self.label2.textColor = KHexColor(@"#6f6f6f");
        self.label2.font = KFontSize(14);
        self.label2.text = @"shi";
        [self.contentView addSubview:_label2];
        
        
        self.line2 = [UIView new];
        self.line2.backgroundColor = KHexColor(@"#cccccc");
        [self.contentView addSubview:_line2];
        
        
       
        self.titleLabel3 = [TTTAttributedLabel new];                 ///3
        self.titleLabel3.textColor = KHexColor(@"#8c8c8c");
        self.titleLabel3.font = KFontSize(14);
        self.titleLabel3.text = @"费用";
        [self.contentView addSubview:_titleLabel3];
        
        
        self.label3 = [TTTAttributedLabel new];
        self.label3.textColor = KHexColor(@"#6f6f6f");
        self.label3.font = KFontSize(14);
        self.label3.text = @"shi";
        [self.contentView addSubview:_label3];
        
        
        self.line3 = [UIView new];
        self.line3.backgroundColor = KHexColor(@"#cccccc");
        [self.contentView addSubview:_line3];
        

        
        self.titleLabel4 = [TTTAttributedLabel new];                ///4
        self.titleLabel4.textColor = KHexColor(@"#8c8c8c");
        self.titleLabel4.font = KFontSize(14);
        self.titleLabel4.text = @"姓名";
        [self.contentView addSubview:_titleLabel4];
        
        
        self.label4 = [TTTAttributedLabel new];
        self.label4.textColor = KHexColor(@"#6f6f6f");
        self.label4.font = KFontSize(14);
        self.label4.text = @"shi";
        [self.contentView addSubview:_label4];
        
        
        self.line4 = [UIView new];
        self.line4.backgroundColor = KHexColor(@"#cccccc");
        [self.contentView addSubview:_line4];
        
        
        
        
        self.titleLabel5 = [TTTAttributedLabel new];                  ///5
        self.titleLabel5.textColor = KHexColor(@"#8c8c8c");
        self.titleLabel5.font = KFontSize(14);
        self.titleLabel5.text = @"联系电话";
        [self.contentView addSubview:_titleLabel5];
        
        
        self.label5 = [TTTAttributedLabel new];
        self.label5.textColor = KHexColor(@"#6f6f6f");
        self.label5.font = KFontSize(14);
        self.label5.text = @"shi";
        [self.contentView addSubview:_label5];
        
        
        self.line5 = [UIView new];
        self.line5.backgroundColor = KHexColor(@"#cccccc");
        [self.contentView addSubview:_line5];
        
        
        
        
        self.titleLabel6 = [TTTAttributedLabel new];                    ///6
        self.titleLabel6.textColor = KHexColor(@"#8c8c8c");
        self.titleLabel6.font = KFontSize(14);
        self.titleLabel6.text = @"入住时间";
        [self.contentView addSubview:_titleLabel6];
        
        
        self.label6 = [TTTAttributedLabel new];
        self.label6.textColor = KHexColor(@"#6f6f6f");
        self.label6.font = KFontSize(14);
        self.label6.text = @"shi";
        [self.contentView addSubview:_label6];
        
        
        self.line6 = [UIView new];
        self.line6.backgroundColor = KHexColor(@"#cccccc");
        [self.contentView addSubview:_line6];
        
        [_cellView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.equalTo(self.contentView.mas_top).offset(0);
             make.left.equalTo(self.contentView.mas_left).offset(7);
             make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
             make.right.equalTo(self.contentView.mas_right).offset(-7);
         }];

        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView.mas_top).offset(22.5);
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.width.equalTo(self.titleLabel.mas_width);
            make.height.equalTo(14);
            
        }];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.titleLabel.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_centerX).offset(-30);
            make.width.equalTo(self.label.mas_width);
            make.height.equalTo(14);
            
        }];
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.right.equalTo(self.contentView.mas_right).offset(-25);
            make.bottom.equalTo(self.contentView.mas_top).offset(45);
            make.height.equalTo(0.5);
        }];
        [_titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView.mas_top).offset(67.5);
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.width.equalTo(self.label2.mas_width);
            make.height.equalTo(14);
            
        }];
        [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.titleLabel2.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_centerX).offset(-30);
            make.width.equalTo(self.titleLabel2.mas_width);
            make.height.equalTo(14);
            
        }];
        
        [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.right.equalTo(self.contentView.mas_right).offset(-25);
            make.bottom.equalTo(self.contentView.mas_top).offset(90);
            make.height.equalTo(0.5);
        }];
        
        [_titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView.mas_top).offset(112.5);
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.width.equalTo(self.titleLabel3.mas_width);
            make.height.equalTo(14);
            
        }];
        [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.titleLabel3.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_centerX).offset(-30);
            make.width.equalTo(self.label3.mas_width);
            make.height.equalTo(14);
            
        }];
        
        [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.right.equalTo(self.contentView.mas_right).offset(-25);
            make.bottom.equalTo(self.contentView.mas_top).offset(135);
            make.height.equalTo(0.5);
        }];
        
        [_titleLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView.mas_top).offset(157.5);
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.width.equalTo(self.titleLabel4.mas_width);
            make.height.equalTo(14);
            
        }];
        [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.titleLabel4.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_centerX).offset(-30);
            make.width.equalTo(self.label4.mas_width);
            make.height.equalTo(14);
            
        }];
        
        [_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.right.equalTo(self.contentView.mas_right).offset(-25);
            make.bottom.equalTo(self.contentView.mas_top).offset(180);
            make.height.equalTo(0.5);
        }];
        
        [_titleLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView.mas_top).offset(202.5);
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.width.equalTo(self.titleLabel5.mas_width);
            make.height.equalTo(14);
            
        }];
        [_label5 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.titleLabel5.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_centerX).offset(-30);
            make.width.equalTo(self.label5.mas_width);
            make.height.equalTo(14);
            
        }];
        
        [_line5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.right.equalTo(self.contentView.mas_right).offset(-25);
            make.bottom.equalTo(self.contentView.mas_top).offset(225);
            make.height.equalTo(0.5);
        }];
        [_titleLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.contentView.mas_top).offset(247.5);
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.width.equalTo(self.titleLabel6.mas_width);
            make.height.equalTo(14);
            
        }];
        [_label6 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.titleLabel6.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_centerX).offset(-30);
            make.width.equalTo(self.label6.mas_width);
            make.height.equalTo(14);
            
        }];
        
        [_line6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.right.equalTo(self.contentView.mas_right).offset(-25);
            make.bottom.equalTo(self.contentView.mas_top).offset(270);
            make.height.equalTo(0.5);
        }];


    }
    return self;
}


@end

/*-----------------------------------------------------------------------V-------------------------------------------
@interface BigCustomCell : UITableViewCell
@end
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    YueZiCenterOrderDetaiLCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[YueZiCenterOrderDetaiLCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    NSArray *titleArray = @[@"月子中心名称",@"套餐名称",@"费用",@"姓名",@"联系电话",@"入住时间"];
    cell.titleLabel.text = titleArray[indexPath.row];
    return cell;
}
@end
*/
/*-----------------------------------------------------------------------C-------------------------------------------*/



#import "OrderDetailYueZiCenterVC.h"
#import "EvaluateViewController.h"
@interface OrderDetailYueZiCenterVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *sectionFooterView;
@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *pingJiaImage;
@property (nonatomic, strong) UIBarButtonItem *right;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) TTTAttributedLabel *label;
@end

@implementation OrderDetailYueZiCenterVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
        self.right = [[UIBarButtonItem alloc] initWithTitle:@"评价" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightClicked)];
        self.right.tintColor = KHexColor(@"#ffffff");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    NavigationBarTitleColor
    self.view.backgroundColor = KHexColor(@"#f3f3f3");
    self.menuController.panEnabel = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 270;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(7);
        make.left.bottom.right.equalTo(self.view);
        
        
    }];
    
    [self requestData];
    
}

#pragma mark ------------------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------


- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightClicked
{
    
    EvaluateViewController *VC = [EvaluateViewController new];
    VC.order_id = [[self.dataDic objectForKey:@"order_id"]stringValue];
    VC.entity_id = [[self.dataDic objectForKey:@"entity_id"] stringValue];
    VC.nanny_id = [[self.dataDic objectForKey:@"nanny_id"] stringValue];
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark -------------------------------------------------------------------------------UITableViewDatasource delegate----------------------------------
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return [self.status integerValue] == 1 ? 0.001 : 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    self.sectionFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 110)];//已评价
    self.cellView = [UIView new];
    self.cellView.layer.cornerRadius = 5;
    self.cellView.layer.masksToBounds = YES;
    self.cellView.layer.borderColor = KHexColor(@"#e6e6e6").CGColor;
    self.cellView.layer.borderWidth = 1;
    [self.sectionFooterView addSubview:_cellView];
    
    
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"#cccccc");
    [self.cellView addSubview:_line];
    
    self.titleLabel = [TTTAttributedLabel new];
    self.titleLabel.textColor = KHexColor(@"#ff3f62");
    self.titleLabel.font = KFontSize(14);
    self.titleLabel.text = @"已评价";
    [self.cellView addSubview:_titleLabel];
    
    
    self.label = [TTTAttributedLabel new];
    self.label.textColor = KHexColor(@"#2e2e2e");
    self.label.font = KFontSize(14);
    self.label.text = @"服务态度很棒";
    [self.cellView addSubview:_label];
    
    self.pingJiaImage = [UIImageView new];
    self.pingJiaImage.image = [UIImage imageNamed:@"evaluation3"];
    [self.cellView addSubview:_pingJiaImage];
    
    [_cellView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.sectionFooterView.mas_top).offset(10);
         make.left.equalTo(self.sectionFooterView.mas_left).offset(7);
         make.bottom.equalTo(self.sectionFooterView.mas_bottom).offset(0);
         make.right.equalTo(self.sectionFooterView.mas_right).offset(-7);
     }];
    
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cellView.mas_left).offset(25);
        make.right.equalTo(self.cellView.mas_right).offset(-25);
        make.bottom.equalTo(self.cellView.mas_bottom).offset(-45);
        make.height.equalTo(0.5);
    }];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.line.mas_centerY).offset(-22.5);
        make.left.equalTo(self.cellView.mas_left).offset(25);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(14);
        
    }];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.line.mas_centerY).offset(22.5);
        make.left.equalTo(self.titleLabel.mas_left).offset(0);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(14);
        
    }];
    
    [_pingJiaImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.label.mas_centerY).offset(0);
        make.right.equalTo(self.line.mas_right).offset(0);
        make.width.equalTo(20);
        make.height.equalTo(20);
        
    }];
    
    
    
    
    return _sectionFooterView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *bigIdentifier = @"bigCell";
    OrderDetailYueZiCenterCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:bigIdentifier];
    if (nil == cell) {
        cell = [[OrderDetailYueZiCenterCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:bigIdentifier];
    }
    if (self.dataDic) {
        cell.label.text = [self.dataDic objectForKey:@"entity_name"];
        if ([[self.dataDic objectForKey:@"package_name"] isEqualToString:@""]) {
            cell.label2.text = [self.dataDic objectForKey:@"nanny_name"];
        }
        if ([[self.dataDic objectForKey:@"nanny_name"] isEqualToString:@""]) {
            cell.label2.text = [self.dataDic objectForKey:@"package_name"];

        }
        cell.label3.text = [NSString stringWithFormat:@"%@元",[[self.dataDic objectForKey:@"totalPrice"]stringValue]];
        cell.label4.text = [self.dataDic objectForKey:@"user_name"];
        cell.label5.text = [self.dataDic objectForKey:@"mobile"];
        cell.label6.text = [NSString stringWithFormat:@"%@至%@",[self.dataDic objectForKey:@"startDateTime"],[self.dataDic objectForKey:@"endDateTime"]];
    }
    
    return cell;
}


#pragma mark ------------------------------------------------------------------------------ASURLConnection  -----------------------------------------------------------
- (void)requestData
{
    if ([self.order_id isValid])
    {
        [ASURLConnection requestAFNJSon:@{@"order_id":self.order_id} method:@"renhe.orderService.orderDetail" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
            
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                
                self.dataDic = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"][0];
                [self backData];
                [_tableView reloadData];
            }
        } errorBlock:^(NSError *error) {
        }];

    }
    
}

- (void)backData
{
    if ([[self.dataDic objectForKey:@"status"]integerValue] == 1) {
        self.navigationItem.rightBarButtonItem = self.right;//“status”:1//订单状态: 0未付款1未评价2已评价3已经退费
    }
}
@end




