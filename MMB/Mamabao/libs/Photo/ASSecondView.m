//
//  ASSecondView.m
//  AngelSound
//
//  Created by jumper on 14-11-4.
//  Copyright (c) 2014年 Jumper. All rights reserved.
//

#import "ASSecondView.h"

@implementation ASSecondView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
        self.backgroundColor =[UIColor blackColor];
        self.alpha =.3f;

    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.superview endEditing:YES];
    [self removeFromSuperview];
}

@end
