//
//  CourseView.m
//  numberGame
//
//  Created by Etong on 16/7/27.
//  Copyright © 2016年 Etong. All rights reserved.
//

#import "CourseView.h"

@interface CourseView() {
    // 开始是否选中了一个 圆圈  有的话 才能有下一步活动
    BOOL _isSelectStartPoint;
    // 记录每次 起点坐标
    CGPoint _pointForBegin;
    // 记录每次 终点坐标
    CGPoint _pointForEnd;
    //  每次点亮一个圆圈  就将数字加在一起
    int moveNum;
    //记录完成关数
    int Lv;
    //方块高宽
    CGFloat HW;
    //判断是第几个控制器
    int whoCtrl;
}

//  记录路径的数组 用于画图
@property (strong, nonatomic) NSMutableArray <UIBezierPath* > *pathArray;
//  定义一个临时路径变量  接受中间游走的路径
@property (strong, nonatomic) UIBezierPath *tempPath;

@property (strong, nonatomic)NSMutableArray *objArr;

@end

@implementation CourseView

- (NSMutableArray<UIBezierPath *> *)pathArray
{
    if (!_pathArray)
    {
        _pathArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _pathArray;
}


- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh:) name:@"whoCtrl" object:nil];
}



- (void)refresh:(NSNotification *)note {
    if ([note.userInfo[@"who"]intValue] == 1) {
        [self createOneSubView];
        Lv = 1;
        NSArray *arr = @[@"2",@"3",@"5",@"-1"];
        for (UIView *subView in self.subviews)
        {
            for (UILabel *label in subView.subviews) {
                label.text = arr[label.tag - 2001];
            }
        }
    }else if([note.userInfo[@"who"]intValue] == 2){
        [self createOtherSubView];
        Lv = 2;
        NSArray *arr = @[@"1",@"5",@"4",@"1",@"-3",@"1",@"-5",@"8",@"6",@"3",@"-2",@"-2",@"-4",@"5",@"1",@"5"];
        for (UIView *subView in self.subviews)
        {
            for (UILabel *label in subView.subviews) {
                label.text = arr[label.tag - 2001];
            }
        }
    }else{
        [self createOtherSubView];
        Lv = 3;
        NSArray *arr = @[@"1",@"5",@"4",@"1",@"-3",@"2",@"-1",@"2",@"6",@"2",@"2",@"-3",@"-4",@"5",@"1",@"4"];
        for (UIView *subView in self.subviews)
        {
            for (UILabel *label in subView.subviews) {
                label.text = arr[label.tag - 2001];
            }
        }
    }
}

- (void)createOneSubView {
    HW = (UI_SCREEN_W - 120)/4;
    
    for (int i = 0 ; i< 2 ; i++)
    {
        for (int j = 0 ; j < 2 ; j++)
        {
            // 算位置 并添加
            UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(HW+ 20 + j*(HW+20),HW + 20 + i*(HW+20), HW, HW)];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, HW, HW)];
            [tempView addSubview:lab];
            [self addSubview:tempView];
            
            // 给 view 几个 tag 值加以区分 值是1000 + 1到9;
            tempView.tag = 1001 + i*2 +j;
            tempView.backgroundColor = [UIColor colorWithRed:6.f/255.f green:117.f/255.f blue:144.f/255.f alpha:1];
            tempView.layer.cornerRadius = 5;
            
            lab.tag = 2001 + i*2 +j;
            lab.font = [UIFont systemFontOfSize:24];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.textColor = [UIColor whiteColor];
        }
    }
}

- (void)createOtherSubView {
    HW = (UI_SCREEN_W - 120)/4;
    
    for (int i = 0 ; i< 4 ; i++)
    {
        for (int j = 0 ; j < 4 ; j++)
        {
            // 算位置 并添加
            UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(j*(HW+20), i*(HW+20), HW, HW)];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, HW, HW)];
            [tempView addSubview:lab];
            [self addSubview:tempView];
            
            // 给 view 几个 tag 值加以区分 值是1000 + 1到9;
            tempView.tag = 1001 + i*4 +j;
            tempView.backgroundColor = [UIColor colorWithRed:6.f/255.f green:117.f/255.f blue:144.f/255.f alpha:1];
            tempView.layer.cornerRadius = 5;
            
            lab.tag = 2001 + i*4 +j;
            lab.font = [UIFont systemFontOfSize:24];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.textColor = [UIColor whiteColor];
        }
    }
}

//初始化数据
- (void)Initialization {
    // 记录结果的数组每次都要重新去计算
    moveNum = 0;
    //  先把存储的路径清空  第一次花图案之后 再去画的话  就把之前的路径去掉
    [self.pathArray removeAllObjects];
    
    // 让九个圆圈恢复原来状态  颜色 和是 否选中 这里用交互的值去判断是否选中
    for (UIView *tempView in self.subviews)
    {
        tempView.userInteractionEnabled = 1;
        tempView.backgroundColor = [UIColor colorWithRed:6.f/255.f green:117.f/255.f blue:144.f/255.f alpha:1];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self Initialization];
    
    // 获取触摸的第一个为开始点
    _pointForBegin = [touches.anyObject locationInView:self];
    
    // 遍历检查一下开始点是否是在 九个圆圈中某一个的范围中
    for (UIView *subView in self.subviews)
    {
        if (CGRectContainsPoint(subView.frame, _pointForBegin))
        {
            // 若是在 改变圆圈颜色
            subView.backgroundColor = [UIColor greenColor];
            // 记录一下有没有开始点
            _isSelectStartPoint = 1;
            // 更改开始点的坐标
            _pointForBegin = subView.center;
            // 用 view 的交互去记录是否选中
            subView.userInteractionEnabled = 0;
            
            for (UILabel *lab in subView.subviews) {
                moveNum = moveNum + [lab.text intValue];
            }
            NSDictionary *dic = @{@"number":@(moveNum)};
            [[NSNotificationCenter defaultCenter]postNotificationName:@"clickWho" object:nil userInfo:dic];
        }
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //判断所连接的数字是否是相邻的
    BOOL flag = YES;
    // 获取移动中的终点
    _pointForEnd = [touches.anyObject locationInView:self];
    if(_pointForEnd.y > self.frame.size.height || _pointForEnd.y < 0 || _pointForEnd.x > self.frame.size.width || _pointForEnd.x
       < 0){
        [self Initialization];
        // 清除当前的路径  目的是 把多余的没有连接两个圈的线 去掉
        self.tempPath = nil;
        // 设置没有选中开始点 为下一次绘制做准备
        _isSelectStartPoint = 0;
        // 绘制渲染一下
        [self setNeedsDisplay];
    }
    
    if ( _pointForBegin.x - _pointForEnd.x < -(HW+HW/2+20)  ||  _pointForBegin.x - _pointForEnd.x > HW+HW/2+20 || _pointForBegin.y - _pointForEnd.y < -(HW+HW/2+20)  ||  _pointForBegin.y - _pointForEnd.y > HW+HW/2+20) {
        flag = NO;
    }
    
    // 看看有没有开始的圆圈被选中要是有的话才会有一系列的操作  否则不管
    if (_isSelectStartPoint)
    {
        // 创建一个临时的路径再说
        self.tempPath = [UIBezierPath bezierPath];
        // 设置路径起点
        [self.tempPath moveToPoint:_pointForBegin];
        // 移动中的临时终点线连起来
        [self.tempPath addLineToPoint:_pointForEnd ];
        
        // 判断终点是否在  九个圆圈的范围中
        for (UIView *subView in self.subviews)
        {
            if (CGRectContainsPoint(subView.frame, _pointForEnd) && subView.userInteractionEnabled && flag)
            {
                // 改变颜色 并关闭 交互 表示选中了
                subView.backgroundColor = [UIColor greenColor];
                subView.userInteractionEnabled = 0;
                for (UILabel *lab in subView.subviews) {
                    moveNum = moveNum + [lab.text intValue];
                }
                NSDictionary *dic = @{@"number":@(moveNum)};
                [[NSNotificationCenter defaultCenter]postNotificationName:@"clickWho" object:nil userInfo:dic];
                // 重新规划路径
                self.tempPath = [UIBezierPath new];
                [self.tempPath moveToPoint:_pointForBegin];
                [self.tempPath addLineToPoint:subView.center];
                // 把路径存放到数组中
                [self.pathArray addObject:self.tempPath];
                //计算正确的数值给予高亮
                if (moveNum == Lv) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"heightLight" object:nil];
                }
                // 为找下一个圆圈位置做准备  要以这个选中圆圈位置中心开始点
                _pointForBegin = subView.center;
            }
        }
    }
    // 不要忘了  去渲染绘制一下
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 清除当前的路径  目的是 把多余的没有连接两个圈的线 去掉
    self.tempPath = nil;
    // 设置没有选中开始点 为下一次绘制做准备
    _isSelectStartPoint = 0;
    // 绘制渲染一下
    [self setNeedsDisplay];
    
    if (moveNum == Lv) {
        NSDictionary *dic = @{@"lv":@(Lv)};
        [[NSNotificationCenter defaultCenter]postNotificationName:@"pushCtrl" object:nil userInfo:dic];
    }
    NSDictionary *dic = @{@"number":@(moveNum)};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"clickWho" object:nil userInfo:dic];
    [self Initialization];
}



- (void)drawRect:(CGRect)rect {
    // 找到所有连接两个圆圈的路径  渲染
    for (UIBezierPath *path in self.pathArray)
    {
        [path setLineWidth:6];
        [[UIColor colorWithRed:168.f/255.f green:243.f/255.f blue:239.f/255.f alpha:1] set];
        [path stroke];
    }
    // 临时路径渲染
    self.tempPath.lineWidth = 6;
    [[UIColor colorWithRed:168.f/255.f green:243.f/255.f blue:239.f/255.f alpha:1] set];
    [self.tempPath stroke];
}


@end
