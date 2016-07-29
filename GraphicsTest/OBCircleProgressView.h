//
//  OBCircleProgressView.h
//  Oband
//
//  Created by oband on 14-7-31.
//  Copyright (c) 2014年 Oband Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OBCircleProgressView : UIView

//标题-总摄入卡路里
@property (nonatomic,retain) UILabel *titleLable;

//摄入能量总量
@property (nonatomic,retain)UILabel *totalIntakeLable;

@property (nonatomic,setter = setUnitString:) NSString *unitString;

@property(nonatomic,getter=isHidden,setter = setHidden:) BOOL          hidden;

@property(nonatomic,readonly,getter = getPercentage) float percentage;
//圆圈
@property (nonatomic,retain) UIImageView *imageView;
//是否显示百分比还是显示数字 YES就显示百分比 NO显示数字
@property (nonatomic,assign) BOOL isShowPercent;
//headView的数据模型
//圆圈线的宽度
@property (nonatomic,assign) float lineWith;
//每一圈的最大值默认是500
@property (nonatomic,assign)  float  maxValuePerCircle;
//开始动画，动画时间
-(void)beginAnimationWithDuration:(float)time;
//停止动画
-(void)StopAnimation;

@property (nonatomic,assign) float progessValue;
//背景圆的颜色
@property (nonatomic,setter = setbgArcColor:) UIColor *bgArcColor;
//进度条的颜色
@property (nonatomic,strong) UIColor *progressColor;
//超过最大值的颜色
@property (nonatomic,strong) UIColor *MaxColor;

@end
