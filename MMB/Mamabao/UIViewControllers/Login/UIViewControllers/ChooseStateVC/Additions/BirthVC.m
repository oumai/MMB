
//
//  BirthVC.m
//  Mamabao
//
//  Created by Michael on 15/11/19.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import "BirthVC.h"

@interface BirthVC ()

@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) TTTAttributedLabel *titleBirthLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *finishButton;
@property (nonatomic, strong) NSArray *segmentedArray;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@end

@implementation BirthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KHexColor(@"#ffffff");
    
    self.titleLabel = [TTTAttributedLabel new];
    self.titleLabel.textColor = KHexColor(@"#ffffff");
    self.titleLabel.backgroundColor = KHexColor(@"#ff879a");
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"设置宝宝信息";
    [self.view addSubview:_titleLabel];
    
    
    
    self.sexString = @"男";
    self.segmentedArray = @[@"男",@"女"];
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:_segmentedArray];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],    UITextAttributeTextColor, [UIFont fontWithName:@"SnellRoundhand-Bold"size:14],UITextAttributeFont ,[UIColor whiteColor],UITextAttributeTextShadowColor ,nil];
    [self.segmentedControl setTitleTextAttributes:dic forState:UIControlStateNormal];   //字体颜色
    self.segmentedControl.selectedSegmentIndex = 0;                                     //设置默认选择项索引
    self.segmentedControl.tintColor = KHexColor(@"#ff8787");
    self.segmentedControl.backgroundColor= KHexColor(@"#ffbfc0");
    self.segmentedControl.layer.cornerRadius = 10;
    self.segmentedControl.layer.masksToBounds = YES;
    self.segmentedControl.layer.borderWidth = 1;
    self.segmentedControl.layer.borderColor = KHexColor(@"#ff8787").CGColor;
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;         //设置样式
    [self.segmentedControl addTarget:self action:@selector(segmentedControlClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
    
    
      
    self.titleBirthLabel = [TTTAttributedLabel new];
    self.titleBirthLabel.textColor = KHexColor(@"#444444");
    self.titleBirthLabel.font = KFontSize(14);
    self.titleBirthLabel.text = @"宝宝出生日期";
    [self.view addSubview:_titleBirthLabel];
    
    
      
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"#d9d9d9");
    [self.view addSubview:_line];
    
      

    self.datePicker = [UIDatePicker new];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.datePicker addTarget:self action:@selector(datePicker:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_datePicker];
    
      
    self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.finishButton.layer.cornerRadius = 5;
    self.finishButton.layer.masksToBounds = YES;
    [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.finishButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff879a")] forState:UIControlStateNormal];
    [self.finishButton addTarget:self action:@selector(finishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_finishButton];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(40);
    }];
    
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.equalTo(200);
        make.height.equalTo(40);
    }];
    
    [_titleBirthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(50);
        make.width.equalTo(self.titleBirthLabel.mas_width);
        make.height.equalTo(40);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleBirthLabel.mas_bottom).offset(5);
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
        make.height.equalTo(0.5);
    }];
    
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_bottom).offset(0);
        make.height.equalTo(100);
    }];
    
    [_finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.centerX.equalTo(self.view.centerX).offset(0);
        make.width.equalTo(100);
        make.height.equalTo(40);
    }];
    
}

- (void)datePicker:(UIDatePicker *)picker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.dateString = [formatter stringFromDate:picker.date];
}

- (void)segmentedControlClick:(UISegmentedControl *)seg
{
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            self.sexString = @"0";
            break;
        case 1:
            self.sexString = @"1";
            break;
        default:
            break;
    }
}
- (void)finishButtonClick:(UIButton *)button
{
    
    if (![self.dateString isValid]) {
        NSDateFormatter *date =[[NSDateFormatter alloc] init];              //当前时间
        [date setDateFormat:@"yyyy-MM-dd"];
        self.currentDate = [date stringFromDate:[NSDate date]];
        if (self.sureBlock) {
            self.sureBlock(self.currentDate);
        }
    }
    else
    {
        if (self.sureBlock) {
            self.sureBlock(self.dateString);
        }
    }
    
    if (self.dismissSimanPopoverViewController) {
        self.dismissSimanPopoverViewController(self);
    }
    
    
    if (self.birthVCFinishBlock) {
        self.birthVCFinishBlock(self);
    }
    
}

@end
