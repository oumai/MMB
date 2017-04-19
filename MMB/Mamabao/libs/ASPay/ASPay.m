//
//  ASPay.m
//  AngelSound
//
//  Created by jumper on 15/6/29.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import "ASPay.h"

#import "Order.h"

#import "DataSigner.h"

#import <AlipaySDK/AlipaySDK.h>

#import "CommonUtil.h"

#import "WXApi.h"

@implementation ASPay

- (id)init {
    self = [super init];
    if(self) {
        //微信支付结果通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:ORDER_PAY_NOTIFICATION object:nil];
    }
    return self;
}

/**
 *  支付宝
 */
-(void)zhiFuBao:(NSDictionary *)detailDic andOrderId:(NSString *)orderId andOrderProject:(NSString *)orderProject andPrice:(NSString *)price{
    
    self.isFirst = YES;
    /*
     
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = [detailDic objectForKey:@"pid"];
    NSString *seller = [detailDic objectForKey:@"seller_id"];
    NSString *privateKey = [detailDic objectForKey:@"private_key"];
    
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = orderId; //订单ID（由商家自行制定）
    order.productName = orderProject; //商品标题
    order.productDescription = orderProject; //商品描述
    order.amount = price; //商品价格(long)[self.price integerValue][NSString stringWithFormat:@"%ld",(long)[price integerValue]]
    order.notifyURL = [detailDic objectForKey:@"notify_url"]; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在Info.plist定义URL types
    NSString *appScheme = @"Mamabao";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic)
        {
            NSLog(@"3reslut = %@",resultDic);
            if([[resultDic objectForKey:@"resultStatus"]integerValue] == 9000){
                NSLog(@"ZhiFuBao success");
                [self.delegate zhifubaoAction];
            }
        }];
    }
}

#pragma mark - 主体流程
// 获取token
- (void)getAccessToken:(NSDictionary *)detailDic andOrderId:(NSString *)orderId andOrderProject:(NSString *)orderProject andPrice:(NSString *)price
{
    self.isFirst = YES;
    
    self.parmsDic = detailDic;
    self.orderID = orderId;
    self.price = price;
    self.orderProject = orderProject;
    
    NSString *tokenUrl = @"/cgi-bin/token";
    NSString *requestUrl = [BASE_URL stringByAppendingFormat:@"%@",tokenUrl];
    NSDictionary *param = @{@"grant_type":@"client_credential", @"appid":WXAppId, @"secret":[detailDic objectForKey:@"app_secret"]};
    [ASURLConnection requestGETUrl:requestUrl params:param completeBlock:^(NSData *data, id responseObject) {
        NSString *accessToken = responseObject[AccessTokenKey];
        [self getPrepayId:accessToken];
    } errorBlock:^(NSError *error) {
    }];
}
// 生成预支付订单
- (void)getPrepayId:(NSString *)accessToken
{
    NSString *prepayIdUrl = [NSString stringWithFormat:@"/pay/genprepay?access_token=%@", accessToken];
    NSString *requestUrl = [BASE_URL stringByAppendingString:prepayIdUrl];
    
    // 拼接详细的订单数据
    NSDictionary *postDict = [self getProductArgs];
    [ASURLConnection requestPOSTUrl:requestUrl params:postDict completeBlock:^(NSData *data, id responseObject) {
        
        NSString *prePayId = responseObject[PrePayIdKey];
        // 获取预支付订单id，调用微信支付sdk
        if (prePayId)
        {
            NSLog(@"--- PrePayId: %@", prePayId);
            
            // 调起微信支付
            PayReq *request   = [[PayReq alloc] init];
            request.partnerId = WXPartnerId;
            request.prepayId  = prePayId;
            request.package   = @"Sign=WXPay";
            request.nonceStr  = self.nonceStr;
            request.timeStamp = [self.timeStamp intValue];
            
            // 构造参数列表
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:WXAppId forKey:@"appid"];
            [params setObject:[self.parmsDic objectForKey:@"app_key"] forKey:@"appkey"];
            [params setObject:request.nonceStr forKey:@"noncestr"];
            [params setObject:request.package forKey:@"package"];
            [params setObject:request.partnerId forKey:@"partnerid"];
            [params setObject:request.prepayId forKey:@"prepayid"];
            [params setObject:self.timeStamp forKey:@"timestamp"];
            request.sign = [self genSign:params];
            
            // 在支付之前，如果应用没有注册到微信，应该先调用 [WXApi registerApp:appId] 将应用注册到微信
            [WXApi sendReq:request];
            request = nil;
        }
    } errorBlock:^(NSError *error) {
    }];
}

#pragma mark - 生成各种参数
// 获取时间戳
- (NSString *)genTimeStamp
{
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
}

/**
 *  获取32位内的随机串, 防重发
 *
 *  注意：商户系统内部的订单号,32个字符内、可包含字母,确保在商户系统唯一
 */
- (NSString *)genNonceStr
{
    return [CommonUtil md5:[NSString stringWithFormat:@"%d", arc4random() % 10000]];
}

/**
 *  获取商家对用户的唯一标识
 *
 *  traceId 由开发者自定义，可用于订单的查询与跟踪，建议根据支付用户信息生成此id
 *  建议 traceid 字段包含用户信息及订单信息，方便后续对订单状态的查询和跟踪
 */
- (NSString *)genTraceId
{
    return [NSString stringWithFormat:@"crestxu_%@", [self genTimeStamp]];
}

- (NSString *)genOutTradNo
{
    return [CommonUtil md5:[NSString stringWithFormat:@"%d", arc4random() % 10000]];
}
// 订单详情
- (NSString *)genPackage
{
    // 构造订单参数列表
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"WX" forKey:@"bank_type"];
    [params setObject:self.orderProject forKey:@"body"];
    [params setObject:@"1" forKey:@"fee_type"];
    [params setObject:@"UTF-8" forKey:@"input_charset"];
    [params setObject:[self.parmsDic objectForKey:@"notify_url"] forKey:@"notify_url"];
    [params setObject:self.orderID forKey:@"out_trade_no"];
    [params setObject:WXPartnerId forKey:@"partner"];
    [params setObject:[self.parmsDic objectForKey:@"spbill_create_ip"] forKey:@"spbill_create_ip"];
    [params setObject:[NSString stringWithFormat:@"%d",[self.price integerValue]*100] forKey:@"total_fee"];    // 1 =＝ ¥0.01[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%.f",[self.price doubleValue]*100]]
//    [NSString stringWithFormat:@"%ld",[self.price integerValue]*100];
    NSArray *keys = [params allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    // 生成 packageSign
    NSMutableString *package = [NSMutableString string];
    for (NSString *key in sortedKeys) {
        [package appendString:key];
        [package appendString:@"="];
        [package appendString:[params objectForKey:key]];
        [package appendString:@"&"];
    }
    
    [package appendString:@"key="];
    [package appendString:[self.parmsDic objectForKey:@"partner_key"]]; // 注意:不能hardcode在客户端,建议genPackage这个过程都由服务器端完成
    
    // 进行md5摘要前,params内容为原始内容,未经过url encode处理
    NSString *packageSign = [[CommonUtil md5:[package copy]] uppercaseString];
    package = nil;
    
    // 生成 packageParamsString
    NSString *value = nil;
    package = [NSMutableString string];
    for (NSString *key in sortedKeys)
    {
        [package appendString:key];
        [package appendString:@"="];
        value = [params objectForKey:key];
        
        // 对所有键值对中的 value 进行 urlencode 转码
        value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)value, nil, (CFStringRef)@"!*'&=();:@+$,/?%#[]", kCFStringEncodingUTF8));
        
        [package appendString:value];
        [package appendString:@"&"];
    }
    NSString *packageParamsString = [package substringWithRange:NSMakeRange(0, package.length - 1)];
    
    NSString *result = [NSString stringWithFormat:@"%@&sign=%@", packageParamsString, packageSign];
    
    NSLog(@"--- Package: %@", result);
    
    return result;
}

// 签名
- (NSString *)genSign:(NSDictionary *)signParams
{
    // 排序
    NSArray *keys = [signParams allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    // 生成
    NSMutableString *sign = [NSMutableString string];
    for (NSString *key in sortedKeys) {
        [sign appendString:key];
        [sign appendString:@"="];
        [sign appendString:[signParams objectForKey:key]];
        [sign appendString:@"&"];
    }
    NSString *signString = [[sign copy] substringWithRange:NSMakeRange(0, sign.length - 1)];
    
    NSString *result = [CommonUtil sha1:signString];
    NSLog(@"--- Gen sign: %@", result);
    return result;
}

// 构造订单参数列表
- (NSDictionary *)getProductArgs
{
    self.timeStamp = [self genTimeStamp];   // 获取时间戳
    self.nonceStr = [self genNonceStr];     // 获取32位内的随机串, 防重发
    self.traceId = [self genTraceId];       // 获取商家对用户的唯一标识
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:WXAppId forKey:@"appid"];
    [params setObject:[self.parmsDic objectForKey:@"app_key"] forKey:@"appkey"];
    [params setObject:self.timeStamp forKey:@"noncestr"];
    [params setObject:self.timeStamp forKey:@"timestamp"];//时间戳
    [params setObject:self.traceId forKey:@"traceid"];//商家对用户的唯一标识
    [params setObject:[self genPackage] forKey:@"package"];//订单详情
    [params setObject:[self genSign:params] forKey:@"app_signature"];//签名
    [params setObject:@"sha1" forKey:@"sign_method"];//加密方式
    return params;
}


#pragma mark - 支付结果
- (void)getOrderPayResult:(NSNotification *)notification
{
    if (self.isFirst == YES) {
        if ([notification.object isEqualToString:@"success"])
        {
            NSLog(@"WeChat success: 支付成功");
            [self.delegate weChatAction];
        }
        else
        {
            NSLog(@"fail: 支付失败");
        }
        self.isFirst = NO;
    }
}


@end
