//
//  ConsultOverChat.m
//  Mamabao
//
//  Created by Michael on 15/11/14.
//  Copyright © 2015年 Michael. All rights reserved.
//




/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface ConsultOverChatModel  : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *created_time;
@property (nonatomic, strong) NSString *file_url;
@property (nonatomic, strong) NSString *length;
@property (nonatomic, strong) NSString *talker;
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface ConsultOverChatModel ()

@end

@implementation ConsultOverChatModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([dic objectForKey:@"content"])
        {
            self.content = [dic objectForKey:@"content"];
        }

        
    }
    return self;
}

@end
/*-----------------------------------------------------------------------V----detail---------------------------------------*/
@interface RightDetailCellChat : UITableViewCell


@property (nonatomic, strong) ConsultOverChatModel *detail;

+ (CGFloat)heightForRowWithStringrightDetail:(NSString *)string;


@end



@interface RightDetailCellChat ()

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIImageView *rightImage;
@property (nonatomic, strong) UIImageView *iconRightImage;
@property (nonatomic, strong) TTTAttributedLabel *rightDetailLabel;
@end

@implementation RightDetailCellChat

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KHexColor(@"#f4f4f4");
        
        self.iconRightImage = [UIImageView new];
        self.iconRightImage.image = [UIImage imageNamed:@"replay2"];
        [self.contentView addSubview:_iconRightImage];
        
        
        self.rightImage = [UIImageView new];
        self.rightImage.image = [[UIImage imageNamed:@"chat_right"] stretchableImageWithLeftCapWidth:25 topCapHeight:30];
        [self.contentView addSubview:_rightImage];
        
        
        self.rightDetailLabel = [TTTAttributedLabel new];
        self.rightDetailLabel.textColor = KHexColor(@"#666666");
        self.rightDetailLabel.font = KFontSize(14);
        self.rightDetailLabel.numberOfLines = 0;
        self.rightDetailLabel.lineSpacing = 4;
        [self.contentView addSubview:_rightDetailLabel];
        
        
        [_iconRightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.width.equalTo(40);
            make.height.equalTo(40);
        }];
        
        
        [_rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.right.equalTo(self.iconRightImage.mas_left).offset(-10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        
        
        [_rightDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightImage.mas_top).offset(0);
            make.left.equalTo(self.rightImage.mas_left).offset(10);
            make.right.equalTo(self.rightImage.mas_right).offset(-10);
            make.bottom.equalTo(self.rightImage.mas_bottom).offset(0);
        }];
        
    }
    return self;
}

+(CGFloat)heightForRowWithStringrightDetail:(NSString *)string
{
    if (![string isValid]) {
        return 0;
    }
    
    CGFloat bottomSpace = 16;
    CGFloat stringHeight = [NSAttributedString contentHeightWithText:string width:CoreWidth-20 fontSize:14 lineSpacing:4];
    
    return bottomSpace + stringHeight + 20 +10;
}

- (void) setDetail:(ConsultOverChatModel *)detail
{
    if (nil == detail) {
        return;
    }
    self.rightDetailLabel.text = detail.content;
}
@end


/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "ConsultOverChat.h"

@interface ConsultOverChat ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSDictionary *detailDic;
@property (nonatomic, strong) NSMutableArray *detailArray;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) TTTAttributedLabel *nameLabel;
@property (nonatomic, strong) TTTAttributedLabel *hospitalLabel;
@property (nonatomic, strong) TTTAttributedLabel *keShiLabel;
@property (nonatomic, strong) TTTAttributedLabel *yiShiLabel;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) TTTAttributedLabel *consultOveredLabel;
@property (nonatomic, strong) UIButton *writePingjiaButton;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@end






@implementation ConsultOverChat


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"评价" style:UIBarButtonItemStylePlain target:self action:@selector(rightCLicked)];
        self.navigationItem.rightBarButtonItem = right;
        right.tintColor = KHexColor(@"#ffffff");
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"咨询记录";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.detailArray = [NSMutableArray array];
    [self makeHeaderUI];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(0);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    [self makeBottomUI];
    [self requestDetail];
}

#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------

- (void)sectionButtonClick
{
    
}
- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightCLicked
{
    
}

- (void)writePingjiaButtonClick
{
    
}
#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_detailArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    RightDetailCellChat *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[RightDetailCellChat alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.detail = _detailArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (void)requestDetail
{
    [ASURLConnection requestAFNJSon:@{@"problem_id":@10489} method:@"renh.consultant.getDetail" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            self.detailDic = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"][0];
            
            NSArray *dataArr = [self.detailDic objectForKey:@"contentInfo"];
            
            for (NSDictionary *dic in dataArr) {
                ConsultOverChatModel *model = [[ConsultOverChatModel alloc] initWithDictionary:dic];
                [_detailArray addObject:model];
            }
            
            NSLog(@"==============================%@",_detailArray);
            [_tableView reloadData];
            
        }
    } errorBlock:^(NSError *error) {
    }];
}
- (void)makeHeaderUI
{
    self.headerView = [UIView new];
    self.headerView.backgroundColor = KHexColor(@"#ffffff");
    [self.view addSubview:_headerView];
    
    
    
    self.headerImage = [UIImageView new];
    self.headerImage.image = [UIImage imageNamed:@"replay2"];
    [self.headerView addSubview:_headerImage];
    
    
    self.nameLabel = [TTTAttributedLabel new];
    self.nameLabel.font = KFontSize(15);
    self.nameLabel.textColor = KHexColor(@"#333333");
    self.nameLabel.text = @"王君安";
    [self.headerView addSubview:_nameLabel];
    
    
    self.hospitalLabel = [TTTAttributedLabel new];
    self.hospitalLabel.font = KFontSize(15);
    self.hospitalLabel.textColor = KHexColor(@"#666666");
    self.hospitalLabel.text = @"南山人民医院";
    [self.headerView addSubview:_hospitalLabel];
    
    
    self.keShiLabel = [TTTAttributedLabel new];
    self.keShiLabel.font = KFontSize(15);
    self.keShiLabel.textColor = KHexColor(@"#ff637e");
    self.keShiLabel.text = @"妇科";
    [self.headerView addSubview:_keShiLabel];
    
    
    self.yiShiLabel = [TTTAttributedLabel new];
    self.yiShiLabel.font = KFontSize(15);
    self.yiShiLabel.textColor = KHexColor(@"#ff637e");
    self.yiShiLabel.text = @"主任医师";
    [self.headerView addSubview:_yiShiLabel];
    
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"#ff637e");
    [self.headerView addSubview:_line];
    
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.right.equalTo(self.view);
        make.height.equalTo(60);
    }];
    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerView.mas_centerY).offset(0);
        make.left.equalTo(self.headerView.mas_left).offset(15);
        make.width.equalTo(41);
        make.height.equalTo(41);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImage.mas_top).offset(5);
        make.left.equalTo(self.headerImage.mas_right).offset(10);
        make.width.equalTo(self.nameLabel.mas_width);
        make.height.equalTo(15);
    }];
    [_hospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel.mas_centerY).offset(0);
        make.left.equalTo(self.nameLabel.mas_right).offset(15);
        make.width.equalTo(self.hospitalLabel.mas_width);
        make.height.equalTo(15);
    }];
    [_keShiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.nameLabel.mas_centerX).offset(0);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.width.equalTo(self.keShiLabel.mas_width);
        make.height.equalTo(15);
    }];
    [_yiShiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.keShiLabel.mas_centerY).offset(0);
        make.centerX.equalTo(self.hospitalLabel.mas_centerX).offset(0);
        make.width.equalTo(self.yiShiLabel.mas_width);
        make.height.equalTo(15);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(7.5);
        make.top.equalTo(self.keShiLabel.mas_top).offset(3);
        make.width.equalTo(1);
        make.height.equalTo(14);
        
    }];
    
    
}

- (void)makeBottomUI

{
    self.bottomView = [UIView new];
    self.bottomView.layer.borderWidth = 1;
    self.bottomView.layer.borderColor = KHexColor(@"#e6e6e6").CGColor;
    self.bottomView.backgroundColor = KHexColor(@"#ffffff");
    [self.view addSubview:_bottomView];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
        make.height.equalTo(100);
    }];
    
    self.consultOveredLabel = [TTTAttributedLabel new];
    self.consultOveredLabel.textColor = KHexColor(@"#9a9a9a");
    self.consultOveredLabel.font = KFontSize(14);
    self.consultOveredLabel.text = @"咨询已结束";
    [self.bottomView addSubview:_consultOveredLabel];
    
    [_consultOveredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top).offset(10);
        make.centerX.equalTo(self.bottomView.mas_centerX).offset(0);
        make.width.equalTo(self.consultOveredLabel.mas_width);
        make.height.equalTo(14);
        
    }];
    
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"#cccccc");
    [self.bottomView addSubview:_line];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left).offset(15);
        make.right.equalTo(self.bottomView.mas_right).offset(-15);
        make.top.equalTo(self.consultOveredLabel.mas_bottom).offset(10);
        make.height.equalTo(0.5);
        
    }];
    
    self.writePingjiaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.writePingjiaButton.titleLabel.font = KFontSize(14);
    [self.writePingjiaButton addTarget:self action:@selector(writePingjiaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.writePingjiaButton setTitle:@"给医生写下评价吧" forState:UIControlStateNormal];
    [self.writePingjiaButton setTitleColor:KHexColor(@"#fe637b") forState:UIControlStateNormal];
    [self.bottomView addSubview:_writePingjiaButton];
    
    [_writePingjiaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_top).offset(10);
        make.centerX.equalTo(self.bottomView.mas_centerX).offset(0);
        make.width.equalTo(self.writePingjiaButton.mas_width);
        make.height.equalTo(20);
    }];
    
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"#fe637b");
    [self.bottomView addSubview:_line];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.writePingjiaButton.mas_centerX).offset(0);
        make.top.equalTo(self.writePingjiaButton.mas_bottom).offset(1);
        make.width.equalTo(self.writePingjiaButton.mas_width);
        make.height.equalTo(0.5);
        
    }];
    
    
}

@end







