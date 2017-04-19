//
//  AddTemperatureDataVC.m
//  Mamabao
//
//  Created by Michael on 15/11/25.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import "AddTemperatureDataVC.h"
@interface AddTemperatureDataVC ()

@property (nonatomic, strong) UIView *horizontalLine;
@property (nonatomic, strong) UIView *verticalLine;
@property (nonatomic, strong) UILabel*titleLabel;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UITextField *textTF;
@end

@implementation AddTemperatureDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = KFontSize(14);
    self.titleLabel.textColor = KHexColor(@"#ffffff");
    self.titleLabel.backgroundColor = KHexColor(@"#ff879a");
    self.titleLabel.text = @"体温（℃）";
    [self.view addSubview:_titleLabel];
    
    
    
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.sureButton.layer.cornerRadius = 5;
    self.sureButton.layer.masksToBounds = YES;
    [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.sureButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff879a")] forState:UIControlStateNormal];
    [self.view addSubview:_sureButton];
    
    self.textTF = [UITextField new];
    self.textTF.layer.cornerRadius = 5;
    self.textTF.layer.masksToBounds = YES;
    self.textTF.layer.borderColor = KHexColor(@"#dfdfdf").CGColor;
    self.textTF.layer.borderWidth = 1;
    self.textTF.font = KFontSize(14);
    self.textTF.textColor = KHexColor(@"#ff97a6");
    [self.view addSubview:_textTF];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(35);
    }];
    
    
    [_textTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.equalTo(250);
        make.height.equalTo(40);
    }];

    
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.top.equalTo(self.textTF.mas_bottom).offset(10);
        make.width.equalTo(CoreWidth/3);
        make.height.equalTo(35);
        
    }];
}

- (void) closeButtonClick:(UIButton *)button {
    
    if (self.dismissSimanPopoverViewController) {
        self.dismissSimanPopoverViewController(self);
    }
}


- (void)sureButtonClick:(UIButton *)button
{
    if (self.sureBlock) {
        self.sureBlock();
    }
    if (self.dismissSimanPopoverViewController) {
        self.dismissSimanPopoverViewController(self);
    }

}

@end

