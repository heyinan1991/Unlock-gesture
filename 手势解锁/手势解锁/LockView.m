//
//  LockView.m
//  手势解锁
//
//  Created by xuchuangnan on 15/8/20.
//  Copyright (c) 2015年 xuchuangnan. All rights reserved.
//

#import "LockView.h"

@interface LockView ()
@property(nonatomic, strong) NSMutableArray *selectedBtn; //选中的按钮
@property(nonatomic, assign) CGPoint curp;// 当前的触摸点

@end


@implementation LockView
// 懒加载数组

- (NSMutableArray *)selectedBtn
{
    if (_selectedBtn == nil){
     
        _selectedBtn = [NSMutableArray array];
    }
    return _selectedBtn;
}


- (void)awakeFromNib
{
    
    for (int i = 0; i<9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        // 用来效验解锁是否正确
        btn.tag = i;
        // 设置按钮不能交互
        btn.userInteractionEnabled = NO;
        
        [self addSubview:btn];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 按钮宽高按图片本身的大小
    CGFloat wh = 74;
    
    // 列数
    NSInteger crNum = 3;
    
    // 间距
    
    CGFloat margin = (self.bounds.size.width - wh*crNum)/(crNum + 1);
    // 布局按钮
    for (int i = 0; i<9; i++) {
        UIButton *button = self.subviews[i];
        // 列号
        NSInteger col = i % crNum;
        // 行号
        NSInteger row = i / crNum;
        // x和y
        CGFloat x = margin + (margin + wh) * col;
        CGFloat y = (margin + wh) * row;
        
        button.frame = CGRectMake(x, y, wh, wh);
    }
    
}

// 开始触摸的时候调用,这里用来实现触摸按钮立马变成selected状态的图片
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self selectBtnWithTouchs:touches withEvent:event];
}

// 这个方法是在触摸点移动的时候调用,这里是用它实现,从移动过程中线能连接到当时触摸点的位置,即使点不在按钮上,和draw方法中[path addLineToPoint:_curp];联合实现
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self selectBtnWithTouchs:touches withEvent:event];
    // 重绘,不然线出不来
    [self setNeedsDisplay];
}

// 手指抬起的时候调用,用来实现手指抬起后按钮回复原装,线消失
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 将tag值拼接成一个字符串,有跟密码对比,字符串里面的 数组是有序的,这样就能效验密码是否正确
    NSMutableString *strM = [NSMutableString string];
    // 遍历数组
    for (UIButton *btn in self.selectedBtn) {
        btn.selected = NO;
        [strM appendFormat:@"%ld",btn.tag];
        
    }
    NSLog(@"%@",strM);
    if ([strM isEqualToString:@"012345"]) {
        NSLog(@"密码正确");
    }else{
        NSLog(@"密码错误请重新输入");
    }
    
    // 移除所有按钮
    [self.selectedBtn removeAllObjects];
    // 重绘
    [self setNeedsDisplay];
}

#pragma mark - 画线
// draw在调用之前,每次都会把之前的内容清空

- (void)drawRect:(CGRect)rect
{
    // 判断当前数组是否为空
    if (self.selectedBtn.count == 0) return;
    // 拼接路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    int i = 0;
    // 遍历数组
    for (UIButton *btn  in self.selectedBtn) {
        if (i == 0) {// 如果是0 就是起点
            [path moveToPoint:btn.center];
            
        }else {
            [path addLineToPoint:btn.center];
        }
        i++;
    }
    
    // 添加手指触摸的点(实现即使当前点不在按钮上也能连线到触摸的位置)
    [path addLineToPoint:_curp];
    
    
    // 设置线的颜色
    [[UIColor greenColor] set];
    
    // 设置线的宽度
    path.lineWidth = 10;
    
    // 设置线连接处的格式
    path.lineJoinStyle = kCGLineJoinRound;
    
    // 画线
    [path stroke];
    
    
}



- (void)selectBtnWithTouchs:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 获取当前UITouch
    UITouch *touch = [touches anyObject];
    
    // 获取当前触摸点
    CGPoint curP = [touch locationInView:self];
    // 赋值给成员变量
    _curp = curP;
    
    // 遍历view的子控件,也就是btn,转换当前触摸点到btn得坐标系看在不在btn上
    for (UIButton *btn in self.subviews) {
        // 转换成按钮坐标系上的点
        CGPoint btnp = [self convertPoint:curP toView:btn];
        if ([btn pointInside:btnp withEvent:event] && btn.selected==NO) {
            btn.selected = YES;
            // 存入数组
            [self.selectedBtn addObject:btn];
        }
    }

}



@end
