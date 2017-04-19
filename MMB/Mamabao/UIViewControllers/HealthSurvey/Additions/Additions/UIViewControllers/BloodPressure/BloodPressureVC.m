//
//  BloodPressureVC.m
//  Mamabao
//
//  Created by Michael on 15/11/17.
//  Copyright © 2015年 Michael. All rights reserved.
//
#define TRANSFER_SERVICE_UUID            @"FFF0"
#define TRANSFER_CHARACTERISTIC_UUID1    @"FFF1"
#define TRANSFER_CHARACTERISTIC_UUID2    @"FFF2"

#import "BloodPressureVC.h"
#import "OximeterRecordVC.h"
#import "AddPressureDataVC.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface BloodPressureVC ()<CBCentralManagerDelegate,CBPeripheralDelegate,WYPopoverControllerDelegate>
@property (nonatomic , strong) WYPopoverController *simanPopoverController;

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral *discoveredPeripheral;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) TTTAttributedLabel *label1;
@property (nonatomic, strong) TTTAttributedLabel *label2Low;
@property (nonatomic, strong) TTTAttributedLabel *label2High;
@property (nonatomic, strong) TTTAttributedLabel *labelPul;
@property (nonatomic, strong) TTTAttributedLabel *label3;
@property (nonatomic, strong) TTTAttributedLabel *label4;
@property (nonatomic, strong) UIImageView *circleImage;
@property (nonatomic, strong) UIImageView*lineImage;
@property (nonatomic, strong) UIButton *addButton;
@end

@implementation BloodPressureVC
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
    OximeterRecordVC *blood = [OximeterRecordVC new];
    blood.typeRecordString = @"6";
    [self.navigationController pushViewController:blood animated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"血压";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];// 创建蓝牙
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
    
    
    
    self.circleImage = [UIImageView new];
    self.circleImage.image = [UIImage imageNamed:@"monitor67"];
    [self.headerView addSubview:_circleImage];
    
      
    

    
    self.lineImage= [UIImageView new];
    self.lineImage.image = [UIImage imageNamed:@"monitor88"];
    [self.headerView addSubview:_lineImage];
    
       
    self.label2Low = [TTTAttributedLabel new];
    self.label2Low.font = KFontSize(20);
    self.label2Low.textColor = KHexColor(@"#f2554d");
    [self.headerView addSubview:_label2Low];
    
    self.label2High = [TTTAttributedLabel new];
    self.label2High.font = KFontSize(20);
    self.label2High.textColor = KHexColor(@"#f2554d");
    [self.headerView addSubview:_label2High];
    
    self.labelPul = [TTTAttributedLabel new];
    self.labelPul.font = KFontSize(18);
    self.labelPul.textColor = KHexColor(@"#f2554d");
    [self.headerView addSubview:_labelPul];
    
    
    self.label3 = [TTTAttributedLabel new];
    self.label3.font = KFontSize(14);
    self.label3.textColor = KHexColor(@"#666666");
    self.label3.text = @"mmHg";
    [self.headerView addSubview:_label3];
    
      
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
    
    [_circleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.label1.mas_bottom).offset(60);
        make.width.equalTo(225);
        make.height.equalTo(225);
    }];
    
    [_lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.circleImage.mas_top).offset(84);
        make.width.equalTo(37);
        make.height.equalTo(3);
    }];
    
    [_label2Low mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.lineImage.mas_left).offset(0);
        make.centerY.equalTo(self.lineImage.mas_centerY).offset(-3);
        make.width.equalTo(self.label2Low.mas_width);
        make.height.equalTo(20);
        
        
    }];
    
    [_label2High mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.lineImage.mas_right).offset(0);
        make.centerY.equalTo(self.lineImage.mas_centerY).offset(-3);
        make.width.equalTo(self.label2Low.mas_width);
        make.height.equalTo(20);
        
    }];
    [_labelPul mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.lineImage.mas_centerX).offset(0);
        make.centerY.equalTo(self.lineImage.mas_centerY).offset(-15);
        make.width.equalTo(self.label2Low.mas_width);
        make.height.equalTo(20);
        
    }];

    
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.circleImage.mas_bottom).offset(-50);
        make.width.equalTo(self.label3.mas_width);
        make.height.equalTo(18);
    }];
    
    
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.bottom.equalTo(self.headerView.mas_bottom).offset(-50);
        make.width.equalTo(90);
        make.height.equalTo(30);
    }];
    
    

 }
#pragma mark ------------------------------------------------------------------Actions  Click-----------------------------------------------------------

- (void)addButtonClick
{
    //创建弹框
    AddPressureDataVC *pressure = [AddPressureDataVC new];//初始化弹框
    pressure.preferredContentSize = CGSizeMake( CoreWidth,CoreHeight);//设置弹框的大小
    //弹框消失。
    [pressure setDismissSimanPopoverViewController:^(AddPressureDataVC *viewController) {
        [self.simanPopoverController dismissPopoverAnimated:YES completion:^{
            NSLog(@"dismiss");
            [self popoverControllerDidDismissPopover:_simanPopoverController];
        }];
    }];
    
    //确定方法
    
    [pressure setSureBlock:^{
        NSLog(@"sure");
    }];
    self.simanPopoverController = [[WYPopoverController alloc] initWithContentViewController:pressure];
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

- (void) centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state != CBCentralManagerStatePoweredOn) {
        self.label1.text = @"请打开手机的蓝牙";
        return;
    }
    
    [self scan];
    
}

- (void)scan
{
    [self.centralManager scanForPeripheralsWithServices:nil
                                                options:@{CBCentralManagerScanOptionAllowDuplicatesKey :@YES}];
}



//3连接外围设备
//当外围设备广播同样的UUID信号被发现时，这个代理函数被调用。这时我们要监测RSSI即Received Signal Strength Indication接收的信号强度指示，确保足够近，我们才连接它
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    self.label1.text = @"正在连接蓝牙设备...";
    if (self.discoveredPeripheral != peripheral)
    {
        self.discoveredPeripheral = peripheral;
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}


//4扫描服务和特征
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    
    [self.centralManager stopScan];
    //确保我们收到的外围设备连接后的回调代理函数
    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
    
}

//5 发现服务 /相当于对方的账号
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    NSLog(@"5");
    if (error) {
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
        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID1],[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID2]] forService:server];
        
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
            NSLog(@"订阅成功");
            
        }
        
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID2] ])
        {
            
            //如果第一个参数是yes的话，就是允许代理方法peripheral:didUpdateValueForCharacteristic:error: 来监听 第二个参数 特性是否发生变化
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            //完成后，等待数据传进来
            NSLog(@"订阅成功");
            
        }
    }
    
    
}



//这个函数类似网络请求时候只需收到数据的那个函数
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    self.label1.text = @"连接成功";
    NSLog(@"收到的数据：--------%@",characteristic.value);
    NSLog(@"收到数据长度  %lu",(unsigned long)characteristic.value.length);
    
    
    
    //处理蓝牙发送过来的数据
    if (error)
    {
        NSLog(@"无法获取数据");
        return;
    }
    if (characteristic.value.length == 7) {
        Byte *byte0 = (Byte *)[characteristic.value bytes];
        NSMutableString *string = [[NSMutableString alloc]init];
        [string appendFormat:@"%x",byte0[4]&0xff];
        self.labelPul.text = [NSString stringWithFormat:@"%lu",strtoul([string UTF8String],0 ,16)];
    }
    
    if (characteristic.value.length == 8) {
        Byte *byte0 = (Byte *)[characteristic.value bytes];
        
        NSMutableString *string = [[NSMutableString alloc]init];
        [string appendFormat:@"%x",byte0[3]&0xff];
        [string appendFormat:@"%x",byte0[4]&0xff];
        [string appendFormat:@"%x",byte0[5]&0xff];
        
        
        NSString *height = [string substringWithRange:NSMakeRange(0, 2)];
        NSLog(@"16高压 = %@",height);
        NSLog(@"10高压 = %@",[NSString stringWithFormat:@"%lu",strtoul([height UTF8String],0 ,16)]);
        self.label2High.text = [NSString stringWithFormat:@"%lu",strtoul([height UTF8String], 0, 16)];
        
        
        NSString *low = [string substringWithRange:NSMakeRange(2, 2)];
        NSLog(@"低压 = %@",low);
        NSLog(@"10低压 = %@",[NSString stringWithFormat:@"%lu",strtoul([low UTF8String],0 ,16)]);
        self.label2Low.text = [NSString stringWithFormat:@"%lu",strtoul([low UTF8String], 0, 16)];
        
        
        NSString *pul = [string substringWithRange:NSMakeRange(4, 2)];
        NSLog(@"PUL = %@",pul);
        NSLog(@"10PUL = %@",[NSString stringWithFormat:@"%lu",strtoul([pul UTF8String],0 ,16)]);
        self.labelPul.text = [NSString stringWithFormat:@"%lu",strtoul([pul UTF8String],0 ,16)];
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
