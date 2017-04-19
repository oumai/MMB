//
//  ASPay.h
//  AngelSound
//
//  Created by jumper on 15/6/29.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Products : NSObject{
    
@private
    float     _price;
    NSString *_subject;
    NSString *_body;
    NSString *_orderId;
}

@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *orderId;

@end


@protocol ASPayDelegate <NSObject>

//支付宝成功代理方法
-(void)zhifubaoAction;

//微信成功代理方法
-(void)weChatAction;

@end


@interface ASPay : NSObject

@property (nonatomic,strong )id<ASPayDelegate>delegate;

/***微信支付参数***/
@property (nonatomic, copy) NSString *timeStamp;

@property (nonatomic, copy) NSString *nonceStr;

@property (nonatomic, copy) NSString *traceId;

/***参数字典***/
@property (strong , nonatomic)NSDictionary *parmsDic;

/***订单号***/
@property (strong , nonatomic)NSString *orderID;

/***商品描述***/
@property (strong , nonatomic)NSString *orderProject;

/***订单价格***/
@property (strong , nonatomic)NSString *price;


@property (assign)BOOL isFirst;

/**
 *  支付宝
 */
-(void)zhiFuBao:(NSDictionary *)detailDic andOrderId:(NSString *)orderId andOrderProject:(NSString *)orderProject andPrice:(NSString *)price;
/**
 *  微信
 */
- (void)getAccessToken:(NSDictionary *)detailDic andOrderId:(NSString *)orderId andOrderProject:(NSString *)orderProject andPrice:(NSString *)price;
@end
