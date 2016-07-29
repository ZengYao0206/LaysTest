//
//  OBHistogramView.h
//  Oband
//
//  Created by oband on 14-8-1.
//  Copyright (c) 2014年 Oband Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OBHistogramView : UIView

@property (nonatomic,assign) int numberDay;
@property (nonatomic,strong)  UIColor *highColor;
@property (nonatomic,strong)  UIColor *lowColor;
@property (nonatomic,assign)  int maxValue;
@property (nonatomic,assign)  int minValue;
//0-1
@property (nonatomic,assign)  float spacingRatio;
@property (nonatomic,assign)  float marginLeft;
//array 里面是float型数据
-(void)showHistogramByData:(NSArray*)array;

@end
