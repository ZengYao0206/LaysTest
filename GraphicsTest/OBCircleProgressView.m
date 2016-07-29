//
//  OBCircleProgressView.m
//  Oband
//
//  Created by oband on 14-7-31.
//  Copyright (c) 2014年 Oband Tech. All rights reserved.
//

#import "OBCircleProgressView.h"

#define DefualtMax 500
#define Margin_top 10.0f
#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )
#define ToDeg(rad)		( (180.0 * (rad)) / M_PI )
#define SQR(x)			( (x) * (x) )
@interface OBCircleProgressView (){
    
    UILabel *unitLabel;
    
    //headView的frame
    CGRect _rect;
    
    //定时器，用来播放动画
    NSTimer *disPlayLink;
    
    //管理时钟
    float steps;
    
    //每次增加的值
    float incremental;
    
    //是否停止动画
    BOOL isFreeTime;
    
    //用来画圆弧的自动增量
    float nub;
    
    //每一卡路里所占的弧度
    float radianPerValue;
    
    //    UIBezierPath *path;
    float radius;
    UIView *arcView;
    BOOL isdrawArc;
}





//显示日期的Lable
@property (nonatomic,retain)UIButton *dateBtn;
//图层渲染对象
@property (nonatomic, retain)CAShapeLayer *trackLayer;
@property (nonatomic, retain)CAShapeLayer *BgArclayer;

@end

@implementation OBCircleProgressView
@synthesize percentage;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        arcView = [[UIView alloc] initWithFrame:self.bounds];
        arcView.backgroundColor = [UIColor clearColor];
        [self addSubview:arcView];
        _rect = frame;
        nub = 0.0;
        
        self.imageView = [[UIImageView alloc] init];
        
        UILabel *lable = [[UILabel alloc] init];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.backgroundColor = [UIColor clearColor];
        
        [arcView addSubview:lable];
        
        self.totalIntakeLable = lable;
        self.maxValuePerCircle = DefualtMax;
        self.backgroundColor = [UIColor clearColor];
        radianPerValue = (2 * M_PI / 100);
        [self setBackgroundColor:[UIColor clearColor]];
        CGSize size = _rect.size;
        CGFloat dateBtnMaxY = CGRectGetMaxY(self.dateBtn.frame);
        CGFloat dateBtnH = CGRectGetHeight(self.dateBtn.frame);
        self.imageView.frame = CGRectMake(0, Margin_top + dateBtnMaxY, size.width, (size.height -dateBtnH) - 2 * Margin_top);
        radius = self.imageView.frame.size.height/2;
        
        //标题-总摄入卡路里
        self.titleLable.center = CGPointMake(self.imageView.center.x, self.imageView.center.y - 30);
        self.titleLable.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.4);
        
        
        //摄入能量总量
        self.totalIntakeLable.center = self.imageView.center;
        self.totalIntakeLable.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.4);
        self.totalIntakeLable.text = @"";
        self.totalIntakeLable.textColor = [UIColor redColor];
        NSLog(@"%f",(50.0/70.0)*self.totalIntakeLable.frame.size.height);
        self.totalIntakeLable.font = [UIFont fontWithName:@"Cochin" size:(1.0/2.0)*self.totalIntakeLable.bounds.size.height];
        self.lineWith = 6.0;
        
        unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.totalIntakeLable.frame.size.height+self.totalIntakeLable.frame.origin.y-(1.0/2.0)*self.totalIntakeLable.bounds.size.height*0.35, self.frame.size.width-2*5, (1.0/2.0)*self.totalIntakeLable.bounds.size.height*0.35)];
        unitLabel.textAlignment = NSTextAlignmentCenter;
        unitLabel.font = [UIFont systemFontOfSize:(1.0/2.0)*self.totalIntakeLable.bounds.size.height*0.35];
        unitLabel.textColor = [UIColor redColor];
        [self addSubview:unitLabel];
        
        self.bgArcColor = [UIColor colorWithRed:253.0/255.0 green:219.0/255.0 blue:218.0/255.0 alpha:0.8];
        self.progressColor = [UIColor colorWithRed:252.0/255.0 green:54.0/255.0 blue:66.0/255.0 alpha:0.8];
        self.MaxColor = [UIColor greenColor];
    }
    return self;
}

-(void)setUnitString:(NSString *)unitString{
    
    _unitString = unitString;
    unitLabel.text = unitString;
    
}

-(void)playNumbers:(NSTimer *)displayLink2
{
    if (steps == 0) {
        isdrawArc = YES;
    }
    
    if (isFreeTime == NO || incremental == 0) {
        isdrawArc = NO;
        steps  = 0;
        [displayLink2 invalidate];
        return;
    }
    
    if (steps <= self.progessValue) {
        
        if (self.isShowPercent == YES) {
            
            self.totalIntakeLable.text = [NSString stringWithFormat:@"%.2f%%",(steps/100)*100.0];
            
        }else{
            
            self.totalIntakeLable.text = [NSString stringWithFormat:@"%d",(int)steps];
            
        }
        
        [self setNeedsDisplay];
        
    }else{
        
        if ([displayLink2 isValid]) {
            
            if ((steps - self.progessValue) < incremental) {
                if (self.isShowPercent == YES) {
                    self.totalIntakeLable.text = [NSString stringWithFormat:@"%.2f%%",(self.progessValue/100)*100.0];
                    
                }else{
                    
                    self.totalIntakeLable.text = [NSString stringWithFormat:@"%0.0f",self.progessValue];
                    
                }
                nub = self.progessValue;
                [self setNeedsDisplay];
            }
            
            steps = 0;
            [displayLink2 invalidate];
            isFreeTime = NO;
            //            isdrawArc = NO;
        }
        
    }
    
    steps +=incremental;
}

-(float)getPercentage{
    
    percentage = (self.progessValue/self.maxValuePerCircle);
    return percentage;
    
}

-(void)dealloc{
    
    [disPlayLink invalidate];
    
}

-(void)StopAnimation{
    
    if ([disPlayLink isValid]) {
        isdrawArc = NO;
        steps = 0;
        isFreeTime = NO;
        [disPlayLink invalidate];
    }
}


-(void)beginAnimationWithDuration:(float)time{
    
    [self.imageView removeFromSuperview];
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.frame = CGRectMake(0, Margin_top, self.frame.size.width, self.frame.size.height - 2 * Margin_top);
    [self addSubview:self.imageView];
    
    
    
    incremental = (self.progessValue/(time*20));
    
    NSLog(@"incremental:%2f   %2f",incremental,self.progessValue);
    
    steps  = 0.0;
    nub = 0.0;
    
    time = time/self.progessValue;
    if ([disPlayLink isValid]) {
        [disPlayLink invalidate];
    }
    if (incremental > self.maxValuePerCircle) {
        
        self.maxValuePerCircle = incremental*2;
    }
    
    radianPerValue = (2 * M_PI / 100);
    if (incremental>0) {
        @autoreleasepool {
            disPlayLink = [NSTimer scheduledTimerWithTimeInterval:1.0/20.0 target:self selector:@selector(playNumbers:) userInfo:nil repeats:YES];
            
            [[NSRunLoop mainRunLoop] addTimer:disPlayLink forMode:NSDefaultRunLoopMode];
        }
        isFreeTime = YES;
    }else{
        
        isFreeTime = YES;
        [self setNeedsDisplay];
    }
}


//重新绘制
- (void)drawRect:(CGRect)rect
{
    rect.origin.y = 0;
    rect.size.width = rect.size.width+1;
    if (self.frame.size.width > 130) {
        rect.size.width = rect.size.width+15;
        rect.size.height = rect.size.height+15;
    }
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self drawArc:ctx];
    
}

-(void)drawArc:(CGContextRef)ctx{
    
    CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, radius, 0, M_PI *2, 0);
    [self.bgArcColor setStroke];
    CGContextSetLineWidth(ctx, self.lineWith);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //画进度条
    if (nub > self.progessValue) {
        nub = self.progessValue;
    }
    float star = M_PI_2*3  +  (nub)  * radianPerValue;
    if (nub <= self.progessValue) {
        CGContextBeginPath(ctx);
        if (self.frame.size.width > 130) {
            CGContextAddArc(ctx, self.frame.size.width/2  , self.frame.size.height/2, radius, 3*M_PI/2, star, 0);
        }else{
            CGContextAddArc(ctx, self.frame.size.width/2  , self.frame.size.height/2, radius, 3*M_PI/2, star, 0);
        }
        
        [self.progressColor setStroke];
        
        CGContextSetLineWidth(ctx, self.lineWith);
        CGContextSetLineCap(ctx, kCGLineCapButt);
        CGContextDrawPath(ctx, kCGPathStroke);
        
        //画圆圈(红色圆点)
        [self drawHandle:ctx Angle: star];
    }

    if (nub > self.progessValue) {
        nub = 0;
    }else{
        
        nub +=incremental ;
    }
}

-(void) drawHandle:(CGContextRef)ctx Angle:(float)angle{
    
    CGContextSaveGState(ctx);
    CGPoint handleCenter =  [self pointFromAngle:angle];
    
    [self.progressColor set];
    
    CGContextFillEllipseInRect(ctx, CGRectMake(handleCenter.x-2.5, handleCenter.y-2.5, self.lineWith+5,  self.lineWith+5));
    CGContextSetLineWidth(ctx, self.lineWith);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    CGContextDrawPath(ctx, kCGPathStroke);
    CGContextRestoreGState(ctx);
}

-(CGPoint)pointFromAngle:(float)angleInt{
    
    //Define the Circle center
    
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2 -  self.lineWith/2, self.frame.size.height/2 -  self.lineWith/2);
    
    //Define The point position on the circumference
    CGPoint result;
    result.y = round(centerPoint.y + radius * sin((angleInt)));
    result.x = round(centerPoint.x + radius * cos((angleInt)));
    
    return result;
}

-(void)setHidden:(BOOL)hidden{
    
    super.hidden = hidden;
    _hidden = hidden;
    [self StopAnimation];
}


-(void)setProgessValue:(float)progessValue{
    
    _progessValue = progessValue;
    NSLog(@"progessValue:     mm      %f",progessValue);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.isShowPercent) {
            
            self.totalIntakeLable.text = [NSString stringWithFormat:@"%.2f%%",progessValue];
        }else{
            self.totalIntakeLable.text = [NSString stringWithFormat:@"%.2f",progessValue];
            
        }
    });
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
