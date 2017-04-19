//
//  MyDetailCell.m
//  Mamabao
//
//  Created by Michael on 16/1/8.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import "MyDetailCell.h"

@interface MyDetailCell ()

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIImageView *rightImage;
@property (nonatomic, strong) TTTAttributedLabel *rightDetailLabel;


@end

@implementation MyDetailCell

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
        
        
        self.rightDetailLabel = [TTTAttributedLabel new];
        self.rightDetailLabel.textColor = KHexColor(@"#666666");
        self.rightDetailLabel.font = KFontSize(14);
        self.rightDetailLabel.numberOfLines = 0;
        self.rightDetailLabel.lineSpacing = 4;
        [self.contentView addSubview:_rightDetailLabel];
        
        
        [_iconRightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.width.equalTo(40);
            make.height.equalTo(40);
        }];
        
        
        [_rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.right.equalTo(self.iconRightImage.mas_left).offset(-10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        
        
        [_rightDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightImage.mas_top).offset(0);
            make.left.equalTo(self.rightImage.mas_left).offset(10);
            make.right.equalTo(self.rightImage.mas_right).offset(-10);
            make.bottom.equalTo(self.rightImage.mas_bottom).offset(0);
        }];
        
    }
    return self;
}

+(CGFloat)heightForRowWithStringrightDetail:(NSString *)string
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
    self.rightDetailLabel.text = detail.content;
}

@end
