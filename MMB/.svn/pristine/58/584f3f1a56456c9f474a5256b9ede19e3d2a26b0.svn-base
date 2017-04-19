//
//  ForgetPasswordVC.m
//  Login
//
//  Created by Michael on 15/11/6.
//  Copyright © 2015年 jumper. All rights reserved.
//

#import "ForgetPasswordVC.h"

@interface ForgetPasswordVC ()
@property (assign)NSInteger time;//倒计时计数器
@property (strong , nonatomic)NSTimer *timer;
@property (strong , nonatomic)NSString *code;//返回的验证码
@property (strong , nonatomic)NSString *phone;//返回的电话号码
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIView *numberView;
@property (strong, nonatomic) IBOutlet UIView *codeView;
@property (strong, nonatomic) IBOutlet UIButton *getCodeButton;
@property (strong, nonatomic) IBOutlet UIView *passwordViewNew;
@property (strong, nonatomic) IBOutlet UIButton *FinishButton;
@property (strong, nonatomic) IBOutlet UITextField *numberTF;
@property (strong, nonatomic) IBOutlet UITextField *codeTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;

@end


@implementation ForgetPasswordVC
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
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置密码";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.bgView.backgroundColor = KHexColor(@"#ffdfe5");
    
    self.numberView.layer.cornerRadius = 5;
    self.numberView.layer.masksToBounds = YES;
    self.numberView.backgroundColor = KHexColor(@"#ffffff");
    
    self.codeView.layer.cornerRadius = 5;
    self.codeView.layer.masksToBounds = YES;
    self.codeView.backgroundColor = KHexColor(@"#ffffff");

    
    self.getCodeButton.layer.cornerRadius = 5;
    self.getCodeButton.layer.masksToBounds = YES;
    [self.getCodeButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ffb062")] forState:(UIControlStateNormal)];

    
    self.passwordViewNew.layer.cornerRadius = 5;
    self.passwordViewNew.layer.masksToBounds = YES;
    self.passwordViewNew.backgroundColor = KHexColor(@"#ffffff");

    
    self.FinishButton.layer.cornerRadius = 5;
    self.FinishButton.layer.masksToBounds = YES;
    [self.FinishButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff5872")] forState:(UIControlStateNormal)];
    
    
    self.numberTF.placeholder = @"电话号码";
    self.numberTF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTF.placeholder = @"验证码";
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.passwordTF.placeholder = @"新密码";

}

- (IBAction)getCodeButtonClick:(UIButton *)sender {
    if ([NSString validateMobile:self.numberTF.text] == NO) {
        k_NSlogHUD(@"请输入正确手机号码");
    }else{
        self.time = 60;
        [ASLoadingView showActivity:self.view];
        NSDictionary *json = @{@"mobile":self.numberTF.text,@"type":@"1"};
        [ASURLConnection requestAFNJSon:json method:kGetPhoneCode view:nil version:@"" completeBlock:^(NSData *data, id responseObject) {
            [ASLoadingView hidenActivity:self.view];
            if ([[ASURLConnection getMsg:responseObject ] isEqual:@1]){
                NSDictionary *dict = [[[ASURLConnection doDESDecrypt:responseObject]objectFromJSONString]objectForKey:@"data"][0];
                self.phone = [dict objectForKey:@"mobile"];
                self.code = [dict objectForKey:@"code"];
                
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
                [self.getCodeButton removeTarget:self action:@selector(getCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.getCodeButton setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateNormal];
                
            }else{
                k_NSlogHUD([ASURLConnection getMessage:responseObject])
            }
        } errorBlock:^(NSError *error) {
            [ASLoadingView hidenActivity:self.view];
        }];
    }

}
//完成
- (IBAction)finishButotnCLick:(UIButton *)sender {

    if ([NSString validateMobile:self.numberTF.text] == NO) {
        k_NSlogHUD(@"请输入正确手机号码");
    }else if (self.numberTF.text.length<6||self.passwordTF.text.length>12){
        k_NSlogHUD(@"密码长度为6~12位");
    }else{
        
        if([NSString isBlankString:self.numberTF.text] == NO && [NSString isBlankString:self.codeTF.text] == NO && [NSString isBlankString:self.passwordTF.text] == NO && [self.numberTF.text isEqualToString:self.phone] && [self.codeTF.text isEqualToString:self.code]){
            NSDictionary *json = @{@"mobile":self.numberTF.text,@"password":self.passwordTF.text};
            
            [ASLoadingView showActivity:self.view];
            
            [ASURLConnection requestAFNJSon:json method:kResetPassWord completeBlock:^(NSData *data, id responseObject) {
                
                [ASLoadingView hidenActivity:self.view];
                
                if ([[ASURLConnection getMsg:responseObject ] isEqual:@1]) {
                    
                    k_NSlogHUD(@"更改成功")
                    double delayTime = 1.0;
                    __block UIViewController *bself = self;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime *NSEC_PER_SEC));
                    dispatch_after(popTime, dispatch_get_main_queue(), ^{
                        [bself.navigationController popViewControllerAnimated:YES];
                    });
                }else{
                    k_NSlogHUD([ASURLConnection getMessage:responseObject])
                }
            } errorBlock:^(NSError *error) {
                [ASLoadingView hidenActivity:self.view];
            }];
        }
    }

}
-(void)timeDown{
    if (self.time == 0) {
        [self.timer invalidate];
        self.timer = nil;
        [self.getCodeButton addTarget:self action:@selector(getCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.getCodeButton setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateNormal];
        [self.getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else{
        self.time--;
        [self.getCodeButton setTitle:[NSString stringWithFormat:@"%lds",(long)self.time] forState:UIControlStateNormal] ;
    }
}


@end
