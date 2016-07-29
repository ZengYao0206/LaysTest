//
//  DrawLineChartView.h
//  绘图测试
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 apple. All rights reserved.


//-------画一条折线的View

#import <UIKit/UIKit.h>

@interface OBDrawLineChartView : UIView


//需要画的数值
@property (nonatomic, retain) NSArray *dataArr;  //得多给一天的数据


//是画什么数据  0 - 代表运动  1 - 代表睡眠  2 - 代表饮食
@property (nonatomic, assign) NSInteger index;



@end
