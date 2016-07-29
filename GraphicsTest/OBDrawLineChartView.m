//
//  DrawLineChartView.m
//  绘图测试
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

//运动   睡眠  饮食的目标值
#define KMaxMove 5000

#define KMaxDiet 3000

#define KMaxSleep 7.5


#import "OBDrawLineChartView.h"

@interface OBDrawLineChartView()
{
    UILabel* topLabel;
}

@property (nonatomic, retain) UIImageView *imageView;

@end

@implementation OBDrawLineChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.userInteractionEnabled = NO;
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"food_default_image.png"];
        
        [self addSubview:imageView];
        self.imageView = imageView;
        
        topLabel = [[UILabel alloc]init];
        topLabel.backgroundColor = [UIColor clearColor];
        topLabel.font = [UIFont systemFontOfSize:11];
        topLabel.textColor = [UIColor lightGrayColor];
        [topLabel sizeToFit];
        [self addSubview:topLabel];
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [self drawLine];
}


-(void) setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    [self setNeedsDisplay];
}



#pragma mark 绘制直线
- (void)drawLine
{
    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    //计算比例每天占有的宽度   x轴
    CGFloat xBiLi = width / (_dataArr.count - 1);
    
    
    self.imageView.frame = CGRectMake(xBiLi + 2, 20, 15, 15);
    topLabel.frame = CGRectMake(xBiLi+1, 0, 35, 20);
    
    //y轴
    CGFloat k;
    
    //线颜色的RGB值   和  填充颜色的RGB值
    
    NSMutableArray *lineColor = [NSMutableArray array];
    NSMutableArray *fillColor = [NSMutableArray array];
    
    
    NSMutableArray *leftIcons = [NSMutableArray arrayWithObjects:
                                 @"home_move_icon.png",@"home_sleep_icon.png",@"home_diet_icon.png", nil];
    
    
    if (self.index == 0) {
        k = KMaxMove;
        //237  93  100   线
        [lineColor addObject:@"237"];
        [lineColor addObject:@"93"];
        [lineColor addObject:@"100"];
        //252 236  237
        [fillColor addObject:@"252"];
        [fillColor addObject:@"236"];
        [fillColor addObject:@"237"];
        
        self.imageView.image = [UIImage imageNamed:leftIcons[0]];
        topLabel.text = topLabel.text = [NSString stringWithFormat:@"%d",KMaxMove];
    }
    if (self.index == 1){
        k = KMaxSleep;
        //92  201  234   线
        [lineColor addObject:@"92"];
        [lineColor addObject:@"201"];
        [lineColor addObject:@"234"];
        //236 250  253
        [fillColor addObject:@"236"];
        [fillColor addObject:@"250"];
        [fillColor addObject:@"253"];
        
        self.imageView.image = [UIImage imageNamed:leftIcons[1]];
        topLabel.text = [NSString stringWithFormat:@"%.2f",KMaxSleep];
    }
    if (self.index == 2){
        k = KMaxDiet;
        //240  154  16   线
        [lineColor addObject:@"240"];
        [lineColor addObject:@"154"];
        [lineColor addObject:@"16"];
        //253 244  230
        [fillColor addObject:@"255"];
        [fillColor addObject:@"255"];
        [fillColor addObject:@"230"];
        
        self.imageView.image = [UIImage imageNamed:leftIcons[2]];
        topLabel.text = [NSString stringWithFormat:@"%d",KMaxDiet];
    }
    
    CGFloat yBiLi = self.frame.size.height / k;
    
    
    // 1. 获取一个与视图相关联的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
   
    
    
    
//一  竖线
    for (NSInteger i = 0; i < _dataArr.count; i++) {
        NSLog(@"%lu",(unsigned long)_dataArr.count);
        
        // 保存当前上下文
        CGContextSaveGState(context);
            
        
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, (i + 1) * xBiLi - 1, 0);
        
        CGPathAddLineToPoint(path, NULL, (i + 1) * xBiLi - 1, self.frame.size.height);
        // 关闭路径
        CGPathCloseSubpath(path);
        CGContextAddPath(context, path);
        
        CGContextSetRGBStrokeColor(context, 239.0 / 255.0, 221.0 / 255.0, 221.0 / 255.0, 1);
        CGContextDrawPath(context, kCGPathStroke);
        CGPathRelease(path);
        
        // 恢复上下文
        CGContextRestoreGState(context);
    
    }
    
    
    
//二  横线
    
    
    //  保存当前上下文
//    CGContextSaveGState(context);
//    
//    CGContextBeginPath(context);
//    CGContextMoveToPoint(context, 0, self.frame.size.height -30);
//    CGContextAddLineToPoint(context, width + xBiLi, self.frame.size.height -30);
//
//    CGContextSetRGBStrokeColor(context, 239.0 / 255.0, 221.0 / 255.0, 221.0 / 255.0, 1);
//    CGContextSetRGBStrokeColor(context, 230.0 / 255.0,72.0 / 255.0, 63.0 / 255.0, 1);
//    CGContextStrokePath(context);
//    
//    //  恢复上下文
//    CGContextRestoreGState(context);
    
    
    
    
// 三 折线图路径
    
    //保存当前上下文
    CGContextSaveGState(context);

    CGMutablePathRef path = CGPathCreateMutable();

    CGPathMoveToPoint(path, NULL, 0, self.frame.size.height);
    for (NSInteger i = 0; i < _dataArr.count; i++) {
        
        CGFloat y = self.frame.size.height - [_dataArr[i] floatValue] * yBiLi;
        if (y < 3) {
            y = 3;
        }
        
        if ([_dataArr[i] floatValue] == 0) {  
            
            CGPathAddLineToPoint(path, NULL, (i) * xBiLi - 1, self.frame.size.height);
            CGPathAddLineToPoint(path, NULL, (i) * xBiLi - 1, self.frame.size.height);
        }
        
        CGPathAddLineToPoint(path, NULL, (i) * xBiLi - 1, y);
    }
    
    CGPathAddLineToPoint(path, NULL, _dataArr.count * xBiLi, self.frame.size.height);
    // 关闭路径
    CGPathCloseSubpath(path);
    CGContextAddPath(context, path);
    //CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextSetRGBStrokeColor(context, [lineColor[0] floatValue] / 255.0, [lineColor[1] floatValue] / 255.0, [lineColor[2] floatValue] / 255.0, 1);
    CGContextSetRGBFillColor(context, [fillColor[0] floatValue] / 255.0, [fillColor[1] floatValue] / 255.0, [fillColor[2] floatValue] / 255.0, 0.4);
    CGContextSetLineWidth(context, 1.5);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGPathRelease(path);
    
    //恢复上下文
    CGContextRestoreGState(context);
    
}


@end



