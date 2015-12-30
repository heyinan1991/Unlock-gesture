//
//  ViewController.m
//  手势解锁
//
//  Created by xuchuangnan on 15/8/19.
//  Copyright (c) 2015年 xuchuangnan. All rights reserved.
//
/*
 步骤:
 1. 画出控制器View的背景图片
 2.在控制器View上添加用于显示手势解锁的View,并自定义类来描述这个View
 3.在awakeView上添加按钮的九宫格(设置按钮普通状态下得图片,和选中状态下得图片),在layoutsubview中设置位置,并设置按钮的交互为NO;
 4.要想选中按钮的时候就立马是选中状态的图片,不能用按钮的监听
 5.在touchbegin中获得当前选中的触摸点,遍历btn,转换触摸点为btn坐标系的点,调用pointInSide的方法判断是否在按钮上,在的换,按钮的selected为YES;
 6.在手指在view上移动的时候也要调用这个方法,那就把这个方法抽出来,在touchMoved中调用 ,
 7.在自定义的View中用drow方法画线
 7.1.定义一个数组用于存放被点击的按钮,全局变量存储当前的触摸点
 7.1在drow方法里面画线,首先判断当前数组元素个数,为0 直接返回,不用连线
 7.2大于0,拼接路径,遍历数组里边的Btn,因为数组是有序的,我们默认线的起始位置是第一个按钮的中心,在这里要这只一个变量i= 0,遍历的时候++,如果i = 0就是起始点,否则就是拼接点
 7.3 不仅要实现btn之间的链接,这里也要实现到触摸点的链接,这里注意在touchMoved中 重绘,不然线出不来
 7.4 设置线的颜色,线的宽度,线的锐度,画线,这里还要注意选中的点是不能再选的,可以在判断点在不在按钮上时加一条selected为NO
 7.5细节处理:触摸结束后线消失, 实现简单的答案效验
   做法:在touchEnd方法中,遍历数组里面元素,设置selected为NO,删除数组中全部元素,然后重绘
        定义一个可变数组 在设置九宫格元素属性的时候绑定各个按钮的tag,在这里遍历的时候拼接tag值为字符串,实现简单的密码效验
 */
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
