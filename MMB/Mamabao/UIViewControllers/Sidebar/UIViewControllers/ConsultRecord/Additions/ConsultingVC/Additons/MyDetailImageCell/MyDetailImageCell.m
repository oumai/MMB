//
//  MyDetailImageCell.m
//  Mamabao
//
//  Created by Michael on 16/1/8.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import "MyDetailImageCell.h"

@interface MyDetailImageCell ()

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIImageView *rightImage;
@property (nonatomic, strong) UIImageView *contentImage;

@end
@implementation MyDetailImageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KHexColor(@"#f4f4f4");
        
        self.iconRightImage = [UIImageView new];
        self.iconRightImage.layer.cornerRadius = 20;
        self.iconRightImage.layer.masksToBounds = YES;
        self.iconRightImage.image = [UIImage imageNamed:@"replay2"];
        [self.contentView addSubview:_iconRightImage];
        
        
        self.rightImage = [UIImageView new];
        self.rightImage.image = [[UIImage imageNamed:@"chat_right"] stretchableImageWithLeftCapWidth:25 topCapHeight:30];
        [self.contentView addSubview:_rightImage];
        
        
        self.contentImage = [UIImageView new];
        [self.contentView addSubview:_contentImage];
        self.contentImage.userInteractionEnabled = YES;
        [self.contentImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        
        [_iconRightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.width.equalTo(40);
            make.height.equalTo(40);
        }];
        
        
        [_rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.right.equalTo(self.iconRightImage.mas_left).offset(-10);
            make.width.equalTo(100);
            make.height.equalTo(100);
        }];
        
        
        [_contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightImage.mas_top).offset(2);
            make.left.equalTo(self.rightImage.mas_left).offset(2);
            make.right.equalTo(self.rightImage.mas_right).offset(-8);
            make.bottom.equalTo(self.rightImage.mas_bottom).offset(-2);
        }];
        
    }
    return self;
}
- (void)setMyDetailImageModel:(MyDetailModel *)myDetailImageModel
{
    if (nil == myDetailImageModel) {
        return;
    }
    if ([myDetailImageModel.file_url rangeOfString:@"null"].location != NSNotFound)
    {
        self.contentImage.image = [UIImage imageNamed:@""];
    }
    else
    {
        [self.contentImage sd_setImageWithURL:[NSURL URLWithString:myDetailImageModel.file_url] placeholderImage:nil];
    }
    
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
    // 替换为中等尺寸图片
    NSString *url = self.myDetailImageModel.file_url;
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.url = [NSURL URLWithString:url]; // 图片路径
    photo.srcImageView = self.contentImage; // 来源于哪个UIImageView
    [photos addObject:photo];
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];

}
@end
