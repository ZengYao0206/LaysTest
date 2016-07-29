//
//  PNBar.m
//  PNChartDemo
//
//  Created by yiyaowang on 10/19/15.
//  Copyright (c) 2015年 zengyao. All rights reserved.
//

#import "OBPNBar.h"
#import "OBPNColor.h"

@implementation OBPNBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
		_chartLine = [CAShapeLayer layer];
		_chartLine.lineCap = kCALineCapSquare;
		//_chartLine.fillColor   = [[UIColor greenColor] CGColor];
		_chartLine.lineWidth   = self.frame.size.width-.1;
		_chartLine.strokeEnd   = 0.0;
		self.clipsToBounds = YES;
		[self.layer addSublayer:_chartLine];
		//self.layer.cornerRadius = 2.0;
        self.backgroundColor =[UIColor clearColor];
    }
    return self;
}

-(void)setGrade:(float)grade
{
	_grade = grade;
//    NSLog(@"grade ={%f}",grade);
	UIBezierPath *progressline = [UIBezierPath bezierPath];
    
    [progressline moveToPoint:CGPointMake(self.frame.size.width/2.0, self.frame.size.height)];
	[progressline addLineToPoint:CGPointMake(self.frame.size.width/2.0, (1 - grade) * self.frame.size.height)];
	
    [progressline setLineWidth:1.0];
	_chartLine.path = progressline.CGPath;

	if (_barColor) {
		_chartLine.strokeColor = [_barColor CGColor];
        [_chartLine setFillColor:[_barColor CGColor]];
	}else{
		//_chartLine.strokeColor = [PNGreen CGColor];
	}
//    [_barColor set];
//    [progressline stroke];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.2;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.1f];
    pathAnimation.delegate = self;
    pathAnimation.toValue = [NSNumber numberWithFloat:0.8f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
      _chartLine.strokeEnd = 1.0;
}


-(void)setGradeNOAnimation:(float)grade
{
	_grade = grade;
    //    NSLog(@"grade ={%f}",grade);
	UIBezierPath *progressline = [UIBezierPath bezierPath];
    
    [progressline moveToPoint:CGPointMake(self.frame.size.width/2.0, self.frame.size.height)];
	[progressline addLineToPoint:CGPointMake(self.frame.size.width/2.0, (1 - grade) * self.frame.size.height)];
	
    [progressline setLineWidth:1.0];
	_chartLine.path = progressline.CGPath;
    
	if (_barColor) {
		_chartLine.strokeColor = [_barColor CGColor];
        [_chartLine setFillColor:[_barColor CGColor]];
	}else{
		//_chartLine.strokeColor = [PNGreen CGColor];
	}
//    [_barColor set];
//    [progressline stroke];
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 0.3;
//    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue = [NSNumber numberWithFloat:1.1f];
////    pathAnimation.delegate = self;
//    pathAnimation.toValue = [NSNumber numberWithFloat:0.8f];
//    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//    pathAnimation.autoreverses = NO;
//    [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    _chartLine.strokeEnd = 1.0;
}


#pragma mark 动画开始
- (void)animationDidStart:(CAAnimation *)anim {
//     NSLog(@"动画开始了");
   
}

#pragma mark 动画结束
 - (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

     CGRect rect = self.frame;
     self.frame = CGRectMake(rect.origin.x, rect.origin.y+rect.size.height*0.7, rect.size.width, rect.size.height-rect.size.height*0.7);
     [UIView animateWithDuration:1.0/8 animations:^{
     self.frame = CGRectMake(rect.origin.x, rect.origin.y+rect.size.height*1.1, rect.size.width, rect.size.height-rect.size.height*1.1);
         
     } completion:^(BOOL finished){
         if (finished) {
             
             [UIView animateWithDuration:1.0/16 animations:^{
             self.frame = CGRectMake(rect.origin.x, rect.origin.y+rect.size.height*0.9, rect.size.width, rect.size.height-rect.size.height*0.9);
             
             } completion:^(BOOL finished){
                 
                 [UIView animateWithDuration:0.2 animations:^{
                  self.frame = rect;
                     
                 }];
             }];
         }
         
     }];
 }

@end
