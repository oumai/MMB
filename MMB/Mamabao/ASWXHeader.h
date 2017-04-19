//
//  ASWXHeader.h
//  AngelSound
//
//  Created by jumper on 14-12-23.
//  Copyright (c) 2014年 Jumper. All rights reserved.
//

#ifndef AngelSound_ASWXHeader_h
#define AngelSound_ASWXHeader_h
#define BASE_URL @"https://api.weixin.qq.com"
/**
 *  微信开放平台申请得到的 appid, 需要同时添加在 URL schema
 */
#define WXAppId @"wx6b4e648d236bdc9d"

/**
 * 微信开放平台和商户约定的支付密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
#define WXAppKey @""
/**
 * 微信开放平台和商户约定的密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
#define WXAppSecret @""

/**
 * 微信开放平台和商户约定的支付密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
#define WXPartnerKey @""

/**
 *  微信公众平台商户模块生成的ID
 */
#define WXPartnerId @"1232960901"

#define ORDER_PAY_NOTIFICATION @"OrderPayNotification"

#define AccessTokenKey @"access_token"
#define PrePayIdKey @"prepayid"
#define errcodeKey @"errcode"
#define errmsgKey @"errmsg"
#define expiresInKey @"expires_in"


#endif
