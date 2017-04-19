//
//  PregnancyVC.m
//  Mamabao
//
//  Created by Michael on 15/11/19.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import "PregnancyVC.h"

@interface PregnancyVC ()<UITextFieldDelegate>

@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *line3;
@property (nonatomic, strong) TTTAttributedLabel *endYuejingLabel;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UITextField *endYuejingTF;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *finishButton;
@property (nonatomic, strong) UIDatePicker *datePicker2;
@property (nonatomic, strong) UIButton *finishButton2;
@property (nonatomic, strong) UIView *calculatorView;
@property (nonatomic, strong) UIView *chooseView;
@end

@implementation PregnancyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KHexColor(@"#ffffff");
    self.view.frame = CGRectMake(0, 0, CoreWidth-20, 100);
    self.currentIdentity = @"0";
    self.titleLabel = [TTTAttributedLabel new];
    self.titleLabel.textColor = KHexColor(@"#ffffff");
    self.titleLabel.backgroundColor = KHexColor(@"#ff879a");
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"设置预产期";
    [self.view addSubview:_titleLabel];
    
    
    
    NSArray *segmentedArray = @[@"选择预产期",@"计算预产期"];
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],
                         UITextAttributeTextColor, [UIFont fontWithName:@"SnellRoundhand-Bold"size:14],
                         UITextAttributeFont ,[UIColor whiteColor],UITextAttributeTextShadowColor ,nil];
    [self.segmentedControl setTitleTextAttributes:dic forState:UIControlStateNormal];//字体颜色
    self.segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    self.segmentedControl.tintColor = KHexColor(@"#ff879a");
    self.segmentedControl.backgroundColor= KHexColor(@"#ffffff");
    self.segmentedControl.layer.cornerRadius = 10;
    self.segmentedControl.layer.masksToBounds = YES;
    self.segmentedControl.layer.borderWidth = 1;
    self.segmentedControl.layer.borderColor = KHexColor(@"#d9d9d9").CGColor;
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;//设置样式
    [self.segmentedControl addTarget:self action:@selector(pregnancyClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(40);
    }];
    
    
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.equalTo(280);
        make.height.equalTo(40);
    }];
    
    [self chooseMakeUI];
   
}


- (void)chooseMakeUI //选择预产期
{
    self.chooseView = [UIView new];
    self.chooseView.backgroundColor = KHexColor(@"#ffffff");
    [self.view addSubview:_chooseView];
    
    
    self.datePicker2 = [UIDatePicker new];
    self.datePicker2.datePickerMode = UIDatePickerModeDate;
    [self.datePicker2 addTarget:self action:@selector(datePicker2:) forControlEvents:UIControlEventValueChanged];
    [self.chooseView addSubview:_datePicker2];
    
    
    self.finishButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.finishButton.backgroundColor = [UIColor redColor];
    self.finishButton2.layer.cornerRadius = 5;
    self.finishButton2.layer.masksToBounds = YES;
    [self.finishButton2 setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishButton2 setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.finishButton2 setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff879a")] forState:UIControlStateNormal];
    [self.finishButton2 addTarget:self action:@selector(finishButton2Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.chooseView addSubview:_finishButton2];
    
    [_chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedControl.mas_bottom).offset(5);
        make.left.right.equalTo(self.view);
        make.height.equalTo(200);
    }];

    
    [_datePicker2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chooseView.mas_top).offset(10);
        make.left.equalTo(self.chooseView.mas_left).offset(0);
        make.right.equalTo(self.chooseView.mas_right).offset(0);
        make.height.equalTo(100);
    }];
    
    
    [_finishButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.datePicker2.mas_bottom).offset(10);
        make.centerX.equalTo(self.chooseView.centerX).offset(0);
        make.width.equalTo(100);
        make.height.equalTo(40);
    }];

}


- (void)calculateMakeUI   //计算预产期
{
    
    self.calculatorView = [UIView new];
    self.calculatorView.backgroundColor = KHexColor(@"#ffffff");
    [self.view addSubview:_calculatorView];
    
    [_calculatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedControl.mas_bottom).offset(5);
        make.left.right.equalTo(self.view);
        make.height.equalTo(280);
    }];
    
    self.line2 = [UIView new];
    self.line2.backgroundColor = KHexColor(@"#d9d9d9");
    [self.calculatorView addSubview:_line2];
    
    
    self.endYuejingLabel = [TTTAttributedLabel new];
    self.endYuejingLabel.textColor = KHexColor(@"#848484");
    self.endYuejingLabel.font = KFontSize(14);
    self.endYuejingLabel.text = @"末次月经时间:";
    [self.calculatorView addSubview:_endYuejingLabel];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    self.endYuejingTF = [UITextField new];
    self.endYuejingTF.textColor = KHexColor(@"#282828");
    self.endYuejingTF.font = KFontSize(14);
    self.endYuejingTF.placeholder = [formatter stringFromDate:[NSDate date]];
    self.endYuejingTF.delegate = self;
    self.endYuejingTF.enabled = NO;
    [self.calculatorView addSubview:_endYuejingTF];
    
    
    self.line3 = [UIView new];
    self.line3.backgroundColor = KHexColor(@"#d9d9d9");
    [self.calculatorView addSubview:_line3];
    
    
    self.datePicker = [UIDatePicker new];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.datePicker addTarget:self action:@selector(datePicker:) forControlEvents:UIControlEventValueChanged];
    [self.calculatorView addSubview:_datePicker];
    
    
    self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.finishButton.layer.cornerRadius = 5;
    self.finishButton.layer.masksToBounds = YES;
    [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.finishButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff879a")] forState:UIControlStateNormal];
    [self.finishButton addTarget:self action:@selector(finishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.calculatorView addSubview:_finishButton];
    
    
    
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.segmentedControl.mas_bottom).offset(10);
        make.left.equalTo(self.calculatorView.mas_left).offset(0);
        make.right.equalTo(self.calculatorView.mas_right).offset(0);
        make.height.equalTo(0.5);
    }];
    
    
    [_endYuejingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.calculatorView.mas_left).offset(10);
        make.top.equalTo(self.line2.mas_bottom).offset(10);
        make.width.equalTo(self.endYuejingLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    
    
    [_endYuejingTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.calculatorView.mas_right).offset(-10);
        make.top.equalTo(self.endYuejingLabel.mas_top).offset(0);
        make.width.equalTo(self.endYuejingTF.mas_width);
        make.height.equalTo(14);
    }];
    
    
    
    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.endYuejingLabel.mas_bottom).offset(10);
        make.left.equalTo(self.calculatorView.mas_left).offset(0);
        make.right.equalTo(self.calculatorView.mas_right).offset(0);
        make.height.equalTo(0.5);
    }];
    
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line3.mas_bottom).offset(10);
        make.left.equalTo(self.calculatorView.mas_left).offset(0);
        make.right.equalTo(self.calculatorView.mas_right).offset(0);
        make.height.equalTo(100);
    }];

    
    [_finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.datePicker.mas_bottom).offset(10);
        make.centerX.equalTo(self.calculatorView.centerX).offset(0);
        make.width.equalTo(100);
        make.height.equalTo(40);
    }];
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
- (void)pregnancyClick:(UISegmentedControl *)seg
{
    
    NSInteger index = seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            self.view.frame = CGRectMake(0, 0, CoreWidth-20, 280);
            [self.datePicker2 setMinimumDate:[NSDate date]];
            self.currentIdentity = @"0";
            [_calculatorView removeFromSuperview];
            [self chooseMakeUI];                //选择预产期
            break;
            
        case 1:
            self.view.frame = CGRectMake(0, 0, CoreWidth-20, 300);
            self.currentIdentity = @"2";
            [_chooseView removeFromSuperview];  //计算预产期
            [self calculateMakeUI];
            break;
            
        default:
            break;
    }
}


- (void)datePicker:(UIDatePicker *)picker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.dateString = [formatter stringFromDate:picker.date];
    self.endYuejingTF.text = self.dateString;
}
//计算预产期
- (void)finishButtonClick:(UIButton *)button
{
    
    if (![self.dateString isValid]) {
        NSDateFormatter *date =[[NSDateFormatter alloc] init];              //当前时间
        [date setDateFormat:@"yyyy-MM-dd"];
        self.currentDate = [date stringFromDate:[NSDate date]];
        if (self.pregnancyVCFinishBlock) {
            self.pregnancyVCFinishBlock(self);}
        
    }
    else
    {
        if (self.pregnancyVCFinishBlock){
            self.pregnancyVCFinishBlock(self);}
    }
    
}

//选择预产期
- (void)finishButton2Click:(UIButton *)button
{
    if (![self.dateString isValid]) {
        NSDateFormatter *date =[[NSDateFormatter alloc] init];              //当前时间
        [date setDateFormat:@"yyyy-MM-dd"];
        self.currentDate = [date stringFromDate:[NSDate date]];
        if (self.pregnancyVCFinishBlock) {
            self.pregnancyVCFinishBlock(self);}
        
    }
    else
    {
        if (self.pregnancyVCFinishBlock){
            self.pregnancyVCFinishBlock(self);}
    }

}

- (void)datePicker2:(UIDatePicker *)picker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.dateString = [formatter stringFromDate:picker.date];
    self.endYuejingTF.text = self.dateString;
}

@end






