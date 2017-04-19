//
//  MotherCircleVC.m
//  Mamabao
//
//  Created by Michael on 15/11/12.
//  Copyright © 2015年 Michael. All rights reserved.
//



/*-----------------------------------------------------------------------C-------------------------------------------*/
#import "MotherCircleVC.h"
#import "AfterChanCicleVC.h"
#import "MailBoxVC.h"
@interface MotherCircleVC ()<ViewPagerDataSource,ViewPagerDelegate>

@property (nonatomic, strong) ASUserInfoModel *user;
@property (nonatomic) NSUInteger numberOfTabs;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSDictionary *messageDic;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, assign) NSInteger fromTag;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIBarButtonItem *right;
@end



@implementation MotherCircleVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
      
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton.frame = CGRectMake(0, 0, 34/1.5, 26/1.5);
        [self.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
        self.navigationItem.rightBarButtonItem = right;
      
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"妈妈圈";
    NavigationBarTitleColor
    self.view.backgroundColor = KHexColor(@"#f5f5f5");
    
    if (self.cirleBlock) {
        self.cirleBlock();
    }
    self.user = [[ASUserInfoModel alloc] init];
    self.dataArray = [NSMutableArray array];
    self.titleArray = [NSMutableArray array];
    self.menuController.panEnabel = NO;
    [self requestRight];
    [self selectTabAtIndex:0];
    self.delegate = self;
    self.dataSource = self;
    
   
    
}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------


- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonClick
{
    MailBoxVC *message = [MailBoxVC new];
    [self.navigationController pushViewController:message animated:YES];
    
   
}
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    //[self performSelector:@selector(loadContent) withObject:nil afterDelay:5.0];
}
#pragma mark - Helpers
- (void)loadContent {
    
    self.numberOfTabs = _titleArray.count;
}

- (void)setNumberOfTabs:(NSUInteger)numberOfTabs
{
    
    _numberOfTabs = numberOfTabs;
    [self reloadData];              
}

#pragma mark ------------------------------------------------------------------ViewPagerDataSource Delegate-------------------------------------------------
//返回有多少个标题。
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    
    return [_titleArray count];
}

//返回标题条的高度。
- (CGFloat)valueForOption:(ViewPagerOption)option {
    return 44.0f;
}

//返回一个Label，对应每个标题。
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, CoreWidth, 84)];
    titleLabel.backgroundColor = KHexColor(@"#ffffff");
    titleLabel.font = KFontSize(14.0f);
    titleLabel.text = _titleArray[index];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = KHexColor(@"#666666");//#666666  #ff5873 所有字体的颜色
    [titleLabel sizeToFit];
    return titleLabel;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    
    AfterChanCicleVC *economicsVC = [AfterChanCicleVC new];
    economicsVC.type_id = _dataArray[index];
    return economicsVC;
}

- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index {
    
    __block UILabel *toLabel = (UILabel *)[viewPager.tabsView viewWithTag:kTabsViewTag + index];
    __block UILabel *fromeLabel = (UILabel *)[viewPager.tabsView viewWithTag:kTabsViewTag + _fromTag];
    
    fromeLabel.textColor = [UIColor colorForHexString:@"#666666"];KHexColor(@"#ff5873");//#7e7e7e  从这里选中了 就变成这个颜色了
    toLabel.textColor = [UIColor colorForHexString:@"#ff5873"];//#ff5873 #58be21        //开始的label 的颜色
    self.fromTag = index;
    
}
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    switch (option) {
        case ViewPagerOptionStartFromTab:   //从第0页开始展示
            return 0;
        case ViewPagerOptionTabLocation:    //标题条的位置，0居低部，1居顶部
            return 1;
        case ViewPagerOptionTabHeight:      //标题条的高度
            return 40;
        case ViewPagerOptionTabWidth:       //标题条的宽度
            return CoreWidth / 4;
            
        default:
            break;
    }
    return value;
}


- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    switch (component) {
        case ViewPagerIndicator:
            return [UIColor clearColor];KHexColor(@"#ff627e");
        case ViewPagerTabsView:
            return [UIColor whiteColor];
        case ViewPagerContent:
            return KHexColor(@"#f0f0f0");
        default:
            return color;
    }
}

#pragma mark ------------------------------------------------------------------ViewPagerDataSource Delegate-------------------------------------------------
- (void)requestRight
{
    [ASURLConnection requestAFNJSon:@{@"user_id":[NSNumber numberWithInteger:[self.user getUserMessageFromLocation].userId]} method:@"renhe.momCircle.findNoReadMsg" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            
            self.messageDic = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"][0];
            
            if (self.messageDic.count == 0)
            {
                [self.rightButton setBackgroundImage:[UIImage imageNamed:@"mailbox"] forState:UIControlStateNormal];
            }
            else
            {
                if ( [[self.messageDic objectForKey:@"noReadMsgNum"] integerValue] >0)
                {
                    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"post_information"] forState:UIControlStateNormal];
                }
                
                [self.rightButton setBackgroundImage:[UIImage imageNamed:@"mailbox"] forState:UIControlStateNormal];
            }
        }
        
        [self requestData];
    } errorBlock:^(NSError *error) {
    }];
    
}

- (void)requestData
{
    
    
    
    [ASURLConnection requestAFNJSon:@{} method:@"renhe.momCircle.allCircleType" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
           
            NSDictionary *dic = @{@"id":@0,@"name":@"我的圈"};
            NSMutableArray *dataArr = [NSMutableArray array];
            [dataArr addObject:dic];
             NSArray *dataA =  [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            for (NSDictionary *dicD in dataA) {
                [dataArr addObject:dicD];
            }
            for (int i =0 ; i <dataArr.count; i ++)
            {
                [_titleArray addObject:[dataArr[i] objectForKey:@"name"]];
                [_dataArray addObject:[dataArr[i] objectForKey:@"id"]];
            }
            [self loadContent];
        }
        
    } errorBlock:^(NSError *error) {
    }];
    
    
    

}
@end



