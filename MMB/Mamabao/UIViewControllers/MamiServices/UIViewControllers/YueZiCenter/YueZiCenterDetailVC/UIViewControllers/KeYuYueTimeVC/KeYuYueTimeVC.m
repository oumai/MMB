//
//  KeYuYueTimeVC.m
//  Mamabao
//
//  Created by Michael on 15/12/14.
//  Copyright © 2015年 Michael. All rights reserved.
//


#import "KeYuYueTimeVC.h"
@interface KeYuYueTimeVC ()

@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *finishButton;
@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) UIView *line;
@end

@implementation KeYuYueTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KHexColor(@"#ffffff");
    
    self.titleLabel = [TTTAttributedLabel new];
    self.titleLabel.font = KFontSize(14);
    self.titleLabel.textColor =  KHexColor(@"#ff627b");
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"可预约时间";
    [self.view addSubview:_titleLabel];
    
    self.datePicker = [UIDatePicker new];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.datePicker setMinimumDate:[NSDate date]];
    [self.datePicker addTarget:self action:@selector(datePicker:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_datePicker];
    
    
    self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.finishButton.titleLabel.font = KFontSize(14);
    self.finishButton.layer.cornerRadius = 5;
    self.finishButton.layer.masksToBounds = YES;
    [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.finishButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff879a")] forState:UIControlStateNormal];
    [self.finishButton addTarget:self action:@selector(finishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_finishButton];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = KHexColor(@"#c5c5c5");
    [self.view addSubview:_line];
    
    
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
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(0.5);
    }];

    
    [_finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.width.equalTo(80);
        make.height.equalTo(30);
    }];
    
    
}

- (void)datePicker:(UIDatePicker *)picker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.dateString = [formatter stringFromDate:picker.date];
}

- (void)finishButtonClick:(UIButton *)button
{
    
    
    
    if ([self.dateString isValid]) {
        if (self.sureBlock)
        {
            self.sureBlock(self.dateString);  //滑动之后的时间
        }
    }
    else
    {
        //当前时间
        NSDateFormatter *date =[[NSDateFormatter alloc] init];
        [date setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDate = [date stringFromDate:[NSDate date]];
        
        if (self.sureBlock)
        {
            self.sureBlock(currentDate);  //滑动之后的时间
        }

    }
    
    if (self.dismissSimanPopoverViewController){
        
        self.dismissSimanPopoverViewController(self);
    }

    
}
@end




