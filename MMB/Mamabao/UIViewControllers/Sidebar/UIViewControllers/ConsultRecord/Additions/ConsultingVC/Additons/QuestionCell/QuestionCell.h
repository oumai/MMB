//
//  QuestionCell.h
//  Mamabao
//
//  Created by Michael on 16/1/8.
//  Copyright © 2016年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionCell : UITableViewCell

@property (nonatomic, strong) TTTAttributedLabel *rightLabel;

+(CGFloat)heightForRowWithString:(NSString *)string;

@end
