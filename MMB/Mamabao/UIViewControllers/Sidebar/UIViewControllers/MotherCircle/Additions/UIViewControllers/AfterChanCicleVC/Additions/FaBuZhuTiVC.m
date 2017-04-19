//
//  FaBuZhuTiVC.m
//  Mamabao
//
//  Created by Michael on 15/12/9.
//  Copyright © 2015年 Michael. All rights reserved.
//

#import "FaBuZhuTiVC.h"

#import "ASPhotoView.h"             //照片
#import "ASSecondView.h"            //照片
#import "UIView+ASPhotoCategory.h"  //照片
#import "QBImagePickerController.h" //照片
#import "UIImage+Image.h"           //照片

@interface FaBuZhuTiVC ()
{
    NSInteger photoNumber; //照片数量
    UITapGestureRecognizer *tapGes;//删除手势
    BOOL isMove;// 判断是否显示删除
}
@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *fontView;
@property (nonatomic, strong) UITextField *titleTF;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *contentBGView;
@property (nonatomic, strong) PlaceholderTextView *contentTV;

@property (nonatomic, strong) UIView *behindView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *imageView0;              //四张照片
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView3;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *deleteButton1;
@property (nonatomic, strong) UIButton *deleteButton2;
@property (nonatomic, strong) UIButton *deleteButton3;
@property (nonatomic, strong) TTTAttributedLabel *upLabel;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) ASPhotoView *photoView;
@property (nonatomic, strong) ASSecondView *blackView;
@end

@implementation FaBuZhuTiVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
        
    }
    return self;
}
- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布主题";
    self.user = [[ASUserInfoModel alloc] init];
    self.imageArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    self.headerView = [[UIView alloc] init];
    self.headerView.backgroundColor = KHexColor(@"#f0f0f0");
    self.headerView.frame = CGRectMake(0, 0, CoreWidth, CoreHeight);
    [self.tableView addSubview:_headerView];
    
    self.fontView = [[UIView alloc] init];
    self.fontView.backgroundColor = KHexColor(@"#ffffff");
    self.fontView.frame = CGRectMake(5, 10, CoreWidth-10, 280);
    [self.headerView addSubview:_fontView];
    
    
    self.titleTF = [UITextField new];
    self.titleTF.placeholder = @"添加标题";
    [self.fontView addSubview:_titleTF];
    
    [_titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fontView.mas_top).offset(8);
        make.left.equalTo(self.fontView.mas_left).offset(20);
        make.right.equalTo(self.fontView.mas_right).offset(-10);
        make.height.equalTo(40);
    }];
    
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"#cccccc");
    [self.headerView addSubview:_line];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleTF.mas_bottom).offset(0);
        make.left.equalTo(self.titleTF.mas_left).offset(-10);
        make.right.equalTo(self.titleTF.mas_right).offset(0);
        make.height.equalTo(0.5);
    }];

    
    self.contentBGView = [UIView new];
    self.contentBGView.layer.cornerRadius = 6;
    self.contentBGView.layer.masksToBounds = YES;
    self.contentBGView.layer.borderColor = KHexColor(@"#cccccc").CGColor;
    self.contentBGView.layer.borderWidth = 0.5;
    [self.fontView addSubview:_contentBGView];
    
    [_contentBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).offset(10);
        make.left.equalTo(self.line.mas_left).offset(0);
        make.right.equalTo(self.line.mas_right).offset(0);
        make.height.equalTo(200);

    }];
    
    self.contentTV = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(8, 8, CoreWidth-40, 190)];
    self.contentTV.placeholder = @"添加内容";
    self.contentTV.font = KFontSize(13);
    [self.contentBGView addSubview:_contentTV];
    
    
    
    self.behindView = [UIView new];
    self.behindView.backgroundColor = KHexColor(@"#ffffff");
    self.behindView.layer.cornerRadius = 5;
    self.behindView.layer.masksToBounds = YES;
    self.behindView.layer.borderColor = KHexColor(@"#ebebeb").CGColor;
    self.behindView.layer.borderWidth = 0.5;
    [self.headerView addSubview:_behindView];
    
    
    self.imageView = [UIImageView new];
    self.imageView.backgroundColor = KHexColor(@"#ebebeb");
    self.imageView.image = [UIImage imageNamed:@"3_hospital_free"];
    [self.behindView addSubview:_imageView];
    
    
    self.imageView0 = [UIImageView new];
    self.imageView0.image = [UIImage imageNamed:@"3_hospital_free"];
    self.imageView0.tag = 100;
    [self.behindView addSubview:_imageView0];
    
    
    self.imageView1 = [UIImageView new];
    self.imageView1.tag = 101;
    [self.behindView addSubview:_imageView1];
    
    
    self.imageView2 = [UIImageView new];
    self.imageView2.tag = 102;
    [self.behindView addSubview:_imageView2];
    
    
    self.imageView3 = [UIImageView new];
    self.imageView3.tag = 103;
    [self.behindView addSubview:_imageView3];
    
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteButton.tag = 200;
    self.deleteButton.hidden = YES;
    [self.deleteButton setBackgroundImage:[UIImage imageNamed:@"nav_delete_h"] forState:UIControlStateNormal];
    [self.deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.behindView addSubview:_deleteButton];
    
    self.deleteButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteButton1.tag = 201;
    self.deleteButton1.hidden = YES;
    [self.deleteButton1 setBackgroundImage:[UIImage imageNamed:@"nav_delete_h"] forState:UIControlStateNormal];
    [self.deleteButton1 addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.behindView addSubview:_deleteButton1];
    
    self.deleteButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteButton2.tag = 202;
    self.deleteButton2.hidden = YES;
    [self.deleteButton2 setBackgroundImage:[UIImage imageNamed:@"nav_delete_h"] forState:UIControlStateNormal];
    [self.deleteButton2 addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.behindView addSubview:_deleteButton2];
    
    self.deleteButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteButton3.tag = 203;
    self.deleteButton3.hidden = YES;
    [self.deleteButton3 setBackgroundImage:[UIImage imageNamed:@"nav_delete_h"] forState:UIControlStateNormal];
    [self.deleteButton3 addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.behindView addSubview:_deleteButton3];

    
    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitButton.titleLabel.font = KFontSize(15);
    self.submitButton.layer.cornerRadius = 8;
    self.submitButton.layer.masksToBounds = YES;
    [self.submitButton setTitle:@"发布" forState:UIControlStateNormal];
    [self.submitButton setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.submitButton setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff637e")] forState:UIControlStateNormal];
    [self.submitButton addTarget:self action:@selector(submitButtonClik) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:_submitButton];

    
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:100];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(show)]];/**第一张添加手势**/
    
    
    [_behindView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fontView.mas_bottom).offset(8);
        make.left.equalTo(self.headerView.mas_left).offset(8);
        make.right.equalTo(self.headerView.mas_right).offset(-8);
        make.height.equalTo(110);
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.behindView.mas_centerY).offset(0);
        make.left.equalTo(self.behindView.mas_left).offset(10);
        make.width.equalTo(64);
        make.height.equalTo(64);
    }];
    
    
    [_imageView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.behindView.mas_centerY).offset(0);
        make.left.equalTo(self.behindView.mas_left).offset(10);
        make.width.equalTo(64);
        make.height.equalTo(64);
    }];
    
    [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.behindView.mas_centerY).offset(0);
        make.left.equalTo(self.imageView0.mas_right).offset(10);
        make.width.equalTo(64);
        make.height.equalTo(64);
        
    }];
    
    [_imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.behindView.mas_centerY).offset(0);
        make.left.equalTo(self.imageView1.mas_right).offset(10);
        make.width.equalTo(64);
        make.height.equalTo(64);
    }];
    
    [_imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.behindView.mas_centerY).offset(0);
        make.left.equalTo(self.imageView2.mas_right).offset(10);
        make.width.equalTo(64);
        make.height.equalTo(64);
    }];
    
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView0.mas_top).offset(0);
        make.right.equalTo(self.imageView0.mas_right).offset(0);
        make.width.equalTo(20);
        make.height.equalTo(20);
        
    }];
    
    [_deleteButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView1.mas_top).offset(0);
        make.right.equalTo(self.imageView1.mas_right).offset(0);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    
    [_deleteButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView2.mas_top).offset(0);
        make.right.equalTo(self.imageView2.mas_right).offset(0);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    
    [_deleteButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView3.mas_top).offset(0);
        make.right.equalTo(self.imageView3.mas_right).offset(0);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    
    
    
    [_upLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.behindView.mas_bottom).offset(-5);
        make.left.equalTo(self.imageView0.mas_left).offset(0);
        make.width.equalTo(self.upLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.behindView.mas_bottom).offset(20);
        make.centerX.equalTo(self.headerView.mas_centerX).offset(0);
        make.left.equalTo(self.headerView.mas_left).offset(40);
        make.right.equalTo(self.headerView.mas_right).offset(-40);
        make.height.equalTo(50);
    }];
    

}


#pragma mark - UIViewControllerRotation

// Applications should use supportedInterfaceOrientations and/or shouldAutorotate..
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

// New Autorotation support.
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        
    }];
}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-------------------------------------------------

- (void)deleteButtonClick:(UIButton *)sender        //只能选择四张照片
{
    
    for (int a = 0 ; a< photoNumber  ;a++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:200+a];
        button.hidden = YES;
    }
    NSInteger index=sender.tag-200;
    [self.imageArray removeObjectAtIndex:index];
    photoNumber = 0;
    [self loadImageView];
    for (int a = 0 ; a< self.imageArray.count  ;a++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:200+a];
        button.hidden = NO;
    }
    
    
}

- (void)show
{
    for (int i = 0; i< self.imageArray.count; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:200+i];
        button.hidden = YES;
    }
    self.photoView = [[ASPhotoView alloc]init];
    [self.photoView.takePhotoButton addTarget:self action:@selector(takePhotos) forControlEvents:UIControlEventTouchUpInside];
    [self.photoView.albumButton addTarget:self action:@selector(takeAlbums) forControlEvents:UIControlEventTouchUpInside];
    self.photoView.frame = CGRectMake(0, kSCREEN_HEIGHT - 120, kSCREEN_WIDTH, 120);
    
    
    self.blackView = [[ASSecondView alloc]initWithFrame:self.view.bounds];
    [self.blackView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide:)]];
    [self.view addSubview:_blackView];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_blackView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.photoView];
    [self.photoView showAnimation];
}

-(void)hide:(UITapGestureRecognizer *)tap{
    [self.photoView hideAnimation];
    [_blackView removeFromSuperview];
}

#pragma mark------------------------------------------------------PhotoMethods------------------------------------------------------
- (void)takePhotos
{
    [self.imageArray removeAllObjects];//清空数组
    UIImagePickerController *pPicker = [[UIImagePickerController alloc] init];
    pPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    pPicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    pPicker.delegate = self;
    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
    pPicker.mediaTypes = mediaTypes;
    [self presentViewController:pPicker animated:YES completion:nil];
    [self.photoView hideAnimation];
    [_blackView removeFromSuperview];
}

- (void)takeAlbums {
    [self.imageArray removeAllObjects];//清空数组
    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.maximumNumberOfSelection = 3-photoNumber;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:NULL];
    [self.photoView hideAnimation];
    [_blackView removeFromSuperview];
}
#pragma mark - QBImagePickerControllerDelegate //选择照片完成
- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    for(int i = 0;i<assets.count;i++){
        ALAsset * asset = assets[i];
        ALAssetRepresentation* representation = [asset defaultRepresentation];
        UIImage* rti =  [UIImage imageWithCGImage:representation.fullScreenImage];
        [self.imageArray addObject:[UIImage scaledToSize:rti]]; //#import "UIImage+Image.h"
    }
    [self loadImageView];
    self.tabBarController.tabBar.hidden = YES;
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
    [imagePickerController removeFromParentViewController];
}
//图片试图控制
-(void)loadImageView
{
    
    for (int a = 0 ; a< self.imageArray.count  ;a++)
    {
        UIImage *aImge = self.imageArray[a];
        UIImageView *imageview=(UIImageView *)[self.view viewWithTag:100+photoNumber];
        imageview.layer.cornerRadius = 3.0f;
        [imageview removeGestureRecognizer:tapGes];
        imageview.userInteractionEnabled=YES;
        imageview.image=aImge;
        // 事件监听
        imageview.userInteractionEnabled = YES;
        [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        photoNumber++;
    }
    
    for (NSInteger j = photoNumber; j<3; j++) {
        UIImageView *imageview=(UIImageView *)[self.view viewWithTag:100+j];
        imageview.image=nil;
        imageview.userInteractionEnabled=NO;
    }
    
    if (self.imageArray.count < 3) {
        UIImageView *imageview=(UIImageView *)[self.view viewWithTag:100+photoNumber];
        imageview.userInteractionEnabled=YES;
        imageview.image = [UIImage imageNamed:@"3_hospital_free"];
        tapGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(show)];
        [imageview addGestureRecognizer:tapGes];
    }
}

-(void)tapImage:(UITapGestureRecognizer *)tap{
    if (isMove == YES)
    {
        for (int a = 0 ; a< photoNumber  ;a++)
        {
            UIButton *button = (UIButton *)[self.view viewWithTag:200+a];
            button.hidden = NO;
        }
        isMove = NO;
    }
    else if (isMove == NO)
    {
        for (int a = 0 ; a< photoNumber  ;a++) {
            UIButton *button = (UIButton *)[self.view viewWithTag:200+a];
            button.hidden = YES;
        }
        isMove = YES;
    }
}


#pragma mark ------------------------------------------------------  ASURLConnection --------------------------
- (void)submitButtonClik{
    
    
    [ASURLConnection requestImage:@{@"win":@1} method:kUploadImg version:@"" img:self.imageArray name:@"file_url" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSDictionary *dic = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"][0];
            NSString *string = [dic objectForKey:@"imageList"];
            [self requestData:string];
        }
        else
        {
            [ASLoadingView hidenActivity:self.view];
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
    

    
    
}


- (void)requestData:(NSString *)string
{
    NSDictionary *jsonDic = @{@"circle_id":self.circle_id,
                              @"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId],
                              @"title":self.titleTF.text,
                              @"imgs":string,
                              @"context":self.contentTV.text
                              };

    
        [ASURLConnection requestAFNJSon:jsonDic method:@"renhe.momCircle.submitPost" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                k_yjHUD([ASURLConnection getMessage:responseObject], self.view)
                [self.navigationController popViewControllerAnimated:YES];
            }
        } errorBlock:^(NSError *error) {
        }];
}
@end
