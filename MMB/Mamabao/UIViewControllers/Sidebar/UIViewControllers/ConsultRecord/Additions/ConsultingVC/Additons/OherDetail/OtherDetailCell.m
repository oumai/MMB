//
//  OtherDetailCell.m
//  Mamabao
//
//  Created by Michael on 16/1/11.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import "OtherDetailCell.h"

@interface OtherDetailCell ()
@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIImageView *iconleftImage;
@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) TTTAttributedLabel *leftLabel;
@end

@implementation OtherDetailCell

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
        
        self.iconleftImage = [UIImageView new];
        self.iconleftImage.image = [UIImage imageNamed:@"replay2"];
        [self.contentView addSubview:_iconleftImage];
        
        
        self.leftImage = [UIImageView new];
        self.leftImage.image = [[UIImage imageNamed:@"chat_left"] stretchableImageWithLeftCapWidth:25 topCapHeight:30];
        [self.contentView addSubview:_leftImage];
        
        
        
        self.leftLabel = [TTTAttributedLabel new];
        self.leftLabel.textColor = KHexColor(@"#666666");
        self.leftLabel.font = KFontSize(14);
        self.leftLabel.numberOfLines = 0;
        self.leftLabel.lineSpacing = 4;
        self.leftLabel.text = @"他就卡机开房间看电视剧风口浪尖的开始了放假考虑到进口量发掘卡拉胶水电费科技哦度覅偶地主覅来得及做空非健康了了健康路附近的考虑时间风口浪尖打开来减肥的减肥快";
        [self.contentView addSubview:_leftLabel];
        
        
        [_iconleftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.width.equalTo(40);
            make.height.equalTo(40);
        }];
        
        
        [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.left.equalTo(self.iconleftImage.mas_right).offset(10);
            make.height.equalTo(150);
        }];
        
        
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftImage.mas_top).offset(0);
            make.left.equalTo(self.leftImage.mas_left).offset(15);
            make.right.equalTo(self.leftImage.mas_right).offset(-10);
            make.bottom.equalTo(self.leftImage.mas_bottom).offset(0);
        }];
        
        
    }
    return self;
}




+(CGFloat)heightForRowWithStringleftDetail:(NSString *)string
{
    if (![string isValid]) {
        return 0;
    }
    
    CGFloat bottomSpace = 16;
    CGFloat stringHeight = [NSAttributedString contentHeightWithText:string width:CoreWidth-20 fontSize:14 lineSpacing:4];
    
    return bottomSpace + stringHeight + 20 +10;
}

- (void) setDetail:(MyDetailModel *)detail
{
    if (nil == detail) {
        return;
    }
    self.leftLabel.text = detail.content;
}



@end
