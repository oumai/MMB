//
//  UUPHUD.m
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/18.
//
//

#import "UUPHUD.h"

@implementation UUPHUD

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
    }
    return self;
}


-(void)makeUI{
    self.layer.cornerRadius = 10.0;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *Imageview = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-100)/2, 10, 100, 100)];
    NSMutableArray *arr = [[NSMutableArray alloc]init];

    for (int i = 1; i < 12 ; i++) {
        [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"voice_recording%d",i]]];
    }
    Imageview.animationImages = arr;
    Imageview.animationDuration = 1.3;//设置动画时间
    Imageview.animationRepeatCount = 0;//设置动画次数 0 表示无限
    [Imageview startAnimating];//开始播放动画
    [self addSubview:Imageview];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, self.frame.size.width, 20)];
    lable.text = @"手指上滑,取消发送";
    lable.font = [UIFont systemFontOfSize:13.0];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    [self addSubview:lable];
}

@end
