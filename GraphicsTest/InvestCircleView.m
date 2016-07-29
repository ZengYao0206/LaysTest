//
//  InvestCircleView.m
//  Phyt
//
//  Created by RiQiangWang on 2016/7/26.
//  Copyright © 2016年 Shipeng. All rights reserved.
//

#import "InvestCircleView.h"
#import "UIColor+YW.h"
@interface InvestCircleView()
{
    CGRect _rect;
    
    //定时器，用来播放动画
    NSTimer * disPlayLink;
    
    //管理时钟
    float _steps;
    
    //每次增加的值
    float _incremental;
    
    //是否停止动画
    BOOL isFreeTime;
    
    //用来画圆弧的自动增量
    float _nub;
    
    //每一卡路里所占的弧度
    float _radianPerValue;
    
    //    UIBezierPath *path;
    float _radius;
    UIView *arcView;
    BOOL isdrawArc;
    
    UILabel *_rateLabel;
    UILabel *_titleLabel;
    
}

@end

@implementation InvestCircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _rect = frame;
        _nub = 0.0;
        _radius = 57.25;
        _radianPerValue = (2 * M_PI / 100);
        
        self.lineWith = 5.5;
        self.maxValuePerCircle = 500;
        
        _rateLabel = [[UILabel alloc]init];
        _rateLabel.textAlignment = NSTextAlignmentCenter;
        _rateLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_rateLabel];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"年化收益";
        _titleLabel.textColor = [UIColor colorWithHex:@"6666"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:_titleLabel];
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:65.75 startAngle:0 endAngle:M_PI / 180 * 360 clockwise:YES];
    ;
    [[UIColor orangeColor] setStroke];
    
    path.lineWidth = 11.5;
    [path stroke];
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 addArcWithCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:57.25 startAngle:0 endAngle:M_PI / 180 * 360 clockwise:YES];
    [self.bgArcColor setStroke];
    path1.lineWidth = 5.5;
    [path1 stroke];
    
//    UIBezierPath *path2 = [UIBezierPath bezierPath];
//    [path2 addArcWithCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:57.25 startAngle:M_PI / 180 * 270 endAngle:M_PI / 180 * 360 * _progress clockwise:YES];
//    [[UIColor greenColor] setStroke];
//    path2.lineWidth = 5.5;
//    [path2 stroke];
    
    _rateLabel.frame = CGRectMake(self.bounds.size.width / 2 - 50, self.bounds.size.height / 2 - 25, 100, 35);
    
    _titleLabel.frame = CGRectMake(_rateLabel.frame.origin.x, _rateLabel.frame.origin.y + _rateLabel.frame.size.height, _rateLabel.frame.size.height, 20);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self drawArc:ctx];
}

- (NSMutableAttributedString *)setStringWithDifferentFont:(NSString *)string {
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:34], NSForegroundColorAttributeName : [UIColor colorWithHex:@"ff702f"]} range:NSMakeRange(0, string.length - 1)];
    [attrString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:24], NSForegroundColorAttributeName : [UIColor colorWithHex:@"ff702f"]} range:NSMakeRange(string.length - 1, 1)];
    return attrString;
    
}

- (void)beginAnimationWithDuration:(float)time{
    
    _incremental = (self.progessValue/(time*20));
    
    _steps  = 0.0;
    _nub = 0.0;
    
    time = time/self.progessValue;
    if ([disPlayLink isValid]) {
        [disPlayLink invalidate];
    }
    if (_incremental > self.maxValuePerCircle) {
        
        self.maxValuePerCircle = _incremental*2;
    }
    
    _radianPerValue = (2 * M_PI / 100);
    if (_incremental>0) {
        @autoreleasepool {
            disPlayLink = [NSTimer scheduledTimerWithTimeInterval:1.0/20.0 target:self selector:@selector(changeNumbers:) userInfo:nil repeats:YES];
            
            [[NSRunLoop mainRunLoop] addTimer:disPlayLink forMode:NSDefaultRunLoopMode];
        }
        
        isFreeTime = YES;
    }else{
        
        isFreeTime = YES;
        [self setNeedsDisplay];
    }
    
}

-(void)changeNumbers:(NSTimer *)displayLink2
{
    if (_steps == 0) {
        isdrawArc = YES;
    }
    
    if (isFreeTime == NO || _incremental == 0) {
        isdrawArc = NO;
        _steps  = 0;
        [displayLink2 invalidate];
        return;
    }
    
    if (_steps <= self.progessValue) {
        _rateLabel.attributedText = [self setStringWithDifferentFont:[NSString stringWithFormat:@"%.2f",(_steps/100)]];
        [self setNeedsDisplay];
        
    }else{
        
        if ([displayLink2 isValid]) {
            
            if ((_steps - self.progessValue) < _incremental) {

                _rateLabel.attributedText = [self setStringWithDifferentFont:[NSString stringWithFormat:@"%.2f",(self.progessValue/100)]];
                _nub = self.progessValue;
                [self setNeedsDisplay];
            }
            
            _steps = 0;
            [displayLink2 invalidate];
            isFreeTime = NO;
            
        }
        
    }
    
    _steps += _incremental;
}

-(void)drawArc:(CGContextRef)ctx{
    
//    CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, _radius, 0, M_PI *2, 0);
//    [self.bgArcColor setStroke];
//    CGContextSetLineWidth(ctx, self.lineWith);
//    CGContextSetLineCap(ctx, kCGLineCapButt);
//    CGContextDrawPath(ctx, kCGPathStroke);
    
    //画进度条
    if (_nub > self.progessValue) {
        _nub = self.progessValue;
    }
    float star = M_PI_2*3  +  (_nub)  * _radianPerValue;
    if (_nub <= self.progessValue) {
        CGContextBeginPath(ctx);
        
        CGContextAddArc(ctx, self.frame.size.width/2  , self.frame.size.height/2, _radius, 3*M_PI/2, star, 0);
        
        [self.progressColor setStroke];
        
        CGContextSetLineWidth(ctx, self.lineWith);
        CGContextSetLineCap(ctx, kCGLineCapButt);
        CGContextDrawPath(ctx, kCGPathStroke);
        
        //画圆圈(红色圆点)
        [self drawHandle:ctx Angle: star];
    }
    
    if (_nub > self.progessValue) {
        _nub = 0;
    }else{
        
        _nub += _incremental ;
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
    result.y = round(centerPoint.y + _radius * sin((angleInt)));
    result.x = round(centerPoint.x + _radius * cos((angleInt)));
    
    return result;
}

-(void)StopAnimation{
    
    if ([disPlayLink isValid]) {
        isdrawArc = NO;
        _steps = 0;
        isFreeTime = NO;
        [disPlayLink invalidate];
    }
}

-(void)setHidden:(BOOL)hidden{
    
    super.hidden = hidden;
    [self StopAnimation];
}

-(void)setProgessValue:(float)progessValue{
    
    _progessValue = progessValue;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _rateLabel.attributedText = [self setStringWithDifferentFont:[NSString stringWithFormat:@"%.2f",(self.progessValue/100)]];
    });
    
}


@end
