//
//  InvestCircleView.h
//  Phyt
//
//  Created by RiQiangWang on 2016/7/26.
//  Copyright © 2016年 Shipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestCircleView : UIView

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) CGFloat returnRate;

@property (nonatomic,assign)  float  maxValuePerCircle;

@property (nonatomic,assign) float progessValue;

//圆圈线的宽度
@property (nonatomic,assign) float lineWith;

//背景圆的颜色
@property (nonatomic,setter = setbgArcColor:) UIColor *bgArcColor;
//进度条的颜色
@property (nonatomic,strong) UIColor *progressColor;
//超过最大值的颜色
@property (nonatomic,strong) UIColor *MaxColor;

//开始动画，动画时间
- (void)beginAnimationWithDuration:(float)time;

//停止动画
-(void)StopAnimation;

@end
