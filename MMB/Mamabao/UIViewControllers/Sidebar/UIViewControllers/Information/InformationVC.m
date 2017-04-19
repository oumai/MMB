//
//  InformationVC.m
//  Mamabao
//
//  Created by Michael on 15/11/12.
//  Copyright © 2015年 Michael. All rights reserved.
//

/*-----------------------------------------------------------------------C-------------------------------------------*/

#import "InformationVC.h"
#import "InfomationHuaiYunVC.h"
@interface InformationVC ()<ViewPagerDataSource,ViewPagerDelegate>
@property (nonatomic) NSUInteger numberOfTabs;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *idArray;
@property (nonatomic, assign) NSInteger fromTag;
@property (nonatomic, strong) UITableView *tableView;

@end



@implementation InformationVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
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
    self.title = @"资讯";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
    self.view.backgroundColor = KHexColor(@"#f5f5f5");
    self.titleArray = [NSMutableArray array];
    self.idArray = [NSMutableArray array];
    [self requestData];
    [self selectTabAtIndex:0];
    self.delegate = self;
    self.dataSource = self;
   

}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------

- (void)sectionButtonClick
{
    
}
- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
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
    //UILabel *titleLabel = [UILabel new];
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
    
    InfomationHuaiYunVC *huaiYun = [InfomationHuaiYunVC new];
    huaiYun.chanel_id = _idArray[index];
    
    NSLog(@"----------%@",huaiYun.chanel_id);
    return huaiYun;
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
        case ViewPagerOptionStartFromTab://从第0页开始展示
            return 0;
        case ViewPagerOptionTabLocation://标题条的位置，0居低部，1居顶部
            return 1;
        case ViewPagerOptionTabHeight://标题条的高度
            return 40;
        case ViewPagerOptionTabWidth://标题条的宽度
            return CoreWidth / 4;
            
        default:
            break;
    }
    return value;
}


- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    switch (component) {
        case ViewPagerIndicator:
            return [UIColor clearColor];
        case ViewPagerTabsView:
            return [UIColor whiteColor];
        case ViewPagerContent:
            return KHexColor(@"#f0f0f0");
        default:
            return color;
    }
}

#pragma mark ------------------------------------------------------------------ASURLConnection---------------------------------------------------------------
- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{} method:@"jumper.news.chanel.getList" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString ] objectForKey:@"data"];
            for (NSDictionary *dic in dataArr) {
                
                [_titleArray addObject:[dic objectForKey:@"chanelName"]];
                [_idArray addObject:[dic objectForKey:@"id"]];
            }
            [self loadContent];
            
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

@end




