//
//  KeShiVC.m
//  Mamabao
//
//  Created by Michael on 15/12/3.
//  Copyright © 2015年 Michael. All rights reserved.
//
/*-----------------------------------------------------------------------M-------------------------------------------*/

@interface KeShiModel  : NSObject

@property(nonatomic,strong)NSString *keshi_id;
@property(nonatomic,strong)NSString *addTime;
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *name;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end



@interface KeShiModel ()

@end

@implementation KeShiModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        if ([[dic objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
            self.keshi_id = [[dic objectForKey:@"id"] stringValue];
        }
        if ([dic objectForKey:@"name"]) {
            self.name = [dic objectForKey:@"name"];
        }
        
    }
    return self;
}

@end


/*-----------------------------------------------------------------------V-------------------------------------------*/
@interface KeShiCollectionCell : UICollectionViewCell

@property (nonatomic, strong) KeShiModel *shiModel;

@end

@interface KeShiCollectionCell ()

@property (nonatomic, strong) TTTAttributedLabel *keShiNameLabel;
@property (nonatomic, strong) NSString*keshi_id;

@end

@implementation KeShiCollectionCell

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = KHexColor(@"#ff9d7a");
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        self.keShiNameLabel = [TTTAttributedLabel new];
        self.keShiNameLabel.font = KFontSize(14);
        self.keShiNameLabel.textColor = KHexColor(@"#ffffff");
        [self.contentView addSubview:_keShiNameLabel];
        
        [_keShiNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX).offset(0);
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.width.equalTo(self.keShiNameLabel.mas_width);
            make.height.equalTo(14);
        }];
        
    }
    return self;
}


- (void)setShiModel:(KeShiModel *)shiModel
{
    if (nil == shiModel) {
        return;
    }
    
    self.keShiNameLabel.text = shiModel.name;
    self.keshi_id = shiModel.keshi_id;
}

@end



#import "KeShiVC.h"
#import "FreeConsultVC.h"
@interface KeShiVC ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIView *fontView;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) TTTAttributedLabel *titleLabe;
@property (nonatomic, strong) TTTAttributedLabel *limitZishuLabel;
@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation KeShiVC

 - (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    [self makeYuanUI];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(CoreWidth*0.4, 40);
    layout.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = KHexColor(@"#ffffff");
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.fontView addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).offset(0);
        make.left.equalTo(self.fontView.mas_left).offset(10);
        make.right.equalTo(self.fontView.mas_right).offset(-10);
        make.height.equalTo(160);
    }];
    
    [_collectionView registerClass:[KeShiCollectionCell class] forCellWithReuseIdentifier:@"KeShiCollectionCell"];
    [self requestData];
}

- (void)makeYuanUI
{
    
    self.fontView = [UIView new];
    self.fontView.backgroundColor = KHexColor(@"#ffffff");
    self.fontView.layer.cornerRadius = 5;
    self.fontView.layer.masksToBounds = YES;
    self.fontView.layer.borderColor = KHexColor(@"#ebebeb").CGColor;
    self.fontView.layer.borderWidth = 0.5;
    [self.view addSubview:_fontView];
    
    
    self.iconImage = [UIImageView new];
    self.iconImage.image = [UIImage imageNamed:@"hospital_free"];
    [self.fontView addSubview:_iconImage];
    
    
    
    self.titleLabe = [TTTAttributedLabel new];
    self.titleLabe.textColor = KHexColor(@"#5b5b5b");
    self.titleLabe.font = KFontSize(15);
    self.titleLabe.text = @"请选择科室";
    [self.fontView addSubview:_titleLabe];
    
    
    self.arrowImage = [UIImageView new];
    self.arrowImage.image = [UIImage imageNamed:@"2_hospital_free"];
    [self.fontView addSubview:_arrowImage];
    
    
    
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"#e1e0e1");
    [self.fontView addSubview:_line];
    
    
    
    [_fontView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.equalTo(240);
    }];
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fontView.mas_top).offset(15);
        make.left.equalTo(self.fontView.mas_left).offset(10);
        make.width.equalTo(15);
        make.height.equalTo(15);
        
    }];
    
    [_titleLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImage.mas_centerY).offset(0);
        make.left.equalTo(self.iconImage.mas_right).offset(15);
        make.width.equalTo(self.titleLabe.mas_width);
        make.height.equalTo(15);
    }];
    
    [_arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImage.mas_centerY).offset(0);
        make.right.equalTo(self.fontView.mas_right).offset(-20);
        make.width.equalTo(11);
        make.height.equalTo(6);
        
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImage.mas_bottom).offset(15);
        make.left.equalTo(self.fontView.mas_left).offset(10);
        make.right.equalTo(self.fontView.mas_right).offset(-10);
        make.height.equalTo(1);
        
    }];
    
  
}
#pragma mark ------------------------------------------------------------------Actions  ButtonClick-------------------------------------------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KeShiCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KeShiCollectionCell" forIndexPath:indexPath];
    cell.shiModel = _dataArray[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KeShiModel *model = _dataArray[indexPath.item];  //传值科室
    self.name = model.name;
    self.major_id = model.keshi_id;
    if (self.sureBlock)
    {
        self.sureBlock(self);
    }
}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (void)requestData
{
    
    [ASURLConnection requestAFNJSon:@{@"hospital_id":@0} method:kGetKeshi completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            for (int i=0; i<arr.count; i++) {
                //ChanKeKShiModel *model=[ChanKeKShiModel objectWithKeyValues:arr[i]]; 自动解析
                KeShiModel *model = [[KeShiModel alloc] initWithDictionary:arr[i]];
                [self.dataArray addObject:model];
            }
            [_collectionView reloadData];
        }
    } errorBlock:^(NSError *error) {
    }];
    
}
@end
