//
//  PNBar.h
//  PNChartDemo
//
//  Created by yiyaowang on 10/19/15.
//  Copyright (c) 2015年 zengyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface OBPNBar : UIView

@property (nonatomic) float grade;

@property (nonatomic,strong) CAShapeLayer * chartLine;

@property (atomic, retain) UIColor * barColor;

-(void)setGradeNOAnimation:(float)grade;

@end
