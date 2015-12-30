//
//  BgView.m
//  手势解锁
//
//  Created by xuchuangnan on 15/8/20.
//  Copyright (c) 2015年 xuchuangnan. All rights reserved.
//

#import "BgView.h"

@implementation BgView


- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"Home_refresh_bg"];
    
    [image drawAsPatternInRect:rect];
    
}


@end
