//
//  YSPayOrderVC.m
//  Mamabao
//
//  Created by Michael on 15/12/21.
//  Copyright © 2015年 Michael. All rights reserved.
//


//
//  PayOrderVC.m
//  Mamabao
//
//  Created by Michael on 15/12/14.
//  Copyright © 2015年 Michael. All rights reserved.
//


/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface YSPayOrderModel  : NSObject
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface YSPayOrderModel ()

@end

@implementation YSPayOrderModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/
@interface YSPayOrderCustomCell : UITableViewCell


@end

@interface YSPayOrderCustomCell ()
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *line3;
@property (nonatomic, strong) UIView *line4;
@property (nonatomic, strong) UIView *line5;
@property (nonatomic, strong) UIView *line6;
@property (nonatomic, strong) UIView *line7;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel2;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel3;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel4;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel5;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel6;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel7;
@property (nonatomic, strong) TTTAttributedLabel *label;
@property (nonatomic, strong) TTTAttributedLabel *label2;
@property (nonatomic, strong) TTTAttributedLabel *label3;
@property (nonatomic, strong) TTTAttributedLabel *label4;
@property (nonatomic, strong) TTTAttributedLabel *label5;
@property (nonatomic, strong) TTTAttributedLabel *label6;
@property (nonatomic, strong) TTTAttributedLabel *label7;


@end

@implementation YSPayOrderCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#ecebec");
        [self.contentView addSubview:_line];
        
        self.titleLabel = [TTTAttributedLabel new];
        self.titleLabel.font = KFontSize(14);
        self.titleLabel.textColor = KHexColor(@"#949394");
        self.titleLabel.text = @"服务会所";
        [self.contentView addSubview:_titleLabel];
        
        self.label = [TTTAttributedLabel new];
        self.label.font = KFontSize(14);
        self.label.textColor = KHexColor(@"#313131");
        [self.contentView addSubview:_label];
        
             
        
        self.line2 = [UIView new];                                          ///2
        self.line2.backgroundColor = KHexColor(@"#ecebec");
        [self.contentView addSubview:_line2];
        
        self.titleLabel2 = [TTTAttributedLabel new];
        self.titleLabel2.font = KFontSize(14);
        self.titleLabel2.textColor = KHexColor(@"#949394");
        self.titleLabel2.text = @"购买内容";
        [self.contentView addSubview:_titleLabel2];
        
        self.label2 = [TTTAttributedLabel new];
        self.label2.font = KFontSize(14);
        self.label2.textColor = KHexColor(@"#313131");
        [self.contentView addSubview:_label2];
        
              
        
        self.line3 = [UIView new];                                          ///3
        self.line3.backgroundColor = KHexColor(@"#ecebec");
        [self.contentView addSubview:_line3];
        
        self.titleLabel3 = [TTTAttributedLabel new];
        self.titleLabel3.font = KFontSize(14);
        self.titleLabel3.textColor = KHexColor(@"#949394");
        self.titleLabel3.text = @"服务费用";
        [self.contentView addSubview:_titleLabel3];
        
        self.label3 = [TTTAttributedLabel new];
        self.label3.font = KFontSize(14);
        self.label3.textColor = KHexColor(@"#313131");
        [self.contentView addSubview:_label3];
        
              
        
        self.line4 = [UIView new];                                           ///4
        self.line4.backgroundColor = KHexColor(@"#ecebec");
        [self.contentView addSubview:_line4];
        
        self.titleLabel4 = [TTTAttributedLabel new];
        self.titleLabel4.font = KFontSize(14);
        self.titleLabel4.textColor = KHexColor(@"#949394");
        self.titleLabel4.text = @"姓名";
        [self.contentView addSubview:_titleLabel4];
        
        self.label4 = [TTTAttributedLabel new];
        self.label4.font = KFontSize(14);
        self.label4.textColor = KHexColor(@"#313131");
        [self.contentView addSubview:_label4];
        
              
        
        
        self.line5 = [UIView new];                                               ///5
        self.line5.backgroundColor = KHexColor(@"#ecebec");
        [self.contentView addSubview:_line5];
        
        self.titleLabel5 = [TTTAttributedLabel new];
        self.titleLabel5.font = KFontSize(14);
        self.titleLabel5.textColor = KHexColor(@"#949394");
        self.titleLabel5.text = @"地址";
        [self.contentView addSubview:_titleLabel5];
        
        self.label5 = [TTTAttributedLabel new];
        self.label5.font = KFontSize(14);
        self.label5.textColor = KHexColor(@"#313131");
        [self.contentView addSubview:_label5];
        
             
        
        self.line6 = [UIView new];                                               ///6
        self.line6.backgroundColor = KHexColor(@"#ecebec");
        [self.contentView addSubview:_line6];
        
        self.titleLabel6 = [TTTAttributedLabel new];
        self.titleLabel6.font = KFontSize(14);
        self.titleLabel6.textColor = KHexColor(@"#949394");
        self.titleLabel6.text = @"联系电话";
        [self.contentView addSubview:_titleLabel6];
        
        self.label6 = [TTTAttributedLabel new];
        self.label6.font = KFontSize(14);
        self.label6.textColor = KHexColor(@"#313131");
        [self.contentView addSubview:_label6];
        
        
        
        self.line7 = [UIView new];                                                ///7
        self.line7.backgroundColor = KHexColor(@"#ecebec");
        [self.contentView addSubview:_line7];
        
        self.titleLabel7 = [TTTAttributedLabel new];
        self.titleLabel7.font = KFontSize(14);
        self.titleLabel7.textColor = KHexColor(@"#949394");
        self.titleLabel7.text = @"服务时间";
        [self.contentView addSubview:_titleLabel7];
        
        self.label7 = [TTTAttributedLabel new];
        self.label7.font = KFontSize(14);
        self.label7.textColor = KHexColor(@"#313131");
        [self.contentView addSubview:_label7];
        
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(40);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(1);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.line.mas_centerY).offset(-20);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.width.equalTo(self.titleLabel.mas_width);
            make.height.equalTo(14);
        }];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.left.equalTo(self.contentView.mas_left).offset(150);
            make.width.equalTo(self.label.mas_width);
            make.height.equalTo(14);
        }];
        [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(40*2);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(1);
        }];
        
        [_titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.line2.mas_centerY).offset(-20);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.width.equalTo(self.titleLabel2.mas_width);
            make.height.equalTo(14);
        }];
        
        [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel2);
            make.left.equalTo(self.contentView.mas_left).offset(150);
            make.width.equalTo(self.label2.mas_width);
            make.height.equalTo(14);
        }];
        
        [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(40*3);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(1);
        }];
        
        [_titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.line3.mas_centerY).offset(-20);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.width.equalTo(self.titleLabel3.mas_width);
            make.height.equalTo(14);
        }];
        
        [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel3);
            make.left.equalTo(self.contentView.mas_left).offset(150);
            make.width.equalTo(self.label3.mas_width);
            make.height.equalTo(14);
        }];
        [_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(40*4);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(1);
        }];
        
        [_titleLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.line4.mas_centerY).offset(-20);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.width.equalTo(self.titleLabel4.mas_width);
            make.height.equalTo(14);
        }];
        
        [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel4);
            make.left.equalTo(self.contentView.mas_left).offset(150);
            make.width.equalTo(self.label4.mas_width);
            make.height.equalTo(14);
        }];
        [_line5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(40*5);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(1);
        }];
        
        [_titleLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.line5.mas_centerY).offset(-20);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.width.equalTo(self.titleLabel.mas_width);
            make.height.equalTo(14);
        }];
        
        [_label5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel5);
            make.left.equalTo(self.contentView.mas_left).offset(150);
            make.width.equalTo(self.label5.mas_width);
            make.height.equalTo(14);
        }];
        [_line6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(40*6);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(1);
        }];
        
        [_titleLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.line6.mas_centerY).offset(-20);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.width.equalTo(self.titleLabel6.mas_width);
            make.height.equalTo(14);
        }];
        
        [_label6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel6);
            make.left.equalTo(self.contentView.mas_left).offset(150);
            make.width.equalTo(self.label6.mas_width);
            make.height.equalTo(14);
        }];
        [_line7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(40*7);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(1);
        }];
        
        [_titleLabel7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.line7.mas_centerY).offset(-20);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.width.equalTo(self.titleLabel7.mas_width);
            make.height.equalTo(14);
        }];
        
        [_label7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel7);
            make.left.equalTo(self.contentView.mas_left).offset(150);
            make.width.equalTo(self.label7.mas_width);
            make.height.equalTo(14);
        }];
        
        
    }
    return self;
}





@end

/*-----------------------------------------------------------------------V-------------------------------------------*/
@interface YSPayOrderCell : UITableViewCell


@end

@interface YSPayOrderCell ()
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UIImageView *circleImage;
@property (nonatomic, strong) UIImageView *cherkImage;
@property (nonatomic, strong) TTTAttributedLabel *label;
@property (nonatomic, strong) TTTAttributedLabel *detailLabel;
@property (nonatomic, strong) TTTAttributedLabel *reduceLabel;
@end

@implementation YSPayOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#ecebec");
        [self.contentView addSubview:_line];
        
        self.iconImage = [UIImageView new];
        [self.contentView addSubview:_iconImage];
        
        
        
        self.circleImage = [UIImageView new];
        self.circleImage.image = [UIImage imageNamed:@"notchoice"];
        [self.contentView addSubview:_circleImage];
        
        
        
        self.cherkImage = [UIImageView new];
        [self.contentView addSubview:_cherkImage];
        
        
        
        self.label = [TTTAttributedLabel new];
        self.label.font = KFontSize(14);
        self.label.textColor = KHexColor(@"#313131");
        [self.contentView addSubview:_label];
        
        
        self.reduceLabel = [TTTAttributedLabel new];
        self.reduceLabel.layer.cornerRadius = 3;
        self.reduceLabel.layer.masksToBounds = YES;
        self.reduceLabel.layer.borderColor = KHexColor(@"#ff8d24").CGColor;
        self.reduceLabel.layer.borderWidth = 1;
        self.reduceLabel.textAlignment = NSTextAlignmentCenter;
        self.reduceLabel.font = KFontSize(12);
        self.reduceLabel.textColor = KHexColor(@"#ff8d24");
        self.reduceLabel.text = @"立减2元";
        [self.contentView addSubview:_reduceLabel];
        
        
        self.detailLabel = [TTTAttributedLabel new];
        self.detailLabel.font = KFontSize(12);
        self.detailLabel.textColor = KHexColor(@"#949394");
        [self.contentView addSubview:_detailLabel];
        
        
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.width.equalTo(48);
            make.height.equalTo(41);
        }];
        [_circleImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.width.equalTo(18);
            make.height.equalTo(18);
        }];
        [_cherkImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.width.equalTo(18);
            make.height.equalTo(18);
        }];
        
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(1);
        }];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImage.mas_top).offset(0);
            make.left.equalTo(self.iconImage.mas_right).offset(5);
            make.width.equalTo(self.label.mas_width);
            make.height.equalTo(14);
        }];
        
        [_reduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.iconImage.mas_bottom).offset(-4);
            make.left.equalTo(self.iconImage.mas_right).offset(10);
            make.width.equalTo(55);
            make.height.equalTo(18);
        }];
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.reduceLabel.mas_centerY).offset(0);
            make.left.equalTo(self.reduceLabel.mas_right).offset(10);
            make.width.equalTo(self.detailLabel.mas_width);
            make.height.equalTo(14);
        }];
        
    }
    return self;
}





@end


/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "YSPayOrderVC.h"
#import "FDAlertView.h"
#import "ASPay.h"

@interface YSPayOrderVC ()<UITableViewDataSource,UITableViewDelegate,FDAlertViewDelegate,ASPayDelegate>
@property (nonatomic, strong) NSDictionary *payDic;
@property (nonatomic, strong) NSDictionary *orderDic;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *sectionLine;
@property (nonatomic, strong) TTTAttributedLabel *sectionLabel;
@property (nonatomic, strong) TTTAttributedLabel *sectionTitleLabel;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *surePayButton;
@property (nonatomic, assign) NSInteger selectedRow;  //选中的这一行

@property (nonatomic, strong) ASPay *pay;             //支付宝
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, assign) BOOL isZhiFuBao;
@property (nonatomic, strong) NSString *order_number;
@property (nonatomic, strong) NSString *orderProject;

@end

@implementation YSPayOrderVC

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
    self.title = @"支付订单";
    NavigationBarTitleColor
    self.isZhiFuBao = YES;
    self.pay = [[ASPay alloc] init];
    self.menuController.panEnabel = NO;
    self.labelArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 40;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [self makeFooterView];
    [self requestData];
}

- (void)makeFooterView
{
    
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 100)];
    self.tableView.tableFooterView = self.footerView;
    self.surePayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.surePayButton.layer.cornerRadius = 5;
    self.surePayButton.layer.masksToBounds = YES;
    [self.surePayButton setTitle:@"确认支付" forState:UIControlStateNormal];
    [self.surePayButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.surePayButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff879a")] forState:UIControlStateNormal];
    [self.surePayButton addTarget:self action:@selector(surePayButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:_surePayButton];
    
    [_surePayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.footerView.mas_centerX).offset(0);
        make.top.equalTo(self.footerView.mas_top).offset(10);
        make.width.equalTo(250);
        make.height.equalTo(40);
    }];
    
}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------

- (void)surePayButtonClick
{
    FDAlertView *alert = [[FDAlertView alloc] initWithTitle:[NSString stringWithFormat:@"稍后您可在“我的订单”中完成支付"]  icon:nil message:@"" delegate:self buttonTitles:@"取消", @"继续支付", nil];
    [alert setMessageColor:KHexColor(@"#ff6e86") fontSize:0];
    [alert setButtonTitleColor:KHexColor(@"#1b1b1b") fontSize:0 atIndex:0];
    [alert setButtonTitleColor:KHexColor(@"#ff6e86") fontSize:0 atIndex:1];
    [alert show];

}

- (void)alertView:(FDAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
    }
    if (buttonIndex == 1) {
        [ASURLConnection requestAFNJSon:@{@"pay_type":@1} method:@"jumper.shop.getpayparams" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
            
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                
                self.payDic = [[[[ASURLConnection doDESDecryptWithZhifubao:responseObject]objectFromJSONString]objectForKey:@"data"] objectAtIndex:0];
                [self.pay zhiFuBao:self.payDic andOrderId:self.order_number andOrderProject:self.orderProject andPrice:self.totalPrice];
            }
            else
            {
                
            }
        } errorBlock:^(NSError *error) {
        }];

    }
}
- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma ----------------------------------------------------------------------ASPayDelegate---------------------------------------------------
-(void)zhifubaoAction{
    
}
-(void)weChatAction{
    
}
#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0 == section ? 0 : 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionAll = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 60)];
    sectionAll.backgroundColor = KHexColor(@"#eeedee");
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, CoreWidth, 40)];
    sectionView.backgroundColor = KHexColor(@"#ffffff");
    [sectionAll addSubview:sectionView];
    
    self.sectionTitleLabel = [TTTAttributedLabel new];
    self.sectionTitleLabel.textColor = KHexColor(@"#303030");
    self.sectionTitleLabel.font = KFontSize(14);
    self.sectionTitleLabel.text = @"还需付款:";
    [sectionView addSubview:_sectionTitleLabel];
    
    
    self.sectionLabel = [TTTAttributedLabel new];
    self.sectionLabel.textColor = KHexColor(@"#ff003e");
    self.sectionLabel.font = KFontSize(14);
    self.sectionLabel.text = [[self.orderDic objectForKey:@"totalPrice"] stringValue];
    [sectionView addSubview:_sectionLabel];
    
    self.sectionLine = [UIView new];
    self.sectionLine.backgroundColor = KHexColor(@"#ecebec");
    [sectionView addSubview:_sectionLine];
    
    
    [_sectionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sectionView.mas_centerY).offset(0);
        make.left.equalTo(sectionView.mas_left).offset(10);
        make.width.equalTo(self.sectionTitleLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    
    [_sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sectionView.mas_centerY).offset(0);
        make.left.equalTo(self.sectionTitleLabel.mas_right).offset(10);
        make.width.equalTo(self.sectionLabel.mas_width);
        make.height.equalTo(14);
    }];
    [_sectionLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(sectionView.mas_bottom).offset(0);
        make.left.right.equalTo(sectionView);
        make.height.equalTo(1);
    }];
    
    return sectionAll;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1 : 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ? 280 : 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"cell";
        YSPayOrderCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (nil == cell)
        {
            cell = [[YSPayOrderCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        }
        NSArray *titleArray = @[@"服务会所",@"购买内容",@"服务费用",@"姓名",@"联系电话",@"地址",@"服务时间"];
        cell.titleLabel.text = titleArray[indexPath.row];
        NSString *entity_name = [self.orderDic objectForKey:@"entity_name"];
        NSString *package_name = [self.orderDic objectForKey:@"nanny_name"];
        NSString *totalPrice = [[self.orderDic objectForKey:@"totalPrice"] stringValue];
        NSString *user_name = [self.orderDic objectForKey:@"user_name"];
        NSString *mobile = [self.orderDic objectForKey:@"mobile"];
        NSString *address = [self.orderDic objectForKey:@"address"];
        NSString *startDateTime = [self.orderDic objectForKey:@"startDateTime"];
        NSString *endDateTime = [self.orderDic objectForKey:@"endDateTime"];
        cell.label.text =entity_name;
        cell.label2.text = package_name;
        cell.label3.text = totalPrice;
        cell.label4.text = user_name;
        cell.label5.text = address;
        cell.label6.text = mobile;
        cell.label7.text = [NSString stringWithFormat:@"%@至%@",startDateTime,endDateTime];
        return cell;
        
    }
    else
    {
        static NSString *identifier = @"cellP";
        YSPayOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (nil == cell)
        {
            cell = [[YSPayOrderCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        }
        NSArray *iconArray = @[@"unionpay",@"wechat",@"alipay"];
        NSArray *labeArray = @[@"银联支付",@"微信支付",@"支付宝支付"];
        NSArray *detaiArra = @[@"支持储蓄卡信用卡...",@"推荐安装微信5.0以上版本...",@"推荐安装支付宝5.0以上版本..."];
        cell.iconImage.image = [UIImage imageNamed:iconArray[indexPath.row]];
        cell.label.text = labeArray[indexPath.row];
        cell.detailLabel.text = detaiArra[indexPath.row];
        
        if (indexPath.row == _selectedRow) {
            cell.cherkImage.image = [UIImage imageNamed:@"choiceC"];
        }
        else{
            cell.cherkImage.image = [UIImage imageNamed:@""];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        _selectedRow = indexPath.row;
        [_tableView reloadData];
    }
}
#pragma mark ---------------------------------------------------------------------ASURLConnection-----------------------------------------------------------

- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{@"order_id":self.order_id} method:@"renhe.orderService.orderDetail" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            self.orderDic = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"][0];
            self.order_number = [self.orderDic objectForKey:@"order_id"];
            self.totalPrice = [[self.orderDic objectForKey:@"totalPrice"] stringValue];
            self.orderProject = [NSString stringWithFormat:@"%@-%@",[self.orderDic objectForKey:@"entity_name"],[self.orderDic objectForKey:@"nanny_name"]];
            [_tableView reloadData];
        }
    } errorBlock:^(NSError *error) {
        
    }];
    
}
@end
