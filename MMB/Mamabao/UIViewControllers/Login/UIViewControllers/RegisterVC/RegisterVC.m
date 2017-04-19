//
//  RegisterVC.m
//  Login
//
//  Created by Michael on 15/11/6.
//  Copyright © 2015年 jumper. All rights reserved.
//

#import "RegisterVC.h"
#import "ChooseStateVC.h"
@interface RegisterVC ()
@property (assign)NSInteger time;//倒计时计数器
@property (strong, nonatomic) NSTimer *timer;//倒计时
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIView *numberView;
@property (strong, nonatomic) IBOutlet UIView *codeView;
@property (strong, nonatomic) IBOutlet UIButton *getCodeButton;
@property (strong, nonatomic) IBOutlet UIView *passwordViewNew;
@property (strong, nonatomic) IBOutlet UIButton *registButton;
@property (strong, nonatomic) IBOutlet UITextField *numberTF;
@property (strong, nonatomic) IBOutlet UITextField *codeTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;


@end

@implementation RegisterVC

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
    self.title = @"用户注册";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    /*添加释放键盘手势*/
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backTap:)];
    [self.view addGestureRecognizer:tap];
   
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
    
    
    self.registButton.layer.cornerRadius = 5;
    self.registButton.layer.masksToBounds = YES;
    [self.registButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff5872")] forState:(UIControlStateNormal)];
    
    
    self.numberTF.placeholder = @"电话号码";
    self.numberTF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTF.placeholder = @"验证码";
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.passwordTF.placeholder = @"新密码";
    
    
}

-(void)backTap:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}
//获取验证码
- (IBAction)getCodeButtonClick:(UIButton *)sender
{
    
    if([NSString validateMobile:self.numberTF.text] == NO)
    {
        k_NSlogHUD(@"请输入正确手机号码");
    }
    else
    {
        self.time = 60;
        [ASLoadingView showActivity:self.view];
        [ASURLConnection requestAFNJSon:@{@"mobile":[self.numberTF.text stringByReplacingOccurrencesOfString:@" " withString:@""],
                                          @"type":@0}
                                 method:kGetPhoneCode
                                   view:nil
                                version:@""
                          completeBlock:^(NSData *data, id responseObject)
         {
             [ASLoadingView hidenActivity:self.view];
             if ([[ASURLConnection getMsg:responseObject]isEqual:@1])
             {
                 
                 self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
                 [self.getCodeButton removeTarget:self action:@selector(getCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                 [self.getCodeButton setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateNormal];
                 //[self.getCodeButton setBackgroundImage:[UIImage imageNamed:@"green_button_h"] forState:UIControlStateNormal];
                 
             }else
             {
                 k_NSlogHUD([ASURLConnection getMessage:responseObject])
             }
         } errorBlock:^(NSError *error) {
            [ASLoadingView hidenActivity:self.view];
        }];
    }
    
    
}
//注册
- (IBAction)registerButtonClick:(UIButton *)sender {
    
    
    if (self.passwordTF.text.length >5 && self.passwordTF.text.length < 17)
    {
        
        [ASLoadingView showActivity:self.view];
        [ASURLConnection requestAFNJSon:@{@"mobile":[self.numberTF.text stringByReplacingOccurrencesOfString:@" " withString:@""],@"verified_code":[self.codeTF.text stringByReplacingOccurrencesOfString:@" " withString:@""] } method:kPhoneCodeIsRight view:nil version:@"" completeBlock:^(NSData *data, id responseObject) {
            [ASLoadingView hidenActivity:self.view];
            if ([[ASURLConnection getMsg:responseObject]isEqual:@1])
            {
                
                ChooseStateVC *choose  = [ChooseStateVC new];                       //跳转到选择状态
                choose.role = ASRegisterRolePregnancy;
                choose.source = ASRegisterSourcePhone;
                choose.net = ASRegisterNetNO;
                choose.phoneNumber = self.numberTF.text;
                choose.passwordNumber = self.passwordTF.text;
                choose.codeNumber = self.codeTF.text;
                [self.navigationController pushViewController:choose animated:YES];
                
            }else{
                k_NSlogHUD([ASURLConnection getMessage:responseObject])
            }
        } errorBlock:^(NSError *error) {
            [ASLoadingView hidenActivity:self.view];
        }];
    }
    else
    {
        k_NSlogHUD(@"请输入6-16位密码")
    }

}

/**
 *  倒计时计数器
 */
-(void)timeDown{
    if (self.time == 0) {
        [self.timer invalidate];
        self.timer = nil;
        [self.getCodeButton addTarget:self action:@selector(getCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.getCodeButton setBackgroundImage:[UIImage imageNamed:@"green_button"] forState:UIControlStateNormal];
        [self.getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else{
        self.time--;
        [self.getCodeButton setTitle:[NSString stringWithFormat:@"%lds",(long)self.time] forState:UIControlStateNormal] ;
    }
}

@end
