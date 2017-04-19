//
//  ConsultingChat.m
//  Mamabao
//
//  Created by Michael on 15/11/14.
//  Copyright © 2015年 Michael. All rights reserved.
//






/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "ConsultingChat.h"
#import "ASPhotoView.h"
#import "ASSecondView.h"
#import "UIView+ASPhotoCategory.h"
#import "QBImagePickerController.h"

#import "ConsultingChatPingJiaVC.h"

#import "QuestionCell.h"                //问题Cell
#import "MyDetailCell.h"
#import "MyDetailImageCell.h"
#import "ASConsultMeMp3TableViewCell.h"
#import "OtherDetailCell.h"
#import "OtherImageCell.h"
#import "ASConsultDoctorMp3TableViewCell.h"
#import "MyDetailModel.h"


static NSString *identifierRight = @"rightCell";
static NSString *myCellIdentifier = @"myCell";
static NSString *myMP3CellIdentifier = @"myMP3Cell";
static NSString *myImageCellIdentifier = @"rightDetailImageCell";
static NSString *otherDetailID = @"otherDetailCell";
static NSString *otherDetailMp3ID = @"otherDetailMp3Cell";
static NSString *otherDetailImageID = @"otherDetailImageCell";

@interface ConsultingChat ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,QBImagePickerControllerDelegate>
@property (nonatomic, strong) NSDictionary *questionDic;
@property (nonatomic, strong) NSDictionary *detailDic;
@property (nonatomic, strong) NSMutableArray *detailArray;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) TTTAttributedLabel *nameLabel;
@property (nonatomic, strong) TTTAttributedLabel *hospitalLabel;
@property (nonatomic, strong) TTTAttributedLabel *keShiLabel;
@property (nonatomic, strong) TTTAttributedLabel *yiShiLabel;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UITextField *textTF;
@property (nonatomic, strong) UIButton *addImageButton;
@property (nonatomic, strong) UIButton *replyButton;
@property (nonatomic, assign) BOOL isYuYin;
@property (nonatomic, strong) UIButton *anZhuButton;
@property (nonatomic, strong) ASPhotoView *photoView;
@property (nonatomic, strong) ASSecondView *secondView;
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, assign) NSInteger flag;               //0：医院问诊  1:医生问诊
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) UIBarButtonItem *right;

@end


@implementation ConsultingChat


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
        
        self.right = [[UIBarButtonItem alloc] initWithTitle:@"评价" style:UIBarButtonItemStylePlain target:self action:@selector(rightCLicked)];
        self.navigationItem.rightBarButtonItem = self.right;   ///医生回复了才有评价，医生没有回复没有评价
        self.right.tintColor = KHexColor(@"#ffffff");
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"咨询记录";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.imageArray =[NSMutableArray array];
    self.detailArray = [NSMutableArray array];
    [self makeUI];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = KHexColor(@"#f4f4f4");
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
    //[_tableView registerNib:[UINib nibWithNibName:@"ASConsultMeMp3TableViewCell" bundle:nil] forCellReuseIdentifier:myMP3CellIdentifier];
    
    self.secondView = [[ASSecondView alloc]initWithFrame:self.view.bounds];//阴影视图
    MP3 = [[Mp3Recorder alloc]initWithDelegate:self];//init MP3
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
    [self.secondView addGestureRecognizer:tap];
    [self makeBottomView];
    [self requestData];
}
//隐藏键盘手势
-(void)backTap:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
    if(self.view.frame.origin.y == -100+64)
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.frame = CGRectMake(0, self.view.frame.origin.y+100, kSCREEN_WIDTH, self.view.frame.size.height);
        }];
    }
}

- (void)keyboardChange:(NSNotification *)noti
{
    NSValue *value = [noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [value CGRectValue];
    self.bottomView.frame = CGRectMake(0, rect.origin.y-60, CoreWidth, 60);
    
}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------

- (void)sectionButtonClick
{
    
}
- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightCLicked
{
    ConsultingChatPingJiaVC *pin = [ConsultingChatPingJiaVC new];
    pin.detailId = self.detailId;
    [self.navigationController pushViewController:pin animated:YES];
}

- (void)replyButtonClick:(UIButton *)button
{
    if (self.isYuYin == YES) {
        [self.view endEditing:YES];
        [self.replyButton setBackgroundImage:[UIImage imageNamed:@"jianpan"] forState:UIControlStateNormal];
        self.textTF.placeholder = @"";
        self.isYuYin = NO;
        [self anZhuShuoHua];

    }
    else
    {
        
        [self.anZhuButton removeFromSuperview];
        [self.replyButton setBackgroundImage:[UIImage imageNamed:@"yuyin"] forState:UIControlStateNormal];
        self.textTF.placeholder = @"请描述您的问题";
        self.isYuYin = YES;
    }
}

#pragma mark ------------------------------------------------------------------ QBImagePickerControllerDelegate--------------------------------
- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(ALAsset *)asset
{
    ALAssetRepresentation* representation = [asset defaultRepresentation];
    UIImage* rti =  [UIImage imageWithCGImage:representation.fullScreenImage];
    [self.imageArray removeAllObjects];
    [self.imageArray addObject:rti];
    self.tabBarController.tabBar.hidden = YES;
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
    [imagePickerController removeFromParentViewController];
    
    //    [self creatCon];
    [self upload];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    self.tabBarController.tabBar.hidden = YES;                  //返回view有tabbar
    [picker dismissViewControllerAnimated:YES completion:nil];
    [picker removeFromParentViewController];
}

-(void)upload    ///上传图片
{
    [ASLoadingView showActivity:self.view];
    [ASURLConnection requestImage:@{@"win":@1} method:kUploadImg version:@"" img:self.imageArray name:@"file_url" completeBlock:^(NSData *data, id responseObject) {
        [ASLoadingView hidenActivity:self.view];
        
        if ([[ASURLConnection getMsg:responseObject]isEqual:@1])
        {
            NSDictionary *dic = AFNdata[0];
            NSString *str  = [dic objectForKey:@"imageList"];
            NSDictionary *json = @{@"problem_id":[NSNumber numberWithInteger:self.detailId],
                                   @"content":@"",
                                   @"file_url":str,
                                   @"length":@"",
                                   @"talker":@0};
            [self addConsult:json];
        }
        else
        {
            k_NSlogHUD([ASURLConnection getMessage:responseObject])
        }
    } errorBlock:^(NSError *error) {
        [ASLoadingView hidenActivity:self.view];
    }];
}
-(void)addConsult:(NSDictionary *)dic //上传图片
{
//    NSDictionary *json;
//    if (!dic)
//    {
//        if ([NSString isBlankString:self.textTF.text] == YES)
//        {
//            self.textTF.text = nil;
//            k_NSlogHUD(consultContent)
//            return;
//        }
//        else
//        {
//            [ASLoadingView showActivity:self.view];
//            json = @{@"problem_id":[NSNumber numberWithInteger:self.detailId],
//                     @"content":self.textTF.text,
//                     @"file_url":@"",
//                     @"length":@"",
//                     @"talker":@0};
//        }
//    }
//    else
//    {
//        json = dic;
//    }
    
      
    [ASURLConnection requestAFNJSon:dic method:kContinueConsult view:nil version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        [ASLoadingView hidenActivity:self.view];
        
        if ([[ASURLConnection getMsg:responseObject]isEqual:@1])
        {
            self.textTF.text = nil;
            NSArray *array= AFNdata;
//            if (array.count != 0)
//            {
//                chatModel = [ASConsultChatModel objectWithKeyValues:array[0]];
//            }
//            [self.myTabView reloadData];
//            [self.myTabView layoutIfNeeded];
//            NSIndexPath *path = [NSIndexPath indexPathForRow:chatModel.contentInfo.count - 1 inSection:1];;
//            [self.myTabView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            [self requestData];
        }
        else
        {
            k_NSlogHUD([ASURLConnection getMessage:responseObject])
        }
    } errorBlock:^(NSError *error) {
    }];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSDictionary *json = @{@"problem_id":[NSNumber numberWithInteger:self.detailId],
                           @"content":self.textTF.text,
                           @"file_url":@"",
                           @"length":@"",
                           @"talker":@0};
    [ASURLConnection requestAFNJSon:json method:@"jumper.consultant.continue" view:nil version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        [ASLoadingView hidenActivity:self.view];
        
        if ([[ASURLConnection getMsg:responseObject]isEqual:@1]) {
            self.textTF.text = nil;
//            NSArray *array= AFNdata;
//            if (array.count != 0) {
//                chatModel = [DetailModel objectWithKeyValues:array[0]];
//            }
//            [_tableView reloadData];
//            [_tableView layoutIfNeeded];
//            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:1];;
//            [_tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            [self requestDetail];
           
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject])
            
        }
    } errorBlock:^(NSError *error) {
    }];
    return YES;
}
- (void)anZhuButtonClick:(UIButton *)button
{
    
}

#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0 == section ? 1 : [_detailArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        
        return [QuestionCell heightForRowWithString:self.content];
    }
    else
    {
        MyDetailModel *model = _detailArray[indexPath.row];
        
       
        if ([model.file_url isEqualToString:@""] )
        {
            return [MyDetailCell heightForRowWithStringrightDetail:model.content];
        }
        else if (![model.file_url isEqualToString:@""] && ([model.file_url hasSuffix:@".mp3"] || [model.file_url hasSuffix:@".MP3"]))
        {
            return 90;
        }
        else
        {
            return 110;
        }
    }
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if (indexPath.section == 0)
    {
       
        QuestionCell *rightCell = [tableView dequeueReusableCellWithIdentifier:identifierRight];
        if (nil == rightCell) {
            rightCell = [[QuestionCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifierRight];
        }
        rightCell.rightLabel.text = self.content;
        return rightCell;
    }

    else
    {
        MyDetailModel *contentModel = _detailArray[indexPath.row];  //talker 0 表示我  ，talker 1 表示医生
        if ([contentModel.talker integerValue] == 0) {
            
            if ([contentModel.file_url isEqualToString:@""] )
            {
                
                MyDetailCell *myCell = [tableView dequeueReusableCellWithIdentifier:myCellIdentifier];
                if (nil == myCell) {
                    myCell = [[MyDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:myCellIdentifier];
                }
                myCell.detail = _detailArray[indexPath.row];
                [myCell.iconRightImage sd_setImageWithURL:[NSURL URLWithString:[self.detailDic objectForKey:@"user_image"]] placeholderImage:nil];
                return myCell;
            }
            else if (![contentModel.file_url isEqualToString:@""] && ([contentModel.file_url hasSuffix:@".mp3"] || [contentModel.file_url hasSuffix:@".MP3"]))
            {
                
                ASConsultMeMp3TableViewCell *myMP3Cell ;
                if (myMP3Cell==nil)
                {
                    myMP3Cell=[[[NSBundle mainBundle] loadNibNamed:@"ASConsultMeMp3TableViewCell" owner:nil options:nil]lastObject];
                }
                [tableView dequeueReusableCellWithIdentifier:myMP3CellIdentifier];
                [myMP3Cell.doctorImageView sd_setImageWithURL:[NSURL URLWithString:[self.detailDic objectForKey:@"user_image"]] placeholderImage:DefultPhoto];
                myMP3Cell.contentModel = _detailArray[indexPath.row];
                return myMP3Cell;
            }
            else
            {
                
                MyDetailImageCell *rightDetailImageCell = [tableView dequeueReusableCellWithIdentifier:myImageCellIdentifier];
                if (nil == rightDetailImageCell)
                {
                    rightDetailImageCell = [[MyDetailImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:myImageCellIdentifier];
                }
                [rightDetailImageCell.iconRightImage sd_setImageWithURL:[NSURL URLWithString:[self.detailDic objectForKey:@"user_image"]] placeholderImage:nil];
                rightDetailImageCell.myDetailImageModel = _detailArray[indexPath.row];
                return rightDetailImageCell;
            }
        }
        else if ([contentModel.talker integerValue] == 1)
        {
            if ([contentModel.file_url isEqualToString:@""] )
            {
               
                OtherDetailCell *OtherCell = [tableView dequeueReusableCellWithIdentifier:otherDetailID];
                if (nil == OtherCell) {
                    OtherCell = [[OtherDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:otherDetailID];
                }
                OtherCell.detail = _detailArray[indexPath.row];
                return OtherCell;
            }
            else if (![contentModel.file_url isEqualToString:@""] && ([contentModel.file_url hasSuffix:@".mp3"] || [contentModel.file_url hasSuffix:@".MP3"]))
            {
                
                ASConsultDoctorMp3TableViewCell *myMP3Cell ;
                if (myMP3Cell==nil)
                {
                    myMP3Cell=[[[NSBundle mainBundle] loadNibNamed:@"ASConsultMeMp3TableViewCell" owner:nil options:nil]lastObject];
                }
                [tableView dequeueReusableCellWithIdentifier:otherDetailMp3ID];
                //myMP3Cell.contentModel = _detailArray[indexPath.row];
                return myMP3Cell;
            }
            else
            {
                
                OtherImageCell *otherDetailImageCell = [tableView dequeueReusableCellWithIdentifier:otherDetailImageID];
                if (nil == otherDetailImageCell)
                {
                    otherDetailImageCell = [[OtherImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:otherDetailImageID];
                }
                otherDetailImageCell.myDetailImageModel = _detailArray[indexPath.row];
                return otherDetailImageCell;
            }

        }
       
    }
    return cell;
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1){
        MyDetailModel *contentModel = _detailArray[indexPath.row];
        if ([contentModel.file_url isValid] && ([contentModel.file_url hasSuffix:@".mp3"] || [contentModel.file_url hasSuffix:@".MP3"])) {
            currentIndex = indexPath.row;
            NSMutableArray *array = [[NSMutableArray alloc]init];
            if (oldIndex) {
                if ([contentModel.talker  integerValue]== 0) {
                    ASConsultMeMp3TableViewCell *meMp3Cell = (ASConsultMeMp3TableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:oldIndex inSection:1]];
                    UIImageView *imageView = (UIImageView *)[meMp3Cell.contentView viewWithTag:100 + oldIndex];
                    [imageView stopAnimating];
                }
                if ([contentModel.talker  integerValue] == 1) {
                    ASConsultDoctorMp3TableViewCell *doctorMp3Cell = (ASConsultDoctorMp3TableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:oldIndex inSection:1]];
                    UIImageView *imageView = (UIImageView *)[doctorMp3Cell.contentView viewWithTag:100 + oldIndex];
                    [imageView stopAnimating];
                }
                [audioPlayer stop];
                audioPlayer = nil;
            }
            
            dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(dispatchQueue, ^(void) {
                if (contentModel.talker == 0) {
                     ASConsultMeMp3TableViewCell *meMp3Cell = (ASConsultMeMp3TableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:1]];
                    UIImageView *imageView = (UIImageView *)[meMp3Cell.contentView viewWithTag:100 + indexPath.row];
                    [imageView stopAnimating];
                    for (int i = 0; i < 3 ; i++) {
                        [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"chat_user_voice_%d",i+1]]];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        imageView.animationImages = array;
                        imageView.animationDuration = 0.8;//设置动画时间
                        imageView.animationRepeatCount = 0;//设置动画次数 0 表示无限
                        [imageView startAnimating];//开始播放动画
                    });
                    
                    NSData *mydata=[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:contentModel.file_url]];
                    audioPlayer =[[AVAudioPlayer alloc]initWithData:mydata error:nil];
                    [audioPlayer prepareToPlay];
                    audioPlayer.delegate = self;
                    [audioPlayer play];
                }else{
                    ASConsultDoctorMp3TableViewCell *doctorMp3Cell = (ASConsultDoctorMp3TableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:1]];
                    UIImageView *imageView = (UIImageView *)[doctorMp3Cell.contentView viewWithTag:100 + indexPath.row];
                    [imageView stopAnimating];
                    for (int i = 0; i < 3 ; i++) {
                        [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"chat_doctor_voice_%d",i+1]]];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        imageView.animationImages = array;
                        imageView.animationDuration = 0.8;//设置动画时间
                        imageView.animationRepeatCount = 0;//设置动画次数 0 表示无限
                        [imageView startAnimating];//开始播放动画
                    });
                    NSData *mydata=[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:contentModel.file_url]];
                    audioPlayer =[[AVAudioPlayer alloc]initWithData:mydata error:nil];
                    [audioPlayer prepareToPlay];
                    audioPlayer.delegate = self;
                    [audioPlayer play];
                    
                }
            });
            oldIndex = indexPath.row;
        }
        
    }

    
}


#pragma mark ------------------------------------------------------------------ASURLConnection-----------------------------------------------------
- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{@"problem_id":[NSNumber numberWithInteger:self.detailId] } method:@"renh.consultant.getQuestion" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject)
    {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            self.questionDic = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"][0];
            [self backData];
            [self requestDetail];
            [_tableView reloadData];
        }
    } errorBlock:^(NSError *error) {
    }];
    
    
}
- (void)backData
{
    self.content = [[self.questionDic objectForKey:@"questionInfo"] objectForKey:@"content"];
}
- (void)requestDetail
{
    [ASURLConnection requestAFNJSon:@{@"problem_id":[NSNumber numberWithInteger:self.detailId]} method:@"renh.consultant.getDetail" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            self.detailDic = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"][0];
            NSArray *dataArr = [self.detailDic objectForKey:@"contentInfo"];

            for (int i = 0; i<dataArr.count; i++) {
                MyDetailModel *model = [[MyDetailModel alloc] initWithDictionary:dataArr[i]];
                [self.detailArray addObject:model];
            }
            NSLog(@"==============================%ld",_detailArray.count);
            [_tableView reloadData];
            
        }
    } errorBlock:^(NSError *error) {
    }];
}


#pragma mark ------------------------------------------------------------------Photoes Actions-----------------------------------------------------------
-(void)dismissView{
    
    [self.secondView removeFromSuperview];
    
}
- (void)addImageButtonClick:(UIButton *)button
{
    [self.view endEditing:YES];
    self.photoView = [[ASPhotoView alloc]init];
    [self.photoView.takePhotoButton addTarget:self action:@selector(takePhotos) forControlEvents:UIControlEventTouchUpInside];
    [self.photoView.albumButton addTarget:self action:@selector(takeAlbums) forControlEvents:UIControlEventTouchUpInside];
    self.photoView.frame = CGRectMake(0, kSCREEN_HEIGHT - 120, kSCREEN_WIDTH, 120);
    
    UITapGestureRecognizer *canceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide:)];
    [self.secondView addGestureRecognizer:canceTap];
    [[UIApplication sharedApplication].keyWindow addSubview:self.secondView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.photoView];
    [self.photoView showAnimation];
    
}
-(void)hide:(UITapGestureRecognizer *)tap{
    [self.photoView hideAnimation];
    [self.secondView removeFromSuperview];
}
- (void)takePhotos {
    UIImagePickerController *pPicker = [[UIImagePickerController alloc] init];
    pPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    pPicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    pPicker.delegate = self;
    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
    pPicker.mediaTypes = mediaTypes;
    [self presentViewController:pPicker animated:YES completion:nil];
    [self.photoView hideAnimation];
    [self.secondView removeFromSuperview];
    
}
- (void)takeAlbums {
    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = NO;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:NULL];
    [self.photoView hideAnimation];
    [self.secondView removeFromSuperview];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //返回view有tabbar
    self.tabBarController.tabBar.hidden = YES;
    [picker dismissViewControllerAnimated:YES completion:nil];
    [picker removeFromParentViewController];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageArray removeAllObjects];
    
    [self.imageArray addObject:image];
    //    [self creatCon];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self upload];
        });
    });
    
}

- (void)anZhuShuoHua
{
    
    self.anZhuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.anZhuButton.titleLabel.font = KFontSize(15);
    [self.anZhuButton setTitle:@"按住录音" forState:UIControlStateNormal];
    [self.anZhuButton setTitleColor:KHexColor(@"#999999") forState:UIControlStateNormal];
    [self.anZhuButton addTarget:self action:@selector(beginRecordVoice:) forControlEvents:UIControlEventTouchDown];
    [self.anZhuButton addTarget:self action:@selector(endRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
    [self.anZhuButton addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    [self.anZhuButton addTarget:self action:@selector(RemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [self.anZhuButton addTarget:self action:@selector(RemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];    [self.bottomView addSubview:_anZhuButton];
    
    [_anZhuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textTF.mas_top).offset(0);
        make.left.equalTo(self.textTF.mas_left).offset(0);
        make.right.equalTo(self.textTF.mas_right).offset(0);
        make.bottom.equalTo(self.textTF.mas_bottom).offset(0);
    }];
}

#pragma mark -------------------------------------------------------------------MP3-----------------------------------------
- (void)beginRecordVoice:(UIButton *)button
{
    [MP3 startRecord];
    playTime = 0;
    playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
    hud = [[UUPHUD alloc]initWithFrame:CGRectMake(0,0, 150, 150)];
    [hud makeUI];
    hud.center = self.tableView.center;
    [self.view addSubview:hud];
}
/**
 *  结束音频录制，上传
 *
 *  @param button
 */
- (void)endRecordVoice:(UIButton *)button
{
    if (playTimer && playTime > 0) {
        [MP3 stopRecord];
        [playTimer invalidate];
        playTimer = nil;
        
        [ASLoadingView showActivity:self.view];
        
        [ASURLConnection requestAudio:@{@"win":@1} method:kUploadImg name:@"file_img" completeBlock:^(NSData *data, id responseObject) {
            [ASLoadingView hidenActivity:self.view];
            if ([[ASURLConnection getMsg:responseObject]isEqual:@1]) {
                NSDictionary *dic = AFNdata[0];
                NSString *str  = [dic objectForKey:@"imageList"];
                NSDictionary *json = @{@"problem_id":[NSNumber numberWithInteger:self.detailId],
                                       @"content":@"",
                                       @"file_url":str,
                                       @"length":[NSString stringWithFormat:@"%d",(int)playTime],
                                       @"talker":@0};
                [self addConsult:json];
            }else{
                k_NSlogHUD([ASURLConnection getMessage:responseObject])
            }
        } errorBlock:^(NSError *error) {
            [ASLoadingView hidenActivity:self.view];
        }];
        
    }
    if (hud) {
        [hud removeFromSuperview];
    }
}
- (void)cancelRecordVoice:(UIButton *)button
{
    if (playTimer) {
        [MP3 cancelRecord];
        [playTimer invalidate];
        playTimer = nil;
        [hud removeFromSuperview];
    }
}
- (void)RemindDragExit:(UIButton *)button
{
    if (hud) {
        [hud removeFromSuperview];
    }
}
- (void)RemindDragEnter:(UIButton *)button
{
    if (hud) {
        [hud removeFromSuperview];
    }
}
- (void)countVoiceTime
{
    playTime ++;
    if (playTime>=60) {
        [self endRecordVoice:nil];
    }
}

#pragma mark ------------------------------------------------------------------MakeUI--------------------------------------------------------------------
- (void)makeBottomView
{
    
    self.bottomView = [UIView new];
    self.bottomView.layer.borderWidth = 0.5;
    self.bottomView.layer.borderColor = KHexColor(@"#e3e3e3").CGColor;
    self.bottomView.frame = CGRectMake(0, CoreHeight-50, CoreWidth, 50);
    self.bottomView.backgroundColor =  KHexColor(@"#ffffff");
    [self.view addSubview:_bottomView];
    
    self.isYuYin = YES;
    self.replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.replyButton setBackgroundImage:[UIImage imageNamed:@"yuyin"] forState:UIControlStateNormal];
    [self.replyButton addTarget:self action:@selector(replyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:_replyButton];
    
    self.addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addImageButton setBackgroundImage:[UIImage imageNamed:@"hospital_3replay"] forState:UIControlStateNormal];
    [self.addImageButton addTarget:self action:@selector(addImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:_addImageButton];
    
    self.textTF = [UITextField new];
    self.textTF.layer.cornerRadius = 6;
    self.textTF.layer.masksToBounds = YES;
    self.textTF.layer.borderColor = KHexColor(@"#bbbbbb").CGColor;
    self.textTF.layer.borderWidth = 0.5;
    self.textTF.placeholder = @"请描述您的问题";
    self.textTF.returnKeyType = UIReturnKeySend;
    self.textTF.delegate = self;
    self.textTF.font = KFontSize(14);
    [self.bottomView addSubview:_textTF];
    
    
    [_replyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView.mas_centerY).offset(0);
        make.right.equalTo(self.bottomView.mas_right).offset(-10);
        make.width.equalTo(24);
        make.height.equalTo(24);
    }];
    
    
    [_addImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView.mas_centerY).offset(0);
        make.left.equalTo(self.bottomView.mas_left).offset(10);
        make.width.equalTo(24);
        make.height.equalTo(24);
    }];
    
    
    [_textTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView.mas_centerY).offset(0);
        make.left.equalTo(self.addImageButton.mas_right).offset(10);
        make.right.equalTo(self.replyButton.mas_left).offset(-10);
        make.height.equalTo(32);
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTap:)];//隐藏键盘手势
    [self.view addGestureRecognizer:tap];
}
- (void)makeUI
{
    self.headerView = [UIView new];
    self.headerView.backgroundColor = KHexColor(@"#ffffff");
    [self.view addSubview:_headerView];
    
    
    
    self.headerImage = [UIImageView new];
    self.headerImage.image = [UIImage imageNamed:@"replay2"];
    [self.headerView addSubview:_headerImage];
    
    
    self.nameLabel = [TTTAttributedLabel new];
    self.nameLabel.font = KFontSize(15);
    self.nameLabel.textColor = KHexColor(@"#333333");
    self.nameLabel.text = @"王君安";
    [self.headerView addSubview:_nameLabel];
    
    
    self.hospitalLabel = [TTTAttributedLabel new];
    self.hospitalLabel.font = KFontSize(15);
    self.hospitalLabel.textColor = KHexColor(@"#666666");
    self.hospitalLabel.text = @"南山人民医院";
    [self.headerView addSubview:_hospitalLabel];
    
    
    self.keShiLabel = [TTTAttributedLabel new];
    self.keShiLabel.font = KFontSize(15);
    self.keShiLabel.textColor = KHexColor(@"#ff637e");
    self.keShiLabel.text = @"妇科";
    [self.headerView addSubview:_keShiLabel];
    
    
    self.yiShiLabel = [TTTAttributedLabel new];
    self.yiShiLabel.font = KFontSize(15);
    self.yiShiLabel.textColor = KHexColor(@"#ff637e");
    self.yiShiLabel.text = @"主任医师";
    [self.headerView addSubview:_yiShiLabel];
    
    
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"#ff637e");
    [self.headerView addSubview:_line];
    
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.right.equalTo(self.view);
        make.height.equalTo(60);
    }];
    [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerView.mas_centerY).offset(0);
        make.left.equalTo(self.headerView.mas_left).offset(15);
        make.width.equalTo(41);
        make.height.equalTo(41);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImage.mas_top).offset(5);
        make.left.equalTo(self.headerImage.mas_right).offset(10);
        make.width.equalTo(self.nameLabel.mas_width);
        make.height.equalTo(15);
    }];
    [_hospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel.mas_centerY).offset(0);
        make.left.equalTo(self.nameLabel.mas_right).offset(15);
        make.width.equalTo(self.hospitalLabel.mas_width);
        make.height.equalTo(15);
    }];
    [_keShiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.nameLabel.mas_centerX).offset(0);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.width.equalTo(self.keShiLabel.mas_width);
        make.height.equalTo(15);
    }];
    [_yiShiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.keShiLabel.mas_centerY).offset(0);
        make.centerX.equalTo(self.hospitalLabel.mas_centerX).offset(0);
        make.width.equalTo(self.yiShiLabel.mas_width);
        make.height.equalTo(15);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(7.5);
        make.top.equalTo(self.keShiLabel.mas_top).offset(3);
        make.width.equalTo(1);
        make.height.equalTo(14);
        
    }];
}

@end




