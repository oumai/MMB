//
//  API.h
//  Mamabao
//
//  Created by Michael on 15/11/23.
//  Copyright © 2015年 Michael. All rights reserved.
//



#ifndef AngelSound_Macro_h
#define AngelSound_Macro_h

#define shareTitle @"天使医生"
//联系客服电话
#define connectTelPhone  @"400-837-3158"
//苹果商店地址，用于更新
#define IturnsStore  @"https://itunes.apple.com/us/app/tian-shi-yi-sheng/id965450544?l=zh&ls=1&mt=8"

//版本号，随时更新
#define kVersion       @"V3.1"
#define kVersionNumber 16
//文本提示内容
#define consultContent @"输入正确内容,医生才能帮您哦"
#define commentDoctor  @"给医生好评吧"

//广告标识，用于赞的唯一标识
#define ADID      [[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""]
//友盟
#define UMENG_APPKEY   @"54d4707afd98c586ee000859"
//shareSDK
#define ShareSDk   @"3e2ab754c9f4"
#define SinaKey    @"536043655"
#define QQKey      @"1103276857"
#define QQSecret   @"DwX1WO3NoAR7CAQG"
#define WeiXinkey  @"wx6b4e648d236bdc9d"
#define WeiXinSecret @"994d34968632fb898412c3eb5763edf5"
#define SinaSecret @"d60720f12caf0f4bee6864a1813a177a"

#define ShareSDkRedirectUrl  @"http://www.jumper.com"

#define kPath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)]objectAtIndex:0];

//录音buffer时间
#define kBufferDurationSeconds 0.5
//Color
#define K_CustomColor(A,B,C) [UIColor colorWithRed:A/255.f green:B/255.f blue:C/255.f alpha:1.0]
#define RGBA(A,B,C,D) [UIColor colorWithRed:A/255.f green:B/255.f blue:C/255.f alpha:D]
#define BaseColor [UIColor colorWithRed:255.0/255.f green:110.0/255.f blue:127.0/255.f alpha:1.0] //项目基色


#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define k_RequestTime 10
#define k_NetworkError @"网络出错"
//NSUserDefalut

#define userDate  @"userexpectDate"
#define userStatue @"userStatue"
#define userBabyDate @"babyBirthday"

#define userBabySex  @"babySex"

#define NSUserDefalutsGetStringForKey(__key__) [[NSUserDefaults standardUserDefaults] stringForKey:__key__]

#define NSUserDefaultsInstance [NSUserDefaults standardUserDefaults]

#define NSUserDefalutsSynchronize() [NSUserDefaultsInstance synchronize]

#define NSUserDefalutsSetObjectForKey(__value__ , __key__) [NSUserDefaultsInstance setObject:__value__ forKey:__key__]


#define MAXSIZE        CGSizeMake(296,MAXFLOAT)
//NSLOG
#define k_NslogDesData  NSLog(@"%@",[ASURLConnection doDESDecrypt:responseObject]);
#define k_NslogError                                 NSLog(@"%@",@"连接失败,请检查网络");
//HUD
//#define k_NSlogHUD(string) [AFMInfoBanner showAndHideWithText:string style:AFMInfoBannerStyleInfo];
#define k_NSlogHUD(string)  [ASLoadingView showString:string andView:self.view];
#define k_SVprogressHUD  [SVProgressHUD show];
#define k_SVprogressDisMiss [SVProgressHUD dismiss];
//默认头像
#define DefultPhoto [UIImage imageNamed:@"avatar_female-1"]

//////////////////////////////////////////////////////////////////////////////API/////////////////////////////////////////

#define AFNdata   [[[ASURLConnection doDESDecrypt:responseObject]objectFromJSONString]objectForKey:@"data"]

#define kGetHomeDetail        @"jumper.healthy.index.gethealthychange" //获取首页信息

//获取孕期产检数组
#define kGetExaminaList               @"jumper.healthy.antenatal.getExaminaList"

//获取课程信息
#define kGetCourse           @"jumper.healthy.antenatal.getcourse"

//获取检测历程
#define kGetCheckRecordList  @"jumper.healthy.antenatal.getpregentlist"

//完善个人信息
/*
 "user_id=用户ID号\n"
 "real_name=用户真实姓名\n" +
 "age=年龄\n" +
 "identification=身份证号\n" +
 "contact_phone=电话号码\n",
 */
#define kFinishUserInfomation @"jumper.user.information.perfectpersonalinfo"

//获取我的消费记录
/*
 user_id
 page_size
 page_index
 */
#define kGetMySpendingList    @"jumper.user.consumption.getlist"


#define kThirdLogin           @"jumper.user.thirdlogin"        //第三方登录

#define kRegister             @"jumper.user.information.add"      //注册用户

#define kUpdateUserInfo       @"update_user_info"        //更新信息



#define kUpdateUserPassWord   @"update_user_pwd"         //更新用户密码

#define kUpdateUserChildBirth @"update_user_fetation"    //更新用户预产期

#define kUserBack             @"user_feedback"           //用户反馈

#define kMessageStatus        @"set_msg_status"          //消息提醒设置

#define kGetUserInfo          @"get_user_info"           //获得用户信息

#define kGetDetailMessage     @"get_push_msg_detail"     //获取推送消息详情

#define kGetDeviceList        @"get_device_list"         //获取设备列表

#define kGetAppVersion        @"get_app_version"         //获取app版本信息

#define kGetBabyChange        @"get_pregnant_change"     //获取宝宝每周变化



#define kActiveDevice         @"active_device"           //激活设备

#define kGetSearchHeartInfo   @"get_search_fetal_heart"  //获取胎心信息



//获取推送消息列表
/**
 user_id=用户ID号
 page_size=分页大小
 page_index=分页索引
 */
#define kGetPushMessageList   @"jumper.user.pushmessage.getlist"

#define kUploadImg        @"jumper.interaction.image.upload"            //上传图片

#define kGetAd            @"jumper.promotion.home.get"                  //获取首页广告地址



//pae_id=产检ID 获取产检详细信息
#define kGetPregaancyDetail  @"jumper.healthy.antenatal.getExaminaObjctList"

//获取妈妈变化信息 week
#define kGetMomChangeInfo    @"jumper.healthy.antenatal.getmotherchangelist"

////////////////////////////////////////////////////////////////////////////////胎心////////////////////////////////////////////////////////////////

#define kGetUserRecordList    @"get_user_record_list"    //获取胎心记录列表

#define kdeleteRecord         @"delete_fetalheart_record"//删除云端记录

#define kUploadRecord         @"upload_fetalheart_record"//上传记录

#define kDeleteRecord         @"delete_fetalheart_record"//删除记录

/**
 * 用户点击胎心录制按钮，后台记录用户点击事件
 "user_id=记录ID号(可不传或为0)\n"+
 "type=测试类型:0：胎心1：血氧2：温度\n",
 */
#define kSaveClick            @"jumper.record.heartrate.save"
////////////////////////////////////////////////////////////////////////////////医院////////////////////////////////////////////////////////////////
//医院

#define kGetHotList        @"jumper.hospital.doctor.hotlist.get"

//获取医生详情
/**
 "doctor_id=医生ID号\n"+
 "user_id=用户ID号",
 */
#define kGetDoctorDetail  @"jumper.hospital.doctor.detail.get"

//获取医院详情
/**
 hospital_id
 */
#define kGetHospitalDetail @"jumper.hospital.hospital.getdetail"

//获取用户关注医生列表
/**
 "user_id=用户ID号\n"+
 "page_index=分页索引\n"+
 "page_size=分页大小\n",
 */
#define kGetMyDoctorCareList  @"jumper.hospital.doctor.interest.getlist"

//关注医生
/**
 "user_id=用户ID号\n"+
 "doctor_id=医生ID号\n",
 */
#define kCareDoctor       @"jumper.hospital.doctor.interest.add"

//取消关注医生
/**
 "user_id=用户ID号\n"+
 "doctor_id=医生ID号\n",
 */
#define kCancleDoctor     @"jumper.hospital.doctor.interest.delete"

//获取用户评论列表
/**
 "doctor_id=医生ID号\n"+
 "page_index=分页索引\n"+
 "page_size=分页大小\n",
 */
#define kGetUserComment   @"jumper.hospital.doctor.comments.get"

//调出春雨医生咨询界面
/**
 *"user_id=用户ID号(必填)\n"
 */
#define kAddSpringConsult  @"jumper.hospital.spring.consultant.add"
//调出春雨咨询的咨询记录
#define kGetSpringRecord   @"jumper.hospital.spring.consultant.getlist"




//获取找医生默认界面列表
/**
 city_name=城市名称(可不填)
 hospital_id=医院ID(可不填或为0)
 major_id=科室ID(可不填或为0)
 page_index=分页索引
 page_size=分页大小
 */
#define kGetDoctorList    @"jumper.hospital.doctor.getlist"


//获取医院列表
#define kGetHospitalName  @"jumper.hospital.hospital.getlist"


//获取医生科室列表
//hospital_id=医院ID
#define kGetKeshi         @"jumper.hospital.doctor.major.getlist"


/**
 *天使医生2.0获取所有科室
 */
#define kGetAllMajor @"jumper.hospital.doctor.major.getAllMajor"
//天使医生2.0搜索医生
/**
 "province_id=省份ID\n"+
 "city_id=城市ID\n"+
 "major_id=科室ID\n"+
 "page_index=分页索引\n"+
 "page_size=分页大小\n",
 */
#define kSearchOrderDoctor @"jumper.hospital.doctor.appointSearchDoctor"

//天使医生2.0获取用户报告列表
/*
 "user_id=用户Id"+
 "page_index=分页索引\n"+
 "page_size=分页大小\n",
 */
#define kGetUserReportList @"jumper.hospital.eletronic.getEletronicList"


//天使医生2.0获取用户电子病历类型
#define kGetReportType   @"jumper.hospital.eletronic.getType"

//天使医生2.0上传用户电子病历图片
/**
 "user_img=用户头像(base64或者文件形式上传)"+
 "file_name=文件名字",
 */
#define kUploadReportImage @"jumper.hospital.eletronic.uploadEletronicImg"

//天使医生2.0用户添加电子病历
/**
 "user_id=用户ID\n"+
 "type_id=类型ID\n"+
 "check_time=就趁时间\n"+
 "check_result=就诊结果\n"+
 "check_image=诊断图片\n",
 */
#define kAddReport @"jumper.hospital.eletronic.add"

//天使医生2.0删除用户电子病历记录
/**
 "record_id=记录Id",
 */
#define kDeleteReport @"jumper.hospital.eletronic.deleteEletronic"

//预约
/**
 "user_id=用户ID\n"+
 "doctor_id=医生ID\n" +
 "appoint_time=预约开始时间\n"+
 "appoint_end_time=预约结束时间\n",
 */
#define kAddOrder @"jumper.doctor.appoint.addAppoint"




//天使医生2.0 删除预约订单
#define kDeleteOrderHistory @"jumper.doctor.appoint.deleteAppoint"



//天使医生2.0 支付后获取信息
//order_id=订单ID
#define kGetOrderFinishInfo @"jumper.doctor.appoint.getAppointDoctorInfo"

//私人医生详细信息
//doctor_id
#define kGetPrivateDetail  @"jumper.hospital.private.getdetail"

//私人医生支付单号获取
/**
 user_id=用户Id
 service_id=服务Id
 type=私人医生购买类型(0：周，1：月)
 cost=费用
 */
#define kGetPrivateOrder @"jumper.hospital.private.buyservice"



//图文咨询详细信息
#define kGetConsultPayDetail @"jumper.hospital.consult.getdetail"

//图文咨询订单
/*
 user_id=用户Id
 service_id=服务Id
 cost=费用
 */
#define kGetConsultPayOrder   @"jumper.hospital.consult.buyservice"




//搜索医生列表
/**
 "content=医生名字\n"+
 "page_index=分页索引\n"+
 "page_size=分页大小\n",
 */
#define kSearchDoctor     @"jumper.hospital.doctor.search"

//添加咨询
/**
 group_id=咨询ID号(可为空：继续咨询的时候为咨询的ID，不继续咨询责不填写)
 user_id=用户ID号(选填，继续咨询则不填)
 major_id=科室ID(选填，继续咨询则不填)
 doc_id=医生ID(可为空)(选填，继续咨询则不填)
 age=年龄(选填，继续咨询则不填或为0)
 content=咨询内容(0~1000)(必填)
 file_img=图片(可为空,POST)
 type=图片、语音(0:图片；1：语音)
 length=音频时长(图片：0)
 free_type=是否付费(0：免费，1：付费，2：私人医生)
 pay_consult_id=付费购买记录ID
 */



//获取问题类型列表
#define kGetProblemTypes   @"jumper.medical.question.getalltype"


//获取该类型的问题列表
/**
 "type=(问题类型)\n"+
 "page_index=分页索引\n"+
 "page_size=分页大小\n",
 */
#define kGetProblemList   @"jumper.medical.question.getquestionlist"


#define kGetConsultList   @"jumper.hospital.consultant.getlist"         //请求咨询列表








#define kGetMomHotSearch  @"jumper.interaction.post.hotsearchkeyword"   //获取热门搜索

/*
 keywords=关键字
 page_index=分页索引
 page_size=分页大小
 */
#define kGetHotMomSearchDetail @"jumper.interaction.post.searchpost"      //获取热门列表

#define kGetMomCircle     @"jumper.interaction.post.getcategory"        //请求妈妈圈首页

#define kGetMomComList    @"jumper.interaction.post.getlist"            //请求妈妈圈列表

#define kGetHeadDetail    @"jumper.interaction.post.getdetail"          //请求详情

#define kGetReplayList    @"jumper.interaction.post.getreplylist"       //请求回复列表

#define kAddMomCilcle     @"jumper.interaction.post.add"                //添加妈妈圈

#define kReplyContent     @"jumper.interaction.post.reply"              //添加评论

#define kAddFavorites     @"jumper.interaction.post.addfavorites"       //添加收藏

#define kDeleteFavorite   @"jumper.interaction.post.deletefavorites"    //删除收藏

#define kgetFavoriteList  @"jumper.interaction.post.getfavoriteslist"   // 获取收藏列表

#define kgetMyPostList    @"jumper.interaction.post.getmypostlist"      //获取自己的发帖

#define kDeletePost       @"jumper.interaction.post.delete"             //删除自己的帖子

#define kReport           @"jumper.interaction.post.report"             //举报


//获取个人帖子回复列表
/*user_id=20
 page_index=1
 page_size=10
 */
#define kGetOwnReplayNoti @"jumper.interaction.post.getmypostreplylist"

//删除个人帖子回复列表
#define kDeleteReplayNoti @"jumper.interaction.post.deletemypostreply"

//删除个人所有帖子回复列表

#define kDeleteAllRepalyNoti @"jumper.interaction.post.deleteallreply"

#define kGetMoodList      @"jumper.interaction.mood.get"                //请求心情日志列表

#define kAddMood          @"jumper.interaction.mood.add"                //添加心情

#define kDeleteMood       @"jumper.interaction.mood.delete"             //删除心情日志

#define kGameBaby         @"jumper.fungames.get"                        //宝贝合成

#define kGetDayData       @"jumper.record.heartrate.getdaylist"         //获取天数据

#define kGetSingleWeek    @"jumper.record.heartrate.getsingleweeklist"  //获取单周数据

#define kGetWeeksData     @"jumper.record.heartrate.getweekintervallist"//获取周数据

#define kGetCustomDayData @"jumper.record.heartrate.getdayintervallist" //获取自定义数据



#define kGetOderDetail    @"jumper.shop.getorder"                       //获取订单信息


////////////////////////////////////////////////////////////////////////////////解读API////////////////////////////////////////////////////////////////
#define kGetBChao         @"jumper.interpretation.bultrasonicinterpretation.initlist" //获取默认内容

//keywords=关键字
#define kGetSpeciBChao    @"jumper.interpretation.bultrasonicinterpretation.search"//获取搜索内容




////////////////////////////////////////////////////////////////////////////////资讯////////////////////////////////////////////////////////////////

//请求资讯类型
#define kGetNewsTypes     @"jumper.news.chanel.getList"

//请求新闻详情
/**
 news_id=新闻ID
 user_id=用户ID
 */
#define kGetNewsDetail    @"jumper.news.news.newsDetail"

//获取频道下新闻信息
/**
 user_id=用户ID(若用户未登陆，请传入0或空)
 
 "chanel_id=频道ID号\n"+
 "page_index=分页索引\n"+
 "page_size=分页大小\n",
 */
#define kGetNews          @"jumper.news.chanel.getNewsList"

//获取专题信息
/**
 *"page_index=分页索引\n"+
 "page_size=分页大小\n",
 */
#define kGetTopNews      @"jumper.news.topic.getTopicList"

//获取专题列表信息
/**
 *"user_id=用户ID(若用户未登陆，请传入0或空)\n"+
 "topic_id=专题ID\n"+
 "page_index=分页索引\n"+
 "page_size=分页大小\n",
 */
#define kGetTopNewsList  @"jumper.news.topic.getNewsList"

//添加用户收藏
/**
 "user_id=用户ID\n"+
 "news_id=新闻ID\n",
 */
#define kAddNewsCollect                  @"jumper.news.collection.addCollection"

//删除用户收藏
/**
 "user_id=用户ID\n"+
 "news_id=新闻ID\n",
 */
#define kDeleteNewsCollect           @"jumper.news.collection.removeCollection"

//获取用户收藏
/**
 "user_id=用户ID\n"+
 "page_index=分页索引\n"+
 "page_size=分页大小\n",
 */
#define kGetNewsCollect         @"jumper.news.collection.getCollection"

//获取新闻评论
/**
 "news_id=新闻ID\n"+
 "mobile_sequence=手机唯一序列号\n"+
 "page_index=分页索引\n"+
 "page_size=分页大小\n",
 */
#define kGetNewsComment       @"jumper.news.comment.getCommentList"

//添加评论
/**
 "user_id=用户ID\n"+
 "news_id=新闻ID\n"+
 "parent_id=上级ID(对新闻的回复传0)\n"+
 "content=评论内容\n",
 */
#define kAddNewsComment       @"jumper.news.comment.addComment"

//搜索
/**
 "keyword=关键字\n"+
 "page_index=分页索引\n"+
 "page_size=分页大小\n"
 */
#define kSearchNews         @"jumper.news.news.getSearch"


//添加赞
/**
 "mobile_sequence=手机唯一序列号\n"+
 "comment_id=评论ID\n",
 */
#define kAddPraise       @"jumper.news.comment.addPraise"

////////////////////////////////////////////////////////////////////////////////硬件数据接口////////////////////////////////////////////////////////////////

//请求知识数据
/*
 topic_id=专题ID号
 user_id=用户ID号
 page_size=分页大小
 page_index=分页索引
 */
#define kGetknowledge @"jumper.record.topic.getnewslist"

//添加胎动
/*
 user_id=用户ID号
 fetal_move_value=胎动次数
 fetal_move_time=测试时长
 fetal_move_file=测试文件路径
 */
#define uploadBabyMoveWithUser  @"jumper.record.fetalmove.add"

//胎动列表
/*
 user_id=用户ID号
 page_index=分页索引
 page_size=分页大小
 */
#define kGetBabyMoveData  @"jumper.record.fetalmove.getlist"

//删除胎动数据
//id=记录ID号
#define kDeleteBabyMove   @"jumper.record.fetalmove.delete"

//温度计上传
/*
 user_id=用户ID号
 average_value=测试值
 temperature_state=体温状态(0:偏低 1:正常 2:偏高)
 */
#define kAddTemprestureRecord  @"jumper.record.temperature.add"

//温度计请求
/*
 user_id=用户ID号
 date=日期
 start_time=测试时间
 */
#define kGetTemRequestRecord   @"jumper.record.temperature.getlist"

//血氧请求
/*
 user_id=用户ID
 test_time=测试时间（eg:2015-1-12）
 page_size=分页大小
 page_index=分页索引
 */
#define kGetSpo2Record  @"jumper.record.oxygen.getdata"

//血糖请求
/*
 user_id=用户ID号
 test_time=测试时间
 end_time=结束时间(按周查询时必须，其他类型为空)
 search_type=查看类型(0:天 1:周  2:月)
 */
#define kGetBloodSuger  @"jumper.record.sugar.gethistoryrecord"

//血糖上传
/*
 user_id=用户ID号
 average_value=血糖平均值
 sugar_state=血糖状态(0:偏低 1:正常 2:偏高)
 test_time_state=测试时间状态(0:早餐前 1:早餐后 2:午餐前 3:午餐后 4:晚餐前 5:晚餐后 6.睡前)
 */
#define kAddBloodSuger @"jumper.record.sugar.add"

//身高体重上传
/*
 user_id=用户ID号
 height=身高
 weight=孕前体重
 */
#define kAddUserHeightWeight  @"jumper.user.height.update"

//血压添加
/*
 user_id=用户ID号
 pressure_low=血压低值
 pressure_height=血压高值
 state=血压状态(0:偏低,1:正常,2:偏高)
 test_time=用户测试时间
 */
#define kAddBloodPressure  @"jumper.record.pressure.add"

//血压请求
/*
 user_id=用户ID号
 type=(0:周记录，1:月记录)
 start_time=(周测试记录开始时间)
 end_time=(周测试记录结束时间)
 month_time=(月测试记录时间)
 */
#define kGetBloodPressure  @"jumper.record.pressure.getlist"


////////////////////////////////////////////////////////////////////////////////远程接口////////////////////////////////////////////////////////////////


//删除远程监控
//id=监控ID
#define kDeleteRemote  @"jumper.monitor.monitoring.delete"
#endif
