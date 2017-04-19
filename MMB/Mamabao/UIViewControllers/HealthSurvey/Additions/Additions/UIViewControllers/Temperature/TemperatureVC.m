//
//  TemperatureVC.m
//  Mamabao
//
//  Created by Michael on 15/11/17.
//  Copyright © 2015年 Michael. All rights reserved.
//
#define TRANSFER_SERVICE_UUID           @"CDEACB80-5235-4C07-8846-93A37EE6B86D" //本身的发现服务
#define TRANSFER_CHARACTERISTIC_UUID    @"CDEACB81-5235-4C07-8846-93A37EE6B86D" //对方的账号


#import "TemperatureVC.h"
#import "OximeterRecordVC.h"
#import "AddTemperatureDataVC.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface TemperatureVC ()<CBCentralManagerDelegate,CBPeripheralDelegate,WYPopoverControllerDelegate>
@property (nonatomic , strong) WYPopoverController *simanPopoverController;

@property (nonatomic, strong) CBCentralManager*centralManager;
@property (nonatomic, strong) CBPeripheral*discovedPeripheral;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) TTTAttributedLabel *label1;
@property (nonatomic, strong) TTTAttributedLabel *label2;
@property (nonatomic, strong) TTTAttributedLabel *label3;
@property (nonatomic, strong) TTTAttributedLabel *label4;
@property (nonatomic, strong) TTTAttributedLabel *label3Hou;
@property (nonatomic, strong) UIImageView *circleImage;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *addButton;
@end

@implementation TemperatureVC
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"3_monitor"] style:(UIBarButtonItemStylePlain) target:self action:@selector(rightClick)];
        self.navigationItem.rightBarButtonItem = right;
        right.tintColor = KHexColor(@"#ffffff");
    }
    return self;
}
- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightClick
{
    OximeterRecordVC *tem = [OximeterRecordVC new];
    tem.typeRecordString = @"4";
    [self.navigationController pushViewController:tem animated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"温度";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];//创建蓝牙
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [self makeUI];
}
- (void)makeUI
{
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, CoreHeight-64)];
    self.headerView.backgroundColor = KHexColor(@"#f3f3f3");
    [self.tableView addSubview:_headerView];
    
    
    self.label1 = [TTTAttributedLabel new];
    self.label1.font = KFontSize(14);
    self.label1.textColor = KHexColor(@"#666666");
    self.label1.text = @"正在尝试连接设备中";
    [self.headerView addSubview:_label1];
    
    
    self.label2 = [TTTAttributedLabel new];
    self.label2.font = KFontSize(14);
    self.label2.textColor = [UIColor clearColor];
    self.label2.text = @"00:00";
    [self.headerView addSubview:_label2];
    
    
    self.circleImage = [UIImageView new];
    self.circleImage.image = [UIImage imageNamed:@"monitor67"];
    [self.headerView addSubview:_circleImage];
    
    
    self.label3 = [TTTAttributedLabel new];
    self.label3.font = KFontSize(30);
    self.label3.textColor = KHexColor(@"#fe647e");
    self.label3.text = @"0";
    [self.headerView addSubview:_label3];
    
    self.label3Hou = [TTTAttributedLabel new];
    self.label3Hou.font = KFontSize(14);
    self.label3Hou.textColor = KHexColor(@"#666666");
    self.label3Hou.text = @"℃";
    [self.headerView addSubview:_label3Hou];
    
    
    self.label4 = [TTTAttributedLabel new];
    self.label4.font = KFontSize(14);
    self.label4.textColor = KHexColor(@"#333333");
    self.label4.text = @"体温";
    [self.headerView addSubview:_label4];
    
    
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton.layer.cornerRadius = 7;
    self.addButton.layer.masksToBounds = YES;
    self.addButton.titleLabel.font = KFontSize(14);
    [self.addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.addButton setTitle:@"添加数据" forState:UIControlStateNormal];
    [self.addButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.addButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff92a5")] forState:UIControlStateNormal];
    [self.headerView addSubview:_addButton];
    
    
    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.headerView.mas_top).offset(25);
        make.width.equalTo(self.label1.mas_width);
        make.height.equalTo(14);
    }];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.label1.mas_bottom).offset(25);
        make.width.equalTo(self.label2.mas_width);
        make.height.equalTo(14);
    }];
    
    [_circleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.label2.mas_bottom).offset(25);
        make.width.equalTo(225);
        make.height.equalTo(225);
    }];
    
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.centerY.equalTo(self.circleImage.mas_centerY).offset(0);
        make.width.equalTo(self.label3.mas_width);
        make.height.equalTo(30);
    }];
    
    [_label3Hou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label3.mas_right).offset(2);
        make.bottom.equalTo(self.label3.mas_bottom).offset(0);
        make.width.equalTo(self.label3Hou.mas_width);
        make.height.equalTo(14);
    }];

    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.circleImage.mas_bottom).offset(-50);
        make.width.equalTo(self.label4.mas_width);
        make.height.equalTo(14);
    }];
    
    
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.bottom.equalTo(self.headerView.mas_bottom).offset(-50);
        make.width.equalTo(90);
        make.height.equalTo(30);
    }];
    
    
}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------
- (void)startButtonClick
{
    
}

- (void)addButtonClick
{
    
    //创建弹框
    AddTemperatureDataVC *temperature = [AddTemperatureDataVC new];//初始化弹框
    temperature.preferredContentSize = CGSizeMake( CoreWidth,CoreHeight);//设置弹框的大小
    //弹框消失。
    [temperature setDismissSimanPopoverViewController:^(AddTemperatureDataVC *viewController) {
        [self.simanPopoverController dismissPopoverAnimated:YES completion:^{
            NSLog(@"dismiss");
            [self popoverControllerDidDismissPopover:_simanPopoverController];
        }];
    }];
    
    //确定方法
    
    [temperature setSureBlock:^{
        NSLog(@"sure");
    }];
    self.simanPopoverController = [[WYPopoverController alloc] initWithContentViewController:temperature];
    self.simanPopoverController.delegate = self;
    self.simanPopoverController.animationDuration = .5f;
    //self.simanPopoverController.popoverLayoutMargins = CoreWidth == 320 ? UIEdgeInsetsMake(400, 10,10, 10) : CoreWidth == 375 ? UIEdgeInsetsMake(667-328-40, 10,10,10) : UIEdgeInsetsMake(717-328-40, 10,10, 10);
    self.simanPopoverController.popoverLayoutMargins = UIEdgeInsetsMake(CoreHeight-168, 10, 10, 10);
    self.simanPopoverController.wantsDefaultContentAppearance = NO;
    
    //设置弹框的主题风格
    WYPopoverTheme *result = [[WYPopoverTheme alloc] init];
    result.usesRoundedArrow = YES;
    result.dimsBackgroundViewsTintColor = YES;
    result.tintColor = nil;
    result.outerStrokeColor = [UIColor clearColor];
    result.innerStrokeColor = [UIColor clearColor];
    result.fillTopColor = nil;
    result.fillBottomColor = nil;
    result.glossShadowColor = nil;
    result.glossShadowOffset = CGSizeZero;
    result.glossShadowBlurRadius = 0;
    result.borderWidth = 0;
    result.arrowBase = 15;
    result.arrowHeight = 6;
    result.outerShadowColor = [UIColor clearColor];
    result.outerShadowBlurRadius = 0;
    result.outerShadowOffset = CGSizeZero;
    result.outerCornerRadius = 5;
    result.minOuterCornerRadius = 0;
    result.innerShadowColor = [UIColor clearColor];
    result.innerShadowBlurRadius = 0;
    result.innerShadowOffset = CGSizeZero;
    result.innerCornerRadius = 0;
    result.viewContentInsets = UIEdgeInsetsZero;
    result.overlayColor = [UIColor colorWithWhite:0 alpha:0.3];
    result.preferredAlpha = 1.0f;
    self.simanPopoverController.theme = result;
    
    
    [self.simanPopoverController presentPopoverAsDialogAnimated:YES
                                                        options:WYPopoverAnimationOptionFadeWithScale];

}

#pragma mark ------------------------------------------------------------------Blue  Delegate-----------------------------------------------------------

-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state!=CBCentralManagerStatePoweredOn)
    {
        self.label1.text = @"请打开手机蓝牙";
        return;
    }
    [self scan];
}
-(void)scan{
    
    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]
                                                options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    self.label1.text = @"正在准备连接...";
    if (self.discovedPeripheral != peripheral) {
        self.discovedPeripheral = peripheral;
        [self.centralManager connectPeripheral:peripheral options:nil];
        
    }
}

-(void)xx{
    [self.centralManager stopScan];
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    
    [self.centralManager stopScan];//停止扫描
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
    
}



-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    self.label1.text = @"连接成功";
    if (error)
    {
        NSLog(@"Errordiscover:%@",error.localizedDescription);
        [self clearUp];
        return;
    }

    for (CBService*server in peripheral.services)
    {
        if ([server.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]])
        {
            NSLog(@"Service found with UUID: %@", server.UUID);
            [peripheral discoverCharacteristics:nil forService:server];
            break;
        }
        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]] forService:server];
    }
    
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (error) {
        NSLog(@"error  %@",[error localizedDescription]);
        [self clearUp];
        return;
    }
    for (CBCharacteristic*characteristic in service.characteristics)
    {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID] ]) {
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            
        }
    }
    
}
//这个函数类似网络请求时候只需收到数据的那个函数
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
    if (error) {
        NSLog(@"无法获取数据");
        return;
    }
    self.discovedPeripheral=peripheral;
    NSMutableString *string=[[NSMutableString alloc]init];
    if (characteristic.value.length==5) {
        Byte *byte0=(Byte *)[characteristic.value bytes];
        for (int i=1; i<characteristic.value.length; i++) {
            if (i==1||i==4) {
                int bt=(int)(byte0[i]&0xff);
                NSLog(@"%d",bt);
            }else if(i==2||i==3){
                NSString* string0=[NSString stringWithFormat:@"%x",byte0[i]&0xff];
                if (string0.length<2) {
                    [string appendFormat:@"0%x",byte0[i]&0xff ];
                }else{
                    
                    [string appendFormat:@"%x",byte0[i]&0xff ];
                }
            }
            
        }
        NSLog(@"温度是~~~~%@",string);
        NSLog(@"%s",[string UTF8String]);
        float a=[[NSString stringWithFormat:@"%lu",strtoul([string UTF8String],0,16)] floatValue]/100;
        NSLog(@"温度是~~~~~~%.1f",[[NSString stringWithFormat:@"%lu",strtoul([string UTF8String],0,16)] floatValue]/100);
        
        
        /**
         *	得到的温度
         *
         */
        
        NSString *temperString=[NSString stringWithFormat:@"%.1f",a];
        NSLog(@"temperString%@",temperString);
        self.label3.text = temperString;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"temper1" object:temperString userInfo:nil];
    }
    
}
-(void)clearUp{
    
    if (self.discovedPeripheral.services!=nil) {
        for (CBService*server in self.discovedPeripheral.services) {
            
            if (server.characteristics!=nil) {
                for (CBCharacteristic*chatacter in server.characteristics) {
                    
                    if ([chatacter.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]|| [chatacter.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF4"]]) {
                        
                        //查看是否订阅了
                        if (chatacter.isNotifying) {
                            //如果订阅了。取消订阅
                            [self.discovedPeripheral setNotifyValue:NO forCharacteristic:chatacter];
                            return;
                        }
                        
                    }
                    
                }
            }
        }
    }
    
    [self.centralManager cancelPeripheralConnection:self.discovedPeripheral];//如果我们连接了，但是没有订阅，就断开连接即可
    
}
#pragma mark - WYPopoverControllerDelegate

- (void)popoverControllerDidPresentPopover:(WYPopoverController *)controller
{
    NSLog(@"popoverControllerDidPresentPopover");
    
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    
    self.simanPopoverController.delegate = nil;
    NSLog(@"popoverControllerDidDismissPopover");
}

- (BOOL)popoverControllerShouldIgnoreKeyboardBounds:(WYPopoverController *)popoverController
{
    return NO;
}

- (void)popoverController:(WYPopoverController *)popoverController willTranslatePopoverWithYOffset:(float *)value
{
    // keyboard is shown and the popover will be moved up by 163 pixels for example ( *value = 163 )
    *value = 120; // set value to 0 if you want to avoid the popover to be moved
}
- (void)popoverController:(WYPopoverController *)popoverController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView **)view
{
    
}

@end
