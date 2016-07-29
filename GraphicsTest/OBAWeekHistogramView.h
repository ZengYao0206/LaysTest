//
//  OBAWeekHistogramView.h
//  Oband
//
//  Created by oband on 14-8-1.
//  Copyright (c) 2014年 Oband Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OBHistogramView.h"
@interface OBAWeekHistogramView : UIView


@property (nonatomic,strong) UILabel      *title;
@property (nonatomic,strong) UILabel       *note;
@property (nonatomic,strong) OBHistogramView *mHistogramView;
@property (nonatomic,strong) NSArray *arrayStrX;
@property (nonatomic,strong) NSArray *arrayStrY;
//@property  (nonatomic,strong) NSDictionary *dataDiction;
//为了解决日期排序
@property  (nonatomic,strong) NSMutableArray *dataOfDateArray;
@property  (nonatomic,strong) NSMutableArray *dateArray;


-(void)updataToHistogram;

@end
