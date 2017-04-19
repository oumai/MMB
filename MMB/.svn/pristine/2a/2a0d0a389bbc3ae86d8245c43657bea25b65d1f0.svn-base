//
//  CityVC.m
//  Mamabao
//
//  Created by Michael on 15/11/26.
//  Copyright © 2015年 Michael. All rights reserved.
//
/*-----------------------------------------------------------------------M-------------------------------------------*/


@interface CityModel  : NSObject
@property (nonatomic, strong) NSString *city_name;
@property (nonatomic, strong) NSString *first;
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface CityModel ()

@end

@implementation CityModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        
        if ([dic objectForKey:@"city_name"]) {
            self.city_name = [dic objectForKey:@"city_name"];
        }
        if ([dic objectForKey:@"first"]) {
            self.first = [dic objectForKey:@"first"];
        }
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/



@interface CityCustomCell : UITableViewCell

@property (nonatomic, strong) CityModel *city;

@end



@interface CityCustomCell ()

@property (nonatomic, strong) TTTAttributedLabel *cityNameLabel;
@property (nonatomic, strong) TTTAttributedLabel *firstIdentifierLabel;
//@property (nonatomic, strong) NSString *firstIdentifier;

@end

@implementation CityCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cityNameLabel = [TTTAttributedLabel new];
        self.cityNameLabel.font = KFontSize(14);
        self.cityNameLabel.textColor = KHexColor(@"#000000");
        [self.contentView addSubview:_cityNameLabel];
        
        [_cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.width.equalTo(self.cityNameLabel.mas_width);
            make.height.equalTo(14);
        }];
        
        self.firstIdentifierLabel = [TTTAttributedLabel new];
        self.firstIdentifierLabel.font = KFontSize(14);
        self.firstIdentifierLabel.textColor = KHexColor(@"#a7a7a7");
        [self.contentView addSubview:_firstIdentifierLabel];
        
        [_firstIdentifierLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.width.equalTo(self.firstIdentifierLabel.mas_width);
            make.height.equalTo(14);
        }];

    }
    return self;
}



- (void)setCity:(CityModel *)city
{
    if (nil == city) {
        return;
    }
    
    self.cityNameLabel.text = city.city_name;
    self.firstIdentifierLabel.text = city.first;
}

@end


/*-----------------------------------------------------------------------C-------------------------------------------*/
#import "CityVC.h"

@interface CityVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSDictionary *infoDic;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *cityArrayA;
@property (nonatomic, strong) NSMutableArray *cityArrayB;
@property (nonatomic, strong) NSMutableArray *cityArrayC;
@property (nonatomic, strong) NSMutableArray *cityArrayD;
@property (nonatomic, strong) NSMutableArray *cityArrayE;
@property (nonatomic, strong) NSMutableArray *cityArrayF;
@property (nonatomic, strong) NSMutableArray *cityArrayG;
@property (nonatomic, strong) NSMutableArray *cityArrayH;
@property (nonatomic, strong) NSMutableArray *cityArrayI;
@property (nonatomic, strong) NSMutableArray *cityArrayJ;
@property (nonatomic, strong) NSMutableArray *cityArrayK;
@property (nonatomic, strong) NSMutableArray *cityArrayL;
@property (nonatomic, strong) NSMutableArray *cityArrayM;
@property (nonatomic, strong) NSMutableArray *cityArrayN;
@property (nonatomic, strong) NSMutableArray *cityArrayO;
@property (nonatomic, strong) NSMutableArray *cityArrayP;
@property (nonatomic, strong) NSMutableArray *cityArrayQ;
@property (nonatomic, strong) NSMutableArray *cityArrayR;
@property (nonatomic, strong) NSMutableArray *cityArrayS;
@property (nonatomic, strong) NSMutableArray *cityArrayT;
@property (nonatomic, strong) NSMutableArray *cityArrayU;
@property (nonatomic, strong) NSMutableArray *cityArrayV;
@property (nonatomic, strong) NSMutableArray *cityArrayW;
@property (nonatomic, strong) NSMutableArray *cityArrayX;
@property (nonatomic, strong) NSMutableArray *cityArrayY;
@property (nonatomic, strong) NSMutableArray *cityArrayZ;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CityVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"loding-5"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftClicked)];
        self.navigationItem.leftBarButtonItem = left;
        left.tintColor = KHexColor(@"#ffffff");
        
        _dataArray = [NSMutableArray array];
        self.cityArrayA = [NSMutableArray array];
        self.cityArrayB = [NSMutableArray array];
        self.cityArrayC = [NSMutableArray array];
        self.cityArrayD = [NSMutableArray array];
        self.cityArrayE = [NSMutableArray array];
        self.cityArrayF = [NSMutableArray array];
        self.cityArrayG = [NSMutableArray array];
        self.cityArrayH = [NSMutableArray array];
        self.cityArrayI = [NSMutableArray array];
        self.cityArrayJ = [NSMutableArray array];
        self.cityArrayK = [NSMutableArray array];
        self.cityArrayL = [NSMutableArray array];
        self.cityArrayM = [NSMutableArray array];
        self.cityArrayN = [NSMutableArray array];
        self.cityArrayO = [NSMutableArray array];
        self.cityArrayP = [NSMutableArray array];
        self.cityArrayQ = [NSMutableArray array];
        self.cityArrayR = [NSMutableArray array];
        self.cityArrayS = [NSMutableArray array];
        self.cityArrayT = [NSMutableArray array];
        self.cityArrayU = [NSMutableArray array];
        self.cityArrayV = [NSMutableArray array];
        self.cityArrayW = [NSMutableArray array];
        self.cityArrayX = [NSMutableArray array];
        self.cityArrayY = [NSMutableArray array];
        self.cityArrayZ = [NSMutableArray array];
        
       
        
        self.infoDic = @{@"0":_cityArrayA,
                         @"1":_cityArrayB,
                         @"2":_cityArrayC,
                         @"3":_cityArrayD,
                         @"4":_cityArrayE,
                         @"5":_cityArrayF,
                         @"6":_cityArrayG,
                         @"7":_cityArrayH,
                         @"8":_cityArrayI,
                         @"9":_cityArrayJ,
                         @"10":_cityArrayK,
                         @"11":_cityArrayL,
                         @"12":_cityArrayM,
                         @"13":_cityArrayN,
                         @"14":_cityArrayO,
                         @"15":_cityArrayP,
                         @"16":_cityArrayQ,
                         @"17":_cityArrayR,
                         @"18":_cityArrayS,
                         @"19":_cityArrayT,
                         @"20":_cityArrayU,
                         @"21":_cityArrayV,
                         @"22":_cityArrayW,
                         @"23":_cityArrayX,
                         @"24":_cityArrayY,
                         @"25":_cityArrayZ,};
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在线医院";
    NavigationBarTitleColor
    self.menuController.panEnabel = NO;
   
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    

    
    [self requestData];
   
}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-----------------------------------------------------------

- (void)sectionButtonClick
{
    
}
- (void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark ------------------------------------------------------------------UITableViewDatasource Delegate-------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_infoDic count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 45)];
    sectionView.backgroundColor = KHexColor(@"#f3f3f3");
    
    UILabel *sectionLabel = [UILabel new];
    sectionLabel.textColor = KHexColor(@"#a7a7a7");
    sectionLabel.font = KFontSize(15);
    sectionLabel.text = section == 0 ? @"A" : section == 1 ? @"B":section == 2 ? @"C":section == 3 ? @"D":section == 4 ? @"E":section == 5 ? @"F":section == 6 ? @"G":section == 7 ? @"H":section == 8 ? @"I": section == 9 ? @"J":section == 10 ? @"K" : section == 11 ? @"L ":section == 12 ? @"M" : section == 13 ? @"N":section == 14 ? @"O":section == 15 ? @"P":section == 16 ? @"Q":section == 17 ? @"R":section == 18 ? @"S":section == 19 ? @"T":section == 20 ? @"U":section == 21 ? @"V":section == 22 ? @"W":section == 23 ? @"X":section == 24 ? @"Y" : @"Z";
    [sectionView addSubview:sectionLabel];
    
    [sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sectionView.mas_centerY).offset(0);
        make.left.equalTo(sectionView.mas_left).offset(15);
        make.width.equalTo(sectionLabel.mas_width);
        make.height.equalTo(15);
    }];
    
    return sectionView;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSString *setionKey = [@(section) stringValue];
//    NSArray *array = [_infoDic objectForKey:setionKey];
    
    return section == 0 ? self.cityArrayA.count : section == 1 ? self.cityArrayB.count : section == 2 ? self.cityArrayC.count :section == 3 ? self.cityArrayD.count :section == 4 ? self.cityArrayE.count :section == 5 ? self.cityArrayF.count :section == 6 ? self.cityArrayG.count :section == 7 ? self.cityArrayH.count :section == 8 ? self.cityArrayI.count :section == 9 ? self.cityArrayJ.count :section == 10 ? self.cityArrayK.count :section == 11 ? self.cityArrayL.count :section == 12 ? self.cityArrayM.count :section == 13 ? self.cityArrayN.count :section == 14 ? self.cityArrayO.count :section == 15 ? self.cityArrayP.count :section == 16 ? self.cityArrayQ.count :section == 17 ? self.cityArrayR.count :section == 18 ? self.cityArrayS.count :section == 19 ? self.cityArrayT.count :section == 20 ? self.cityArrayU.count :section == 21 ? self.cityArrayV.count :section == 22 ? self.cityArrayW.count :section == 23 ? self.cityArrayX.count :section == 24 ?  self.cityArrayY.count :self.cityArrayZ.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    CityCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[CityCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
//    NSString *sectionKey = [@(indexPath.section) stringValue];
//    NSArray *array = _infoDic[sectionKey];
//    cell.city = array[indexPath.row];
    
    cell.cityNameLabel.text = 0 == indexPath.section ? self.cityArrayA[indexPath.row] : 1 == indexPath.section ? self.cityArrayB[indexPath.row]: 2 == indexPath.section ? self.cityArrayC[indexPath.row]: 3 == indexPath.section ? self.cityArrayD[indexPath.row]: 4 == indexPath.section ? self.cityArrayE[indexPath.row]: 5 == indexPath.section ? self.cityArrayF[indexPath.row]: 6 == indexPath.section ? self.cityArrayG[indexPath.row]: 7 == indexPath.section ? self.cityArrayH[indexPath.row]: 8 == indexPath.section ? self.cityArrayI[indexPath.row]: 9 == indexPath.section ? self.cityArrayJ[indexPath.row]: 10 == indexPath.section ? self.cityArrayK[indexPath.row]: 11 == indexPath.section ? self.cityArrayL[indexPath.row]: 12 == indexPath.section ? self.cityArrayM[indexPath.row]: 13 == indexPath.section ? self.cityArrayN[indexPath.row]: 14 == indexPath.section ? self.cityArrayO[indexPath.row]: 15 == indexPath.section ? self.cityArrayP[indexPath.row]: 16 == indexPath.section ? self.cityArrayQ[indexPath.row]: 17 == indexPath.section ? self.cityArrayR[indexPath.row]: 18 == indexPath.section ? self.cityArrayS[indexPath.row]: 19 == indexPath.section ? self.cityArrayT[indexPath.row]: 20 == indexPath.section ? self.cityArrayU[indexPath.row]: 21 == indexPath.section ? self.cityArrayV[indexPath.row]: 22 == indexPath.section ? self.cityArrayW[indexPath.row]: 23 == indexPath.section ? self.cityArrayX[indexPath.row]: 24 == indexPath.section ? self.cityArrayY[indexPath.row] : self.cityArrayZ[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark ------------------------------------------------------------------ASURLConnection----------------------------------------------------------------
- (void)requestData
{
    [ASURLConnection requestAFNJSon:@{} method:@"renhe.help.getCityByHosp" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            for (NSDictionary *dic in dataArr)
            {
                if ([[dic objectForKey:@"first"] isEqualToString:@"A"])
                {
                    [self.cityArrayA addObject:[dic objectForKey:@"city_name"]];

                }
                else if ([[dic objectForKey:@"first"] isEqualToString:@"B"])
                {
                    [self.cityArrayB addObject:[dic objectForKey:@"city_name"]];
                }
                else if ([[dic objectForKey:@"first"] isEqualToString:@"C"])
                {
                    [self.cityArrayC addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"D"])
                {
                    [self.cityArrayD addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"E"])
                {
                    [self.cityArrayE addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"F"])
                {
                    [self.cityArrayF addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"G"])
                {
                    [self.cityArrayG addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"H"])
                {
                    [self.cityArrayH addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"I"])
                {
                    [self.cityArrayI addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"J"])
                {
                    [self.cityArrayJ addObject:[dic objectForKey:@"city_name"]];
                }

                
                else if ([[dic objectForKey:@"first"] isEqualToString:@"K"])
                {
                    [self.cityArrayK addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"L"])
                {
                    [self.cityArrayL addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"M"])
                {
                    [self.cityArrayM addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"N"])
                {
                    [self.cityArrayN addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"O"])
                {
                    [self.cityArrayO addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"P"])
                {
                    [self.cityArrayP addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"Q"])
                {
                    [self.cityArrayQ addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"R"])
                {
                    [self.cityArrayR addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"S"])
                {
                    [self.cityArrayS addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"T"])
                {
                    [self.cityArrayT addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"U"])
                {
                    [self.cityArrayU addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"V"])
                {
                    [self.cityArrayV addObject:[dic objectForKey:@"city_name"]];
                }
                else if ([[dic objectForKey:@"first"] isEqualToString:@"W"])
                {
                    [self.cityArrayW addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"X"])
                {
                    [self.cityArrayX addObject:[dic objectForKey:@"city_name"]];
                }

                else if ([[dic objectForKey:@"first"] isEqualToString:@"Y"])
                {
                    [self.cityArrayY addObject:[dic objectForKey:@"city_name"]];
                }
                else if ([[dic objectForKey:@"first"] isEqualToString:@"Z"])
                {
                    [self.cityArrayZ addObject:[dic objectForKey:@"city_name"]];
                }

            }

//            for (NSDictionary *dic in dataArr)
//            {
//                CityModel *city = [[CityModel alloc]initWithDictionary:dic];
//                [_dataArray addObject:city];
//            }
            [_tableView reloadData];
        }
    } errorBlock:^(NSError *error) {
    }];
}

@end

