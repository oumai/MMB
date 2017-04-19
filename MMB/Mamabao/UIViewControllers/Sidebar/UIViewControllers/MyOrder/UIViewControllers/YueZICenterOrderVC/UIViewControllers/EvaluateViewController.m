//
//  EvaluateViewController.m
//  Mamabao
//
//  Created by Michael on 15/12/24.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import "EvaluateViewController.h"

@interface EvaluateViewController ()
@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *servicesCenterView;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) UITextView *serviceCenterTV;
@property (nonatomic, strong) UIImageView *goodImage;
@property (nonatomic, strong) UIImageView *mediumImage;
@property (nonatomic, strong) UIImageView *madImage;
@property (nonatomic, strong) UIButton *goodButton;
@property (nonatomic, strong) UIButton *mediumButton;
@property (nonatomic, strong) UIButton *madButton;



@property (nonatomic, strong) UIView *yueSaoView;
@property (nonatomic, strong) UIImageView *YSiconImage;
@property (nonatomic, strong) TTTAttributedLabel *YStitleLabel;
@property (nonatomic, strong) UITextView *YSserviceCenterTV;
@property (nonatomic, strong) UIImageView *YSgoodImage;
@property (nonatomic, strong) UIImageView *YSmediumImage;
@property (nonatomic, strong) UIImageView *YSmadImage;
@property (nonatomic, strong) UIButton *YSgoodButton;
@property (nonatomic, strong) UIButton *YSmediumButton;
@property (nonatomic, strong) UIButton *YSmadButton;

@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) NSString *entityGrade;
@property (nonatomic, strong) NSString *nannyGrade;
@end

@implementation EvaluateViewController
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价";
    self.user = [[ASUserInfoModel alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = KHexColor(@"#f5f5f5");
    [self.view addSubview:_tableView];
    [self makeservicesCenterView];
    
    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    self.submitButton.layer.cornerRadius = 5;
    self.submitButton.layer.masksToBounds = YES;
    [self.submitButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff92a5")] forState:UIControlStateNormal];
    [self.submitButton addTarget:self action:@selector(submitButtonClick ) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:_submitButton];
    
      

    
    if ([self.nanny_id intValue] == 0)
    {
        self.submitButton.frame = CGRectMake(50, 180+50, CoreWidth-100, 35);
        
    }
    else
    {
        
        self.submitButton.frame = CGRectMake(50, 180+50+180, CoreWidth-100, 35);
        [self makeYueSaoView];
    }
    
    
}

- (void)submitButtonClick
{

    if ([self.nanny_id intValue] == 0)
    {
        
        NSDictionary *centerJsonDic = @{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],
                                        @"order_id":self.order_id,
                                        @"entity_id":self.entity_id,
                                        @"entity_discuss":self.serviceCenterTV.text,
                                        @"entityGrade":self.entityGrade
                                        };
        [ASURLConnection requestAFNJSon:centerJsonDic method:@"renhe.orderService.orderDiscuss" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
            
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
            {
                k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
                [self performSelector:@selector(afterDelayClick) withObject:nil afterDelay:0.5];
                
            }
        } errorBlock:^(NSError *error) {
        }];
    }
    else
    {
        if ([self.order_id isValid]&&[self.entity_id isValid]&&[self.entityGrade isValid]&&[self.nannyGrade isValid]&&[self.nanny_id isValid]&&self.YSserviceCenterTV.text.length>0&self.serviceCenterTV.text.length>0) {
            
            NSDictionary *jsonDic = @{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],
                                      @"order_id":self.order_id,
                                      @"entity_id":self.entity_id,
                                      @"entity_discuss":self.serviceCenterTV.text,
                                      @"entityGrade":self.entityGrade,
                                      @"nanny_id":self.nanny_id,
                                      @"nanny_discuss":self.YSserviceCenterTV.text,
                                      @"nannyGrade":self.nannyGrade};
            [ASURLConnection requestAFNJSon:jsonDic method:@"renhe.orderService.orderDiscuss" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
                
                if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                    k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
                    [self performSelector:@selector(afterDelayClick) withObject:nil afterDelay:0.5];
                }
            } errorBlock:^(NSError *error) {
            }];
            
            
        }

    }
}
- (void)afterDelayClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)madButtonClick  //月子中心评价
{
    [self.madButton setTitleColor:KHexColor(@"#ff657f") forState:UIControlStateNormal];
    [self.mediumButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.goodButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    self.entityGrade = @"0";
}
- (void)mediumButtonClick {
    [self.madButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.mediumButton setTitleColor:KHexColor(@"#ff657f") forState:UIControlStateNormal];
    [self.goodButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    self.entityGrade = @"1";

}
- (void)goodButtonClick
{
    [self.madButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.mediumButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.goodButton setTitleColor:KHexColor(@"#ff657f") forState:UIControlStateNormal];
    self.entityGrade = @"2";
}
- (void)YSmadButtonClick  //月嫂评价
{
    [self.YSmadButton setTitleColor:KHexColor(@"#ff657f") forState:UIControlStateNormal];
    [self.YSmediumButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.YSgoodButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    self.nannyGrade = @"0";
    
}
- (void)YSmediumButtonClick {
    [self.YSmadButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.YSmediumButton setTitleColor:KHexColor(@"#ff657f") forState:UIControlStateNormal];
    [self.YSgoodButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    self.nannyGrade = @"1";

}
- (void)YSgoodButtonClick {
    [self.YSmadButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.YSmediumButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.YSgoodButton setTitleColor:KHexColor(@"#ff657f") forState:UIControlStateNormal];
    self.nannyGrade = @"2";
}

#pragma mark -------------------------------------------------------------------------------makeUI Top---------------------------------------------

- (void)makeservicesCenterView //月嫂评价
{
    self.servicesCenterView = [UIView new];
    self.servicesCenterView.backgroundColor = KHexColor(@"#ffffff");
    self.servicesCenterView.frame = CGRectMake(6, 6, CoreWidth-12, 180);
    self.servicesCenterView.layer.cornerRadius = 3;
    self.servicesCenterView.layer.masksToBounds = YES;
    self.servicesCenterView.layer.borderColor = KHexColor(@"#e6e6e6").CGColor;
    self.servicesCenterView.layer.borderWidth = 1;
    [self.tableView addSubview:_servicesCenterView];
    
    self.iconImage = [UIImageView new];
    self.iconImage.image = [UIImage imageNamed:@"order_of_7mine"];
    [self.servicesCenterView addSubview:_iconImage];
    
    
    self.titleLabel = [TTTAttributedLabel new];
    self.titleLabel.font = KFontSize(16);
    self.titleLabel.textColor = KHexColor(@"#333333");
    self.titleLabel.text = @"服务中心评价";
    [self.servicesCenterView addSubview:_titleLabel];
    
    
    self.serviceCenterTV = [UITextView new];
    self.serviceCenterTV.layer.cornerRadius = 5;
    self.serviceCenterTV.layer.masksToBounds = YES;
    self.serviceCenterTV.layer.borderColor = KHexColor(@"#cdcdcd").CGColor;
    self.serviceCenterTV.layer.borderWidth = 1;
    [self.servicesCenterView addSubview:_serviceCenterTV];
    
    
    self.madImage = [UIImageView new];
    self.madImage.image = [UIImage imageNamed:@"evaluation2"];
    [self.servicesCenterView addSubview:_madImage];
    
    
    self.madButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.madButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    self.madButton.titleLabel.font = KFontSize(12);
    [self.madButton setTitle:@"不满意" forState:UIControlStateNormal];
    [self.madButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.madButton addTarget:self action:@selector(madButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.servicesCenterView addSubview:_madButton];
    
    
    self.mediumImage = [UIImageView new];
    self.mediumImage.image = [UIImage imageNamed:@"evaluation"];
    [self.servicesCenterView addSubview:_mediumImage];
    
    
    self.mediumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mediumButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    self.mediumButton.titleLabel.font = KFontSize(12);
    [self.mediumButton setTitle:@"满意" forState:UIControlStateNormal];
    [self.mediumButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.mediumButton addTarget:self action:@selector(mediumButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.servicesCenterView addSubview:_mediumButton];
    
    
    self.goodImage = [UIImageView new];
    self.goodImage.image = [UIImage imageNamed:@"evaluation"];
    [self.servicesCenterView addSubview:_goodImage];
    
    self.entityGrade = @"2";
    self.goodButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.goodButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    self.goodButton.titleLabel.font = KFontSize(12);
    [self.goodButton setTitle:@"很满意" forState:UIControlStateNormal];
    [self.goodButton setTitleColor:KHexColor(@"#ff657f") forState:UIControlStateNormal];
    [self.goodButton addTarget:self action:@selector(goodButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.servicesCenterView addSubview:_goodButton];
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.servicesCenterView).offset(7);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.servicesCenterView.mas_top).offset(7);
        make.left.equalTo(self.iconImage.mas_right).offset(10);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(16);
    }];
    
    [_serviceCenterTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImage.mas_bottom).offset(10);
        make.left.equalTo(self.servicesCenterView.mas_left).offset(8);
        make.right.equalTo(self.servicesCenterView.mas_right).offset(-8);
        make.height.equalTo(80);
    }];
    [_madImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceCenterTV.mas_bottom).offset(7);
        make.right.equalTo(self.servicesCenterView.mas_right).offset(-10);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    [_madButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.madImage.mas_top).offset(0);
        make.centerX.equalTo(self.madImage.mas_centerX).offset(0);
        make.width.equalTo(40);
        make.height.equalTo(45);
    }];
    [_mediumImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceCenterTV.mas_bottom).offset(7);
        make.right.equalTo(self.madImage.mas_left).offset(-30);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    [_mediumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mediumImage.mas_top).offset(0);
        make.centerX.equalTo(self.mediumImage.mas_centerX).offset(0);
        make.width.equalTo(40);
        make.height.equalTo(45);
    }];
    [_goodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceCenterTV.mas_bottom).offset(7);
        make.right.equalTo(self.mediumImage.mas_left).offset(-30);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    [_goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodImage.mas_top).offset(0);
        make.centerX.equalTo(self.goodImage.mas_centerX).offset(0);
        make.width.equalTo(40);
        make.height.equalTo(45);
    }];
    
    
}
#pragma mark -------------------------------------------------------------------------------makeUI BOTTOM---------------------------------------------
- (void)makeYueSaoView
{
    self.yueSaoView = [UIView new];
    self.yueSaoView.backgroundColor = KHexColor(@"#ffffff");
    self.yueSaoView.frame = CGRectMake(6, 196, CoreWidth-12, 180);
    self.yueSaoView.layer.cornerRadius = 3;
    self.yueSaoView.layer.masksToBounds = YES;
    self.yueSaoView.layer.borderColor = KHexColor(@"#e6e6e6").CGColor;
    self.yueSaoView.layer.borderWidth = 1;
    [self.tableView addSubview:_yueSaoView];
    
//    [_yueSaoView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.servicesCenterView.mas_bottom).offset(10);
//        make.left.equalTo(self.tableView.mas_left).offset(6);
//        make.right.equalTo(self.tableView.mas_right).offset(-6);
//        make.height.equalTo(180);
//    }];
    
    self.YSiconImage = [UIImageView new];
    self.YSiconImage.image = [UIImage imageNamed:@"order_of_8mine"];
    [self.yueSaoView addSubview:_YSiconImage];
    
    
    self.YStitleLabel = [TTTAttributedLabel new];
    self.YStitleLabel.font = KFontSize(16);
    self.YStitleLabel.textColor = KHexColor(@"#333333");
    self.YStitleLabel.text = @"月嫂评价";
    [self.yueSaoView addSubview:_YStitleLabel];
    
    
    self.YSserviceCenterTV = [UITextView new];
    self.YSserviceCenterTV.layer.cornerRadius = 5;
    self.YSserviceCenterTV.layer.masksToBounds = YES;
    self.YSserviceCenterTV.layer.borderColor = KHexColor(@"#cdcdcd").CGColor;
    self.YSserviceCenterTV.layer.borderWidth = 1;
    [self.yueSaoView addSubview:_YSserviceCenterTV];
    
    
    
    self.YSmadImage = [UIImageView new];
    self.YSmadImage.image = [UIImage imageNamed:@"evaluation2"];
    [self.yueSaoView addSubview:_YSmadImage];
    
    
    self.YSmadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.YSmadButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    self.YSmadButton.titleLabel.font = KFontSize(12);
    [self.YSmadButton setTitle:@"不满意" forState:UIControlStateNormal];
    [self.YSmadButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.YSmadButton addTarget:self action:@selector(YSmadButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.yueSaoView addSubview:_YSmadButton];
    
    
    self.YSmediumImage = [UIImageView new];
    self.YSmediumImage.image = [UIImage imageNamed:@"evaluation"];
    [self.yueSaoView addSubview:_YSmediumImage];
    
    
    self.YSmediumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.YSmediumButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    self.YSmediumButton.titleLabel.font = KFontSize(12);
    [self.YSmediumButton setTitle:@"满意" forState:UIControlStateNormal];
    [self.YSmediumButton setTitleColor:KHexColor(@"#666666") forState:UIControlStateNormal];
    [self.YSmediumButton addTarget:self action:@selector(YSmediumButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.yueSaoView addSubview:_YSmediumButton];
    
    
    
    
    self.YSgoodImage = [UIImageView new];
    self.YSgoodImage.image = [UIImage imageNamed:@"evaluation"];
    [self.yueSaoView addSubview:_YSgoodImage];
    
    
    self.nannyGrade = @"2";
    self.YSgoodButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.YSgoodButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    self.YSgoodButton.titleLabel.font = KFontSize(12);
    [self.YSgoodButton setTitle:@"很满意" forState:UIControlStateNormal];
    [self.YSgoodButton setTitleColor:KHexColor(@"#ff657f") forState:UIControlStateNormal];
    [self.YSgoodButton addTarget:self action:@selector(YSgoodButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.yueSaoView addSubview:_YSgoodButton];
    
  
    
    [_YSiconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.yueSaoView).offset(7);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    [_YStitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.yueSaoView.mas_top).offset(7);
        make.left.equalTo(self.YSiconImage.mas_right).offset(10);
        make.width.equalTo(self.YStitleLabel.mas_width);
        make.height.equalTo(16);
    }];
    
    [_YSserviceCenterTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.YSiconImage.mas_bottom).offset(10);
        make.left.equalTo(self.yueSaoView.mas_left).offset(8);
        make.right.equalTo(self.yueSaoView.mas_right).offset(-8);
        make.height.equalTo(80);
    }];
    [_YSmadImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.YSserviceCenterTV.mas_bottom).offset(7);
        make.right.equalTo(self.yueSaoView.mas_right).offset(-10);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    [_YSmadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.YSmadImage.mas_top).offset(0);
        make.centerX.equalTo(self.YSmadImage.mas_centerX).offset(0);
        make.width.equalTo(40);
        make.height.equalTo(45);
    }];
    [_YSmediumImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.YSserviceCenterTV.mas_bottom).offset(7);
        make.right.equalTo(self.YSmadImage.mas_left).offset(-30);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    [_YSmediumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.YSmediumImage.mas_top).offset(0);
        make.centerX.equalTo(self.YSmediumImage.mas_centerX).offset(0);
        make.width.equalTo(40);
        make.height.equalTo(45);
    }];
    [_YSgoodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.YSserviceCenterTV.mas_bottom).offset(7);
        make.right.equalTo(self.YSmediumImage.mas_left).offset(-30);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    [_YSgoodButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.YSgoodImage.mas_top).offset(0);
        make.centerX.equalTo(self.YSgoodImage.mas_centerX).offset(0);
        make.width.equalTo(40);
        make.height.equalTo(45);
    }];
    
  }
@end
