//
//  WeightVC.m
//  Mamabao
//
//  Created by Michael on 15/11/17.
//  Copyright © 2015年 Michael. All rights reserved.
//
#define TRANSFER_SERVICE_UUID            @"0xFFF0"
#define TRANSFER_CHARACTERISTIC_UUID1    @"0xFFF1"
#define TRANSFER_CHARACTERISTIC_UUID2    @"0xFFF2"
#define TRANSFER_CHARACTERISTIC_UUID3    @"0xFFF3"
#define TRANSFER_CHARACTERISTIC_UUID4    @"0xFFF4"
#define TRANSFER_CHARACTERISTIC_UUID5    @"0xFFF5"


#import "WeightVC.h"
#import "OximeterRecordVC.h"
#import "AddWeightDataVC.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface WeightVC ()<CBCentralManagerDelegate,CBPeripheralDelegate,WYPopoverControllerDelegate>
@property (nonatomic , strong) WYPopoverController *simanPopoverController;

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral *discoveredPeripheral;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) TTTAttributedLabel *label1;
@property (nonatomic, strong) TTTAttributedLabel *label2;
@property (nonatomic, strong) TTTAttributedLabel *label3;
@property (nonatomic, strong) TTTAttributedLabel *label4;
@property (nonatomic, strong) UIImageView *circleImage;
@property (nonatomic, strong) UIImageView*lineImage;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *addButton;
@end

@implementation WeightVC
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
    OximeterRecordVC *weight = [OximeterRecordVC new];
    weight.typeRecordString = @"5";
    [self.navigationController pushViewController:weight animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"体重";
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
    self.label3.font = KFontSize(17);
    self.label3.textColor = KHexColor(@"#f2554d");
    [self.headerView addSubview:_label3];
    
    self.lineImage= [UIImageView new];
    self.lineImage.image = [UIImage imageNamed:@"monitor88"];
    [self.headerView addSubview:_lineImage];
    
    [_lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.label3.mas_bottom).offset(2);
        make.width.equalTo(37);
        make.height.equalTo(3);
    }];

    
    self.label4 = [TTTAttributedLabel new];
    self.label4.font = KFontSize(14);
    self.label4.textColor = KHexColor(@"#333333");
    self.label4.text = @"kg";
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
        make.top.equalTo(self.circleImage.mas_top).offset(80);
        make.width.equalTo(self.label3.mas_width);
        make.height.equalTo(17);
    }];
    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.circleImage.mas_bottom).offset(-50);
        make.width.equalTo(self.label4.mas_width);
        make.height.equalTo(18);
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
    AddWeightDataVC *weight = [AddWeightDataVC new];//初始化弹框
    weight.preferredContentSize = CGSizeMake( CoreWidth,CoreHeight);//设置弹框的大小
    //弹框消失。
    [weight setDismissSimanPopoverViewController:^(AddWeightDataVC *viewController) {
        [self.simanPopoverController dismissPopoverAnimated:YES completion:^{
            NSLog(@"dismiss");
            [self popoverControllerDidDismissPopover:_simanPopoverController];
        }];
    }];
    
    //确定方法
    
    [weight setSureBlock:^{
        NSLog(@"sure");
    }];
    self.simanPopoverController = [[WYPopoverController alloc] initWithContentViewController:weight];
    self.simanPopoverController.delegate = self;
    self.simanPopoverController.animationDuration = .5f;
    //self.simanPopoverController.passthroughViews = @[button];
    //self.simanPopoverController.popoverLayoutMargins = UIEdgeInsetsMake(200+180, 10,200-180, 10);
    //self.simanPopoverController.popoverLayoutMargins = CoreWidth == 320 ? UIEdgeInsetsMake(300, 10,10, 10) : CoreWidth == 375 ? UIEdgeInsetsMake(667-328-40, 10,10,10) : UIEdgeInsetsMake(717-328-40, 10,10, 10);
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
#pragma mark ------------------------------------------------------------------Bluetooth Delegate-----------------------------------------------------------
- (void) centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state != CBCentralManagerStatePoweredOn) {
        self.label1.text = @"请打开手机蓝牙";
        return;
    }
    
    NSLog(@"蓝牙开启");
    [self scan];
    
}

- (void)scan
{
    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]
                                                options:@{CBCentralManagerScanOptionAllowDuplicatesKey :@YES}];
}



//3连接外围设备
//当外围设备广播同样的UUID信号被发现时，这个代理函数被调用。这时我们要监测RSSI即Received Signal Strength Indication接收的信号强度指示，确保足够近，我们才连接它
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    self.label1.text = @"正在尝试连接设备中";
    if (self.discoveredPeripheral != peripheral)
    {
        self.discoveredPeripheral = peripheral;
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}


//4扫描服务和特征
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"4");
    [self.centralManager stopScan];
    //确保我们收到的外围设备连接后的回调代理函数
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
    
    self.label1.text = @"连接成功";
}

//5 发现服务 /相当于对方的账号
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    
    NSLog(@"5");
    if (error)
    {
        return;
    }
    //找到我们想要的特性
    for (CBService*server in peripheral.services)
    {
        if ([server.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]])
        {
            
            [peripheral discoverCharacteristics:nil forService:server];
            
            break;
        }
        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID1],[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID2],[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID3],[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID4],[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID5]] forService:server];
        
    }
    
    
    
    
}
//6发现服务中的特性
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"6");
    if (error)
    {
        NSLog(@"error  %@",[error localizedDescription]);
        return;
    }
    //检查特性
    for (CBCharacteristic*characteristic in service.characteristics)
    {
        NSLog(@"characteristic.UUID-----------%@",characteristic.UUID);
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID1] ])
        {
            
            //如果第一个参数是yes的话，就是允许代理方法peripheral:didUpdateValueForCharacteristic:error: 来监听 第二个参数 特性是否发生变化
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            //完成后，等待数据传进来
            NSLog(@"订阅成功1");
            
        }
        
        else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID2] ])
        {
            
            //如果第一个参数是yes的话，就是允许代理方法peripheral:didUpdateValueForCharacteristic:error: 来监听 第二个参数 特性是否发生变化
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            //完成后，等待数据传进来
            NSLog(@"订阅成功2");
            
        }
        else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID3] ])
        {
            
            //如果第一个参数是yes的话，就是允许代理方法peripheral:didUpdateValueForCharacteristic:error: 来监听 第二个参数 特性是否发生变化
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            //完成后，等待数据传进来
            NSLog(@"订阅成功3");
            
        }
        else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID4] ])
        {
            
            //如果第一个参数是yes的话，就是允许代理方法peripheral:didUpdateValueForCharacteristic:error: 来监听 第二个参数 特性是否发生变化
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            //完成后，等待数据传进来
            NSLog(@"订阅成功4");
            
        }
        else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID5] ])
        {
            
            //如果第一个参数是yes的话，就是允许代理方法peripheral:didUpdateValueForCharacteristic:error: 来监听 第二个参数 特性是否发生变化
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            //完成后，等待数据传进来
            NSLog(@"订阅成功5");
            
        }
        
    }
    
    
}



//这个函数类似网络请求时候只需收到数据的那个函数
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
    NSLog(@"收到的数据：--------%@",characteristic.value);
    NSLog(@"收到数据长度  %lu",(unsigned long)characteristic.value.length);
    
    
    
    //处理蓝牙发送过来的数据
    if (error)
    {
        NSLog(@"无法获取数据");
        return;
    }
    if (characteristic.value.length == 16) {
        
        Byte *byte0 = (Byte *)[characteristic.value bytes];
        NSMutableString *string = [[NSMutableString alloc] init];
        [string appendFormat:@"%x",byte0[4]&0xff];
        [string appendFormat:@"%x",byte0[5]&0xff];
        float weight = [[NSString stringWithFormat:@"%lu",strtoul([string UTF8String], 0, 16)] floatValue]/10;
        NSString *lastWeight1 = [NSString stringWithFormat:@"%.1f",weight];
        NSLog( @"lastWeight= %@",lastWeight1);
        //精确小数点后两位
        NSString *lastWeight2 = [NSString stringWithFormat:@"%.2f",weight];
        NSLog( @"lastWeight= %@",lastWeight2);
        //精确小数点后三位
        NSString *lastWeight3 = [NSString stringWithFormat:@"%.3f",weight];
        NSLog( @"lastWeight= %@",lastWeight3);
        
        self.label3.text = lastWeight1;
    }
    
    
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