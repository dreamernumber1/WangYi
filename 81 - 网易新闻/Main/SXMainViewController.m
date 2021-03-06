//
//  SXMainViewController.m
//  85 - 网易滑动分页
//
//  Created by 董 尚先 on 15-1-31.
//  Copyright (c) 2015年 shangxianDante. All rights reserved.
//

#import "SXMainViewController.h"
#import "SXTableViewController.h"
#import "SXTitleLable.h"

@interface SXMainViewController ()<UIScrollViewDelegate>
{
    CAEmitterLayer *_emitterLayer;
    UILabel *_angleLabel;
}
/** 标题栏 */
@property (weak, nonatomic) IBOutlet UIScrollView *smallScrollView;

/** 下面的内容栏 */
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property(nonatomic,strong) SXTitleLable *oldTitleLable;
@property (nonatomic,assign) CGFloat beginOffsetX;

/** 新闻接口的数组 */
@property(nonatomic,strong) NSArray *arrayLists;

@end

@implementation SXMainViewController

#pragma mark - ******************** 懒加载
- (NSArray *)arrayLists
{
    if (_arrayLists == nil) {
        _arrayLists = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"NewsURLs.plist" ofType:nil]];
    }
    return _arrayLists;
}

#pragma mark - ******************** 页面首次加载
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.smallScrollView.showsHorizontalScrollIndicator = NO;
//    self.smallScrollView.showsVerticalScrollIndicator = NO;
//    self.bigScrollView.delegate = self;
//    
//    [self addController];
//    [self addLable];
//    
//    CGFloat contentX = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
//    self.bigScrollView.contentSize = CGSizeMake(contentX, 0);
//    self.bigScrollView.pagingEnabled = YES;
//    
//    // 添加默认控制器
//    UIViewController *vc = [self.childViewControllers firstObject];
//    vc.view.frame = self.bigScrollView.bounds;
//    [self.bigScrollView addSubview:vc.view];
//    SXTitleLable *lable = [self.smallScrollView.subviews firstObject];
//    lable.scale = 1.0;
}

-(void)emitterEngine
{
    [super viewDidLoad];
    
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    //粒子发射位置
    snowEmitter.emitterPosition = CGPointMake(120,120);
    //发射源的尺寸大小
    snowEmitter.emitterSize = CGSizeMake(self.view.bounds.size.width * 20, 20);
    //发射模式
    snowEmitter.emitterMode = kCAEmitterLayerSurface;
    //发射源的形状
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    
    //创建雪花类型的粒子
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    //粒子的名字
    snowflake.name = @"snow";
    //粒子参数的速度乘数因子
    snowflake.birthRate = 1.0;
    snowflake.lifetime = 120.0;
    //粒子速度
    snowflake.velocity =10.0;
    //粒子的速度范围
    snowflake.velocityRange = 10;
    //粒子y方向的加速度分量
    snowflake.yAcceleration = 2;
    //周围发射角度
    snowflake.emissionRange = 0.5 * M_PI;
    //子旋转角度范围
    snowflake.spinRange = 0.25 * M_PI;
    snowflake.contents = (id)[[UIImage imageNamed:@"emoji_sweat"] CGImage];
    //设置雪花形状的粒子的颜色
    snowflake.color = [[UIColor colorWithRed:0.200 green:0.258 blue:0.543 alpha:1.000] CGColor];
    
    //创建星星形状的粒子
    CAEmitterCell *snowflake1 = [CAEmitterCell emitterCell];
    //粒子的名字
    snowflake1.name = @"snow";
    //粒子参数的速度乘数因子
    snowflake1.birthRate = 1.0;
    snowflake1.lifetime = 120.0;
    //粒子速度
    snowflake1.velocity =10.0;
    //粒子的速度范围
    snowflake1.velocityRange = 10;
    //粒子y方向的加速度分量
    snowflake1.yAcceleration = 2;
    //周围发射角度
    snowflake1.emissionRange = 0.5 * M_PI;
    //子旋转角度范围
    snowflake1.spinRange = 0.25 * M_PI;
    //粒子的内容和内容的颜色
    snowflake1.contents = (id)[[UIImage imageNamed:@"emoji_sweat"] CGImage];
    snowflake1.color = [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius = 0.0;
    snowEmitter.shadowOffset = CGSizeMake(0.0, 1.0);
    //粒子边缘的颜色
    snowEmitter.shadowColor = [[UIColor redColor] CGColor];
    snowEmitter.emitterCells = [NSArray arrayWithObjects:snowflake,snowflake1,nil];
    [self.view.layer insertSublayer:snowEmitter atIndex:0];
    
}

- (void)emitterEngine1
{
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    emitterLayer.emitterPosition = self.view.center;
    emitterLayer.renderMode = kCAEmitterLayerAdditive;
    _emitterLayer = emitterLayer;
    [self.view.layer addSublayer:emitterLayer];
    
    CAEmitterCell *funnyEmitterCell = [CAEmitterCell emitterCell];
    funnyEmitterCell.contents = (id)[UIImage imageNamed:@"blueApple.jpg"].CGImage;//用来设置图片
    funnyEmitterCell.birthRate = 5.0;//每秒某个点产生的funnyEmitterCell数量
    funnyEmitterCell.velocity = 100.0;//表示cell向屏幕右边飞行的速度
    funnyEmitterCell.lifetime = 2.0;//表示funnyEmitterCell的生命周期，既在屏幕上的显示时间要多长
    funnyEmitterCell.scale = 0.3;//缩放比例
    funnyEmitterCell.name = @"funny";//当funnyEmitterCell存在emitterLayer的emitterCells中用来辨认的。用到setValue forKeyPath比较有用
    emitterLayer.emitterCells = [NSArray arrayWithObject:funnyEmitterCell];
//    [self bumpAngle];
    
    UILabel *angleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 30)];
    angleLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:angleLabel];
    _angleLabel = angleLabel;
}

- (void)bumpAngle {
    NSNumber *emissionLongitude = [_emitterLayer valueForKeyPath:@"emitterCells.funny.emissionLongitude"];
    NSNumber *nextLongitude = [NSNumber numberWithFloat:[emissionLongitude floatValue] + 0.02];
    [_emitterLayer setValue:nextLongitude forKeyPath:@"emitterCells.funny.emissionLongitude"];
    _angleLabel.text = [NSString stringWithFormat:@"%.0f degrees", [nextLongitude floatValue] * 180 / M_PI];
    [self performSelector:@selector(bumpAngle) withObject:nil afterDelay:0.1];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self emitterEngine1];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - ******************** 添加方法

/** 添加子控制器 */
- (void)addController
{
    SXTableViewController *vc1 = [[UIStoryboard storyboardWithName:@"News" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    vc1.title = @"头条";
    vc1.urlString = self.arrayLists[0][@"urlString"];
    [self addChildViewController:vc1];
    SXTableViewController *vc2 = [[UIStoryboard storyboardWithName:@"News" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    vc2.title = @"NBA";
    vc2.urlString = self.arrayLists[1][@"urlString"];
    [self addChildViewController:vc2];
    SXTableViewController *vc3 = [[UIStoryboard storyboardWithName:@"News" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    vc3.title = @"手机";
    vc3.urlString = self.arrayLists[2][@"urlString"];
    [self addChildViewController:vc3];
    SXTableViewController *vc4 = [[UIStoryboard storyboardWithName:@"News" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    vc4.title = @"移动互联";
    vc4.urlString = self.arrayLists[3][@"urlString"];
    [self addChildViewController:vc4];
    SXTableViewController *vc8 = [[UIStoryboard storyboardWithName:@"News" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    vc8.title = @"娱乐";
    vc8.urlString = self.arrayLists[4][@"urlString"];
    [self addChildViewController:vc8];
    SXTableViewController *vc5 = [[UIStoryboard storyboardWithName:@"News" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    vc5.title = @"时尚";
    vc5.urlString = self.arrayLists[5][@"urlString"];
    [self addChildViewController:vc5];
    SXTableViewController *vc6 = [[UIStoryboard storyboardWithName:@"News" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    vc6.title = @"电影";
    vc6.urlString = self.arrayLists[6][@"urlString"];
    [self addChildViewController:vc6];
    SXTableViewController *vc7 = [[UIStoryboard storyboardWithName:@"News" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    vc7.title = @"科技";
    vc7.urlString = self.arrayLists[7][@"urlString"];
    [self addChildViewController:vc7];
}

/** 添加标题栏 */
- (void)addLable
{
    for (int i = 0; i < 8; i++) {
        CGFloat lblW = 70;
        CGFloat lblH = 30;
        CGFloat lblY = 0;
        CGFloat lblX = i * lblW;
        SXTitleLable *lbl1 = [[SXTitleLable alloc]init];
        UIViewController *vc = self.childViewControllers[i];
        lbl1.text =vc.title;
        lbl1.frame = CGRectMake(lblX, lblY, lblW, lblH);
        [self.smallScrollView addSubview:lbl1];
        lbl1.tag = i;
        lbl1.userInteractionEnabled = YES;
        
        [lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
    }
    self.smallScrollView.contentSize = CGSizeMake(70 * 8, 0);
    
}

/** 标题栏label的点击事件 */
- (void)lblClick:(UITapGestureRecognizer *)recognizer
{
    SXTitleLable *titlelable = (SXTitleLable *)recognizer.view;
    
//    NSUInteger index = self.bigScrollView.contentOffset.x / self.bigScrollView.frame.size.width;
    
//    self.oldTitleLable = self.smallScrollView.subviews[index];
//    self.beginOffsetX = self.bigScrollView.frame.size.width * index;
//    NSLog(@"%f %ld",self.beginOffsetX,index);
    
    
//    titlelable.textColor = [UIColor redColor];
//    titlelable.font = [UIFont systemFontOfSize:15];
    
    CGFloat offsetX = titlelable.tag * self.bigScrollView.frame.size.width;
   
    CGFloat offsetY = self.bigScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [self.bigScrollView setContentOffset:offset animated:YES];
    
    
}

#pragma mark - ******************** scrollView代理方法

/** 滚动结束后调用（代码导致） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bigScrollView.frame.size.width;
    
    // 滚动标题栏
    SXTitleLable *titleLable = (SXTitleLable *)self.smallScrollView.subviews[index];
    
    CGFloat offsetx = titleLable.center.x - self.smallScrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax = self.smallScrollView.contentSize.width - self.smallScrollView.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, self.smallScrollView.contentOffset.y);
    [self.smallScrollView setContentOffset:offset animated:YES];
    // 添加控制器
    SXTableViewController *newsVc = self.childViewControllers[index];
    newsVc.index = index;
    
    [self.smallScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            SXTitleLable *temlabel = self.smallScrollView.subviews[idx];
            temlabel.scale = 0.0;
        }
    }];
    
    if (newsVc.view.superview) return;
    
    newsVc.view.frame = scrollView.bounds;
    [self.bigScrollView addSubview:newsVc.view];
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    SXTitleLable *labelLeft = self.smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.smallScrollView.subviews.count) {
        SXTitleLable *labelRight = self.smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
    
}


@end
