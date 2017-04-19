
//
//  API.h
//  Mamabao
//
//  Created by Michael on 15/11/23.
//  Copyright © 2015年 Michael. All rights reserved.
//

#ifndef API_h
#define API_h

#define myDefaultPDFCircle  @"myDefaultPDFCircle"

#define myDefaultNotiCircle @"myDefaultNotiCircle"

//默认医生头像
#define DefultPhoto                [UIImage imageNamed:@"avatar_female-1"]
//默认用户头像
#define PlaceHoderImage            [UIImage imageNamed:@"avatar_me"]
//默认图片
#define newsHoderImage             [UIImage imageNamed:@"pic_default"]

#pragma 更换用户数据

/**更换用户所有数据**/
#define kNupdateUserData             @"jumper.usercenter.get.userInfo"

#pragma mark Login Register

/**注册用户**/
#define kNRegister                   @"jumper.user.register"

/**判断验证码是否正确**/
#define kPhoneCodeIsRight            @"verifed_code"

/**重置密码**/
#define kResetPassWord               @"reset_user_password"

/**获取电话验证码**/
#define kGetPhoneCode                @"get_sms_code"

/**完善用户注册资料**/
#define kNUpdate                     @"jumper.user.update"

/**用户登录**/
#define kLogin                       @"jumper.user.login"

#pragma mark My

/**第一次安装**/
#define kINstall                    @"jumper.usercenter.install.init"

//获取商铺地址
#define kGetShopUrl                 @"jumper.shop.getshopurl"

/**用户是否签到**/
#define kNIsSign                      @"jumper.usercenter.user.isSign"

#define kNSign                       @"jumper.usercenter.user.signIn"

/**更新用户头像**/
#define kUpdateUserPhoto             @"update_user_image"

/**获取用户咨询**/
#define kNGetConsultRecord    @"jumper.consultant.getlist"


/**获取用户最近订单**/
#define kNGetMyOrderCurrentRecord    @"jumper.usercenter.order.current"

/**获取用户历史订单**/
#define kNGetMyOrderHistoryRecord    @"jumper.usercenter.order.history"

/**获取喜欢列表**/
#define kNGetCollectList             @"jumper.usercenter.news.collection"

/**删除喜欢列表**/
#define kNDeleteCollectList          @"jumper.usercenter.news.deleteCollect"

/**获取关注列表**/
#define kNGetCareList                @"jumper.usercenter.fans.collection"

/**取消关注与关注**/
#define kNCareOrNotcare              @"jumper.usercenter.fans.operation"

/**收索医院列表**/
#define kGetHospitalListByCity       @"jumper.hospital.hospital.getlistbycity"

/**获取省份城市**/
#define kGetProviceCity              @"jumper.helper.country.get"

/**search**/
#define kGetSearchHospital           @"jumper.hospital.hospital.search"

/**请求关联医院**/
#define kNGetComonHospital           @"jumper.hospital.hospital.getcommon"

/**设置关联医院**/
#define kNSetComonHospital           @"jumper.hospital.hospital.setcommon"

/**获取城市列表信息**/
#define kGetProviceList              @"get_prov_and_city"

/**完善用户信息**/
#define kFinishUserInformation       @"jumper.usercenter.update.userInfo"

/**获取我的挂号历史**/
#define kGetGuaHaoHistory            @"jumper.open160.getFamilyYuyue"

/**取消订单**/
#define kCancleOrder                 @"jumper.open160.cancelRegister"

/**获取私人医生历史信息**/
#define kGetPrivateHistory           @"jumper.hospital.private.getlist"

//获取用户预约订单信息
#define kGetOrderHistoryList         @"jumper.hospital.user.getAppointOrder"

#pragma mark Setting

/***用户反馈*/
#define kUserBack                     @"user_feedback"

#pragma mark 天使医院

/***请求医院首页**/
#define kNGetHospitalHomePage         @"jumper.hospital.hospital.homepage"


//type_id=类型ID(1:首页广告,2:医生主页广告)
#define kGetDoctorAd                 @"jumper.hospital.doctor.getAd"

/**
 *	产科中心
 */
#define kPregnantCenterHospital     @"jumper.hospital.hospital.getcommon"  //产科中心 所在的医院基本信息

#define kPreganetCenterDetail       @"jumper.hospital.hospital.getdetail"  //产科中心  医院详情

#define kPregnantCenterEquipment    @"jumper.hospital.hospital.gethospitaldescription"  //产科中心  环境设备

#define KPreganetCenterDoctor       @"jumper.hospital.doctor.getlist"  //产科中心   医生简介
/**
 *	搜索
 */
#define kGetHotSearchWords          @"jumper.interaction.post.hotsearchkeyword"

#define KSearchResultJ              @"jumper.news.news.getSearch"

/**
 *	检查报告
 */
#define kGetPregnantCheckList       @"jumper.hospital.eletronic.geteletronichomepage"  //获取列表
#define kGetMedicalType             @"jumper.hospital.eletronic.getType"   //获得电子病历类型

#pragma mark 音乐
#define kGetMusicList               @"jumper.classroom.music.getMusicList"   //检查报告

/**
 *	预约挂号
 */
#define k160GetHospital @"jumper.open160.getHospital"    //输入城市id 返回城市
#define k160GetMajor @"jumper.open160.getMajor"    //获取科室
#define k160GetDoctor @"jumper.open160.getDoctor"  //获取Doctor
#define k160GetDoctorDetail @"jumper.open160.getDoctorDetail"   //获取医生详情
#define k160SetOrder @"jumper.open160.setOrder"   //提交订单
#define kGetProAndCity  @"jumper.open160.getProvCity"

/**添加咨询**/
#define kAddConsult                   @"jumper.consultant.add"

/**继续咨询**/
#define kContinueConsult             @"jumper.consultant.continue"

/**继续医院咨询**/
#define kContinueHospitalConsult     @"jumper.hospital.hospconsultant.continue"

/**请求咨询详情**/
#define kGetConsultDetail            @"jumper.consultant.getdetail"

/**请求医院咨询详情**/
#define kGetHospitalConsultDetail    @"jumper.hospital.hospconsultant.getdetail"

/**请求咨询问题以及状态**/
#define KGetConsultQuestion          @"jumper.consultant.getquestion"

/**请求医院咨询问题以及状态**/
#define kGetHospitalConsultQuesyion  @"jumper.hospital.hospconsultant.getquestion"


//添加医生的评论
#define kAddCommentToDoctor          @"jumper.hospital.doctor.comments.add"

//添加医院医生评论
#define kAddHospitalComment          @"jumper.hospital.hospconsultant.comments"

//删除咨询
#define kDeleteConsult               @"jumper.consultant.delete"

//删除医院问诊咨询
#define kDeleteHospitalConsult       @"jumper.hospital.hospconsultant.delete"

/**私人医生中图文咨询验证**/
#define kCheckPrivateConsult         @"jumper.consultant.check"

/**获取历史买过的服务医生**/
#define kGetDoctorHistory            @"jumper.consultant.gethistorydoctorlist"

#pragma mark AngelClass

/**获取首页数据**/
#define kNGetHomePage                @"jumper.classroom.home.getHomePage"

/**获取频道列表信息**/
#define kNGetChannelLIstInfo         @"jumper.classroom.channel.getNewsInfoList"

/**获取频道订阅**/
#define kNGetChannelList             @"jumper.classroom.channel.userChannelList"

/**订阅**/
#define kNChannelBook                @"jumper.classroom.channel.subscribe"

/**取消订阅**/
#define kNCancleChannelBook          @"jumper.classroom.channel.cancelSubscribe"

/**请求新闻详情*/
#define kGetNewsDetail              @"jumper.news.news.newsDetail"

/**分享后调用**/
#define kNShare                     @"jumper.usercenter.news.share"

/**获取新闻评论**/
#define kGetNewsComment             @"jumper.news.comment.getCommentList"

/**添加评论**/
#define kAddNewsComment             @"jumper.news.comment.addComment"

/**宝妈计划列表**/
#define kNGetMomPlanList             @"jumper.classroom.plan.getPlanTaskList"

/**完成任务**/
#define kNFinishTask                 @"jumper.classroom.plan.finish"

/**删除笔记**/
#define kNDeleteNotes                @"jumper.classroom.plan.delete"

/**请求宝妈和宝宝变化**/
#define kNGetMomAndBabyChange        @"jumper.classroom.home.getChange"

/**宝妈计划上传图片**/
#define kNUploadImage                @"jumper.classroom.plan.uploadImage"

/**上传宝妈日记**/
#define kNAddMomDaily                @"jumper.classroom.plan.add"

#pragma mark AngelMonitoring



/**请求远程监控订单**/
#define kNGetRemoteOrder             @"jumper.remote.consumer.getNoFinishOrder"

/**检查用户是否绑定过电话**/
#define kNCheckBind                  @"jumper.remote.order.checkIsBind"

/**获取绑定验证码**/
#define kNGetBindCOde               @"jumper.remote.order.getSmsCode"

/**绑定用户**/
#define kNBindUser                   @"jumper.remote.order.bindOrder"

/**请求排队信息**/
#define kNGetQueue                   @"jumper.remote.consumer.getQueue"

/**请求用户买过的订单**/
#define kNGetOrder                   @"jumper.remote.order.getOrderList"

/**获取常规监控需要上传的数据**/
#define kNCommonMonitorRecord        @"jumper.remote.consumer.getNormalMonitorRecord"

/**添加普通远程监控**/
#define kNAddCommonRemote             @"jumper.remote.consumer.addNormalMonitor"

/**添加实时远程监控**/
#define kNAddTimeRemote              @"jumper.remote.consumer.addLiveMonitor"

/**请求实时监控信息**/
#define kNGetTimeDetail              @"jumper.remote.consumer.getDetail"

/**请求已开通远程监控的城市**/
#define kNGetHospitalCity            @"jumper.remote.hospital.getProvinceAndCity"

/**根据城市请求开通的医院**/
#define kNGetHospitalByCity          @"jumper.hospital.hospital.getlistbycity"

/**报告单**/
#define kGetRemoteFinishOrder        @"jumper.remote.consumer.getOrderList"

/**用户关闭实时监控**/
#define kCloseRemoteByUser           @"jumper.remote.consumer.endMonitor"


//添加远程监控
#define kAddRemote                   @"jumper.monitor.monitoring.add"


//天使医生2.0 支付，获取微信支付信息
//pay_type=1，支付宝；2，微信
#define kGetOrderPayWeChatInfo        @"jumper.shop.getpayparams"

//请求检测项目
#define kGetRemoteProject            @"jumper.monitor.monitoring.getprojectlist"

//请求生成报告
#define kCreatRemoteReport           @"jumper.monitor.monitoring.getreport"

/**请求监控项目**/
#define kNAngelMonitoring            @"jumper.healthy.manage.gethomepage"

//获取监控医院
#define kGetRemoteHospital           @"jumper.monitor.monitorhispital.getall"

/**请求项目**/
#define kNAngelFindTools             @"jumper.healthy.manage.findtools"

/**删除项目**/
#define kNDeletetools                @"jumper.healthy.manage.removetool"

/**添加项目**/
#define kNAddTools                   @"jumper.healthy.manage.addtool"

//获取该类型的问题列表
#define kGetProblemList              @"jumper.medical.question.getquestionlist"

//身高体重上传
#define kAddUserHeightWeight  @"jumper.user.height.update"

#pragma Music
#define kGetMusicList @"jumper.classroom.music.getMusicList"
#define kCurrentMusicIDFROMSQL  @"HYJCurrentMusic"    ////正在播放的音乐 yjid
#define KNetMusicNum  @"HYJNetMusicNum"   //网路歌曲中播放列表有几首歌
#define kisSing @"HYJIsSing"  //是否正在播放
#define kIsCloudMisic   @"cloudMusic"  //  YES是播放本地音乐
#define kIsCircleMusic @"JCircleMusic"    // yes 是循环播放
#define kMusicListRefreash  @"JMusicListRefreash"


#define 孕期建档

/**请求孕期建档状态**/
#define kGetArchivessState            @"jumper.pregnant.userbook.getarchivesstate"
/**同步**/
#define kSyn                          @"jumper.pregnant.userbook.synchronousarchives"
/**提交**/
#define kCommitArchive                @"jumper.pregnant.userbook.commitarchives"


#endif /* API_h */
