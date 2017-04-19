//
//  OximeterVC.m
//  Mamabao
//
//  Created by Michael on 15/11/17.
//  Copyright © 2015年 Michael. All rights reserved.
//

#define TRANSFER_SERVICE_UUID           @"CDEACB80-5235-4C07-8846-93A37EE6B86D"//本身的发现服务
#define TRANSFER_CHARACTERISTIC_UUID    @"CDEACB81-5235-4C07-8846-93A37EE6B86D"//对方的账号


#import "OximeterVC.h"
#import "OximeterRecordVC.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface OximeterVC ()<CBCentralManagerDelegate,CBPeripheralDelegate>
@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral *discoveredPeripheral;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) TTTAttributedLabel *label1;
@property (nonatomic, strong) TTTAttributedLabel *label2;
@property (nonatomic, strong) TTTAttributedLabel *label3;
@property (nonatomic, strong) UIImageView *circleImage;
@property (nonatomic, strong) UIImageView*lineImage;
@property (nonatomic, strong) TTTAttributedLabel *piLabel;
@property (nonatomic, strong) TTTAttributedLabel *label2Plus;//pulse
@property (nonatomic, strong) TTTAttributedLabel *label3Plus;
@property (nonatomic, strong) UIImageView *circleImagePlus;
@property (nonatomic, strong) UIImageView*lineImagePlus;

@end

@implementation OximeterVC
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
    OximeterRecordVC *oxi = [OximeterRecordVC new];
    oxi.typeRecordString = @"2";
    [self.navigationController pushViewController:oxi  animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"血氧";
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
    [self requestData];
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
    self.circleImage.image = [UIImage imageNamed:@"monitor89"];
    [self.headerView addSubview:_circleImage];
    
    
    self.label2 = [TTTAttributedLabel new];
    self.label2.font = KFontSize(22);
    self.label2.textColor = KHexColor(@"#ff895a");
    [self.headerView addSubview:_label2];
    
    
    self.lineImage= [UIImageView new];
    self.lineImage.image = [UIImage imageNamed:@"monitor88"];
    [self.headerView addSubview:_lineImage];
    
    
    self.label3 = [TTTAttributedLabel new];
    self.label3.font = KFontSize(14);
    self.label3.textColor = KHexColor(@"#333333");
    self.label3.text = @"SPO2";
    [self.headerView addSubview:_label3];
    

    self.piLabel = [TTTAttributedLabel new];
    self.piLabel.font = KFontSize(18);
    self.piLabel.textColor = KHexColor(@"#999999");
    self.piLabel.text = @"PI";//[NSString stringWithFormat:@"PI %@",[NSString stringWithFormat:@"%.1f",pi]];
    [self.headerView addSubview:_piLabel];
    
    
    //pulse
    self.circleImagePlus = [UIImageView new];
    self.circleImagePlus.image = [UIImage imageNamed:@"monitor89"];
    [self.headerView addSubview:_circleImagePlus];
    
      

    self.label2Plus = [TTTAttributedLabel new];
    self.label2Plus.font = KFontSize(22);
    self.label2Plus.textColor = KHexColor(@"#ff895a");
    [self.headerView addSubview:_label2Plus];
    
    
     
    self.lineImagePlus = [UIImageView new];
    self.lineImagePlus.image = [UIImage imageNamed:@"monitor88"];
    [self.headerView addSubview:_lineImagePlus];
    
      
    
    self.label3Plus = [TTTAttributedLabel new];
    self.label3Plus.font = KFontSize(14);
    self.label3Plus.textColor = KHexColor(@"#333333");
    self.label3Plus.text = @"Pulse";
    [self.headerView addSubview:_label3Plus];
    
    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.headerView.mas_top).offset(25);
        make.width.equalTo(self.label1.mas_width);
        make.height.equalTo(14);
    }];
    
    
    [_circleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.label1.mas_bottom).offset(40);
        make.width.equalTo(140);
        make.height.equalTo(140);
    }];
    
    
    
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.circleImage.mas_top).offset(40);
        make.width.equalTo(self.label2.mas_width);
        make.height.equalTo(22);
        
        
    }];
    
    
    [_lineImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.label2.mas_bottom).offset(2);
        make.width.equalTo(37);
        make.height.equalTo(3);
    }];
    
    
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.circleImage.mas_bottom).offset(-30);
        make.width.equalTo(self.label3.mas_width);
        make.height.equalTo(18);
    }];
    
    [_piLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.circleImage.mas_bottom).offset(20);
        make.width.equalTo(self.label3.mas_width);
        make.height.equalTo(18);
    }];
    
    [_circleImagePlus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.circleImage.mas_bottom).offset(60);
        make.width.equalTo(140);
        make.height.equalTo(140);
    }];
    
    
    [_label2Plus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.circleImagePlus.mas_top).offset(40);
        make.width.equalTo(self.label2Plus.mas_width);
        make.height.equalTo(22);
        
        
    }];
    
    [_lineImagePlus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.label2Plus.mas_bottom).offset(2);
        make.width.equalTo(37);
        make.height.equalTo(3);
    }];
    
    [_label3Plus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.top.equalTo(self.circleImagePlus.mas_bottom).offset(-30);
        make.width.equalTo(self.label3Plus.mas_width);
        make.height.equalTo(18);
    }];
    
}
#pragma mark ------------------------------------------------------------------Bluetooth Delegate-----------------------------------------------------------

- (void) centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state != CBCentralManagerStatePoweredOn) {
        NSLog(@"蓝牙关闭");
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
        if ([server.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]])
        {
            
            [peripheral discoverCharacteristics:nil forService:server];
            
            break;
        }
        [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]] forService:server];
        
    }
    
    
    
    
}
//6发现服务中的特性
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    
    if (error)
    {
        NSLog(@"error  %@",[error localizedDescription]);
        return;
    }
    //检查特性
    for (CBCharacteristic*characteristic in service.characteristics)
    {
        NSLog(@"%@",characteristic.UUID);
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID] ])
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
    
    NSLog(@"收到的数据：--------%@",characteristic.value);
    NSLog(@"收到数据长度  %lu",(unsigned long)characteristic.value.length);
    
    
    
    //处理蓝牙发送过来的数据
    if (error) {
        NSLog(@"无法获取数据");
        return;
    }
    
    
    NSMutableString *string=[[NSMutableString alloc]init];
    //体温计
    if (characteristic.value.length==5)
    {
        
        Byte *byte0=(Byte *)[characteristic.value bytes];
        NSLog(@"byte0----------%s",byte0);
        for (int i=1; i<characteristic.value.length; i++)
        {
            if (i==1||i==4)
            {
                int bt=(int)(byte0[i]&0xff);
                NSLog(@"bt%d",bt);
            }
            
            else if(i==2||i==3)
            {
                
                NSString* string0=[NSString stringWithFormat:@"%x",byte0[i]&0xff];
                NSLog(@"sting0%@",string0);
                if (string0.length<2)
                {
                    [string appendFormat:@"0%x",byte0[i]&0xff ];
                    
                    
                    NSLog(@"string0.length<2%@",string);
                    
                }
                else
                {
                    [string appendFormat:@"%x",byte0[i]&0xff ];
                    NSLog(@"string0.length>=2%@",string);
                }
            }
            
        }
        NSLog(@"温度是~~~~%@",string);
        NSLog(@"没有转换%s",[string UTF8String]);
        float a=[[NSString stringWithFormat:@"%lu",strtoul([string UTF8String],0,16)] floatValue]/100;
        NSString *temperString=[NSString stringWithFormat:@"%.1f",a];
        NSLog(@"温度是~~~~~~%.1f",[[NSString stringWithFormat:@"%lu",strtoul([string UTF8String],0,16)] floatValue]/100);
        
    }
    
    //血氧
    if (characteristic.value.length == 4)
    {
        
        Byte *byte0=(Byte *)[characteristic.value bytes];
        
        
        for (int i=1; i<characteristic.value.length; i++)
        {
            
            
            
            
            if (i==1)
            {
                //int bt=(int)(byte0[i]&0xff);
            }
            
            
            else if (i == 2)
            {
                
                [string appendFormat:@"%0x",byte0[1]&0xff];
                NSLog(@"12*******************************%@",string);
                
                [string appendFormat:@"%0x",byte0[2]&0xff];
                NSLog(@"13*******************************%@",string);
                
                [string appendFormat:@"%0x",byte0[3]&0xff];
                NSLog(@"11*******************************%@",string);
                
                //心率
                NSString *a = [string substringWithRange:NSMakeRange(0, 2)];
                NSLog(@"a-------%@",a);
                self.label2Plus.text = [NSString stringWithFormat:@"%lu",strtoul([a UTF8String],0 ,16)];
                NSLog(@"心率是~~~~~~%@",[NSString stringWithFormat:@"%lu",strtoul([a UTF8String],0,16)]);
                //血氧
                NSString *b = [string substringWithRange:NSMakeRange(2, 2)];
                NSLog(@"b-------%@",b);
                self.label2.text = [NSString stringWithFormat:@"%lu",strtoul([b UTF8String], 0, 16)];
                NSLog(@"血氧是~~~~~~%@",[NSString stringWithFormat:@"%lu",strtoul([b UTF8String],0,16)]);
                //PI
                if (string.length == 6)
                {
                    NSString *c = [string substringWithRange:NSMakeRange(4, 2)];
                    NSLog(@"c-------%@",c);
                    float pi=[[NSString stringWithFormat:@"%lu",strtoul([c UTF8String],0,16)] floatValue]/10;
                    self.piLabel.text = [NSString stringWithFormat:@"PI %@",[NSString stringWithFormat:@"%.1f",pi]];
                    NSLog(@"PI是~~~~~~%f",[[NSString stringWithFormat:@"%lu",strtoul([c UTF8String],0,16)] floatValue]/10);
                }
            }
        }
    }
}
- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{} method:@"" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
        
    } errorBlock:^(NSError *error) {
    }];
    
    
}
@end
