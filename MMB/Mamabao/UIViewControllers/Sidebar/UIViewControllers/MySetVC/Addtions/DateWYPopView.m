//
//  DateWYPopView.m
//  Mamabao
//
//  Created by Michael on 15/12/10.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import "DateWYPopView.h"

@interface DateWYPopView ()

@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *finishButton;
@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) UIButton *lastYueJingTimeButton;
@end

@implementation DateWYPopView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KHexColor(@"#ffffff");
    
    self.titleLabel = [TTTAttributedLabel new];
    self.titleLabel.textColor = KHexColor(@"#ffffff");
    self.titleLabel.backgroundColor = KHexColor(@"#ff879a");
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLabel];
    
    self.datePicker = [UIDatePicker new];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.datePicker addTarget:self action:@selector(datePicker:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_datePicker];
    
    
    self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.finishButton addTarget:self action:@selector(finishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_finishButton];
    
   
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(40);
    }];
    
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(150);
    }];
    
    [_finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-5);
        make.top.equalTo(self.view.top).offset(5);
        make.width.equalTo(50);
        make.height.equalTo(30);
    }];
    [self changeUI];
}
- (void)changeUI
{
    if ([self.currentIdentity  intValue] == 1)
    {
        self.titleLabel.text = @"设置宝宝生日";

    }
    if ([self.currentIdentity intValue] == 0)
    {
        [self.datePicker setMinimumDate:[NSDate date]];
        self.titleLabel.text = @"设置预产期时间";
        self.lastYueJingTimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.lastYueJingTimeButton.titleLabel.font = KFontSize(14);
        [self.lastYueJingTimeButton setTitle:@"不知道预产期" forState:UIControlStateNormal];
        [self.lastYueJingTimeButton setTitleColor:KHexColor(@"#6666666") forState:UIControlStateNormal];
        [self.lastYueJingTimeButton addTarget:self action:@selector(lastYueJingTimeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_lastYueJingTimeButton];
        
        
        [_lastYueJingTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(0);
            make.bottom.equalTo(self.view.bottom).offset(-5);
            make.width.equalTo(100);
            make.height.equalTo(30);
        }];
        
    }
    
    if ([self.currentIdentity intValue] == 2) {
        self.titleLabel.text = @"设置末次月经时间";                       //末次月经时间
        [_lastYueJingTimeButton removeFromSuperview];
    }
    
}

- (void)lastYueJingTimeButtonClick:(UIButton *)button
{
    self.currentIdentity = @"2";
    if (self.noYuChanQiBlock) {
        self.noYuChanQiBlock(self);
        
    }}
- (void)datePicker:(UIDatePicker *)picker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.dateString = [formatter stringFromDate:picker.date];
    NSLog(@"%@",self.dateString);
    
   
}

- (void)finishButtonClick:(UIButton *)button
{
    
    if (![self.dateString isValid]) {
        NSDateFormatter *date =[[NSDateFormatter alloc] init];              //当前时间
        [date setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDate = [date stringFromDate:[NSDate date]];
        if (self.sureBlock) {
            self.sureBlock(currentDate);
        }
    }
    else
    {
        if (self.sureBlock) {
            self.sureBlock(self.dateString);
        }
    }
    if (self.dismissSimanPopoverViewController){
        
        self.dismissSimanPopoverViewController(self);
    }

}
@end





